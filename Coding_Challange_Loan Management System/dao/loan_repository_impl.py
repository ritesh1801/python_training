from dao.loan_repository import ILoanRepository
from entity.loan import HomeLoan
from entity.loan import CarLoan
from myexceptions.invalid_loan_exception import InvalidLoanException
from myexceptions.low_credit_score_exception import LowCreditScoreException
from util.db_conn_util import DBConnUtil

class LoanRepositoryImpl(ILoanRepository):

    def __init__(self):
        self.conn = DBConnUtil.get_connection()

    def apply_loan(self, loan):
        try:
            cursor = self.conn.cursor()
            confirm = input("Do you want to apply for the loan? (Yes/No): ")
            if confirm.lower() != "yes":
                print("Loan application cancelled.")
                return

            cursor.execute("""
                INSERT INTO Customer (name, email, phone, address, credit_score)
                OUTPUT INSERTED.customer_id
                VALUES (?, ?, ?, ?, ?)
            """, (
                loan.customer.name,
                loan.customer.email,
                loan.customer.phone,
                loan.customer.address,
                loan.customer.credit_score
            ))
            customer_id = cursor.fetchone()[0]

            cursor.execute("""
                INSERT INTO Loan (customer_id, principal_amount, interest_rate, loan_term, loan_type, loan_status)
                OUTPUT INSERTED.loan_id
                VALUES (?, ?, ?, ?, ?, ?)
            """, (
                customer_id,
                loan.principal_amount,
                loan.interest_rate,
                loan.loan_term,
                loan.loan_type,
                loan.loan_status
            ))
            loan_id = cursor.fetchone()[0]
            
            if isinstance(loan, HomeLoan):
                cursor.execute("""
                    INSERT INTO HomeLoan (loan_id, property_address, property_value)
                    VALUES (?, ?, ?)
                """, (loan_id, loan.property_address, loan.property_value))
            
            elif isinstance(loan, CarLoan):
                cursor.execute("""
                    INSERT INTO CarLoan (loan_id, car_model, car_value)
                    VALUES (?, ?, ?)
                """, (loan_id, loan.car_model, loan.car_value))

            self.conn.commit()
            print("Loan application submitted successfully with status: Pending")

        except Exception as e:
            self.conn.rollback()
            print(f"Error while applying loan: {e}")

    def calculate_interest(self, loan_id):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT principal_amount, interest_rate, loan_term FROM Loan WHERE loan_id = ?", (loan_id,))
            result = cursor.fetchone()

            if result is None:
                raise InvalidLoanException(f"Loan with ID {loan_id} not found.")

            principal, rate, term = result
            interest = self.calculate_interest_with_params(principal, rate, term)
            print(f"Interest Amount for Loan ID {loan_id}: ₹{interest:.2f}")
            return interest

        except InvalidLoanException as e:
            print(f"InvalidLoanException: {e}")
        except Exception as e:
            print(f"Error calculating interest: {e}")

    def calculate_interest_with_params(self, principal, rate, term):
        return (principal * rate * term) / 12

    def loan_status(self, loan_id):
        try:
            cursor = self.conn.cursor()
            cursor.execute("""
                SELECT credit_score 
                FROM Customer 
                WHERE customer_id IN (SELECT customer_id FROM Loan WHERE loan_id = ?)
            """, (loan_id,))
            result = cursor.fetchone()

            if result is None or result[0] is None:
              raise InvalidLoanException(f"Loan with ID {loan_id} not found or credit score is missing.")
            credit_score = result[0]
            status = "Approved" if credit_score >= 650 else "Rejected"

            cursor.execute("UPDATE Loan SET loan_status = ? WHERE loan_id = ?", (status, loan_id))
            self.conn.commit()
            print(f"Loan status updated to: {status}")

        except InvalidLoanException as e:
            print(f"InvalidLoanException: {e}")
        except Exception as e:
            print(f"Error updating loan status: {e}")

    def calculate_emi(self, loan_id):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT principal_amount, interest_rate, loan_term FROM Loan WHERE loan_id = ?", (loan_id,))
            result = cursor.fetchone()

            if result is None:
                raise InvalidLoanException(f"Loan with ID {loan_id} not found.")

            principal, rate, term = result
            emi = self.calculate_emi_with_params(principal, rate, term)
            print(f"EMI for Loan ID {loan_id}: ₹{emi:.2f}")
            return emi

        except InvalidLoanException as e:
            print(f"InvalidLoanException: {e}")
        except Exception as e:
            print(f"Error calculating EMI: {e}")

    def calculate_emi_with_params(self, principal, rate, term):
        monthly_rate = rate / 12 / 100
        emi = (principal * monthly_rate * ((1 + monthly_rate) ** term)) / (((1 + monthly_rate) ** term) - 1)
        return emi

    def loan_repayment(self, loan_id, amount):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT principal_amount, interest_rate, loan_term FROM Loan WHERE loan_id = ?", (loan_id,))
            result = cursor.fetchone()

            if result is None:
                raise InvalidLoanException(f"Loan with ID {loan_id} not found.")

            principal, rate, term = result
            emi = self.calculate_emi_with_params(principal, rate, term)

            if amount < emi:
                print(f"Amount ₹{amount} is less than one EMI ₹{emi:.2f}. Payment rejected.")
                return

            no_of_emis = int(amount // emi)
            remaining = amount - (no_of_emis * emi)
            print(f"Payment Accepted. Number of EMIs paid: {no_of_emis}. Remaining unallocated amount: ₹{remaining:.2f}")

        except InvalidLoanException as e:
            print(f"InvalidLoanException: {e}")
        except Exception as e:
            print(f"Error processing loan repayment: {e}")

    def get_all_loans(self):
        try:
            cursor = self.conn.cursor()
            cursor.execute("""
                SELECT l.loan_id, l.loan_type, l.loan_status, l.principal_amount, l.interest_rate, l.loan_term,
                       c.customer_id, c.name, c.credit_score
                FROM Loan l
                JOIN Customer c ON l.customer_id = c.customer_id
            """)
            loans = cursor.fetchall()

            if not loans:
                print("No loans found.")
                return

            for loan in loans:
                print(f"""
Loan ID: {loan[0]}, Type: {loan[1]}, Status: {loan[2]}
Amount: ₹{loan[3]}, Rate: {loan[4]}%, Term: {loan[5]} months
Customer ID: {loan[6]}, Name: {loan[7]}, Credit Score: {loan[8]}
                """)
        except Exception as e:
            print(f"Error retrieving loans: {e}")

    def get_loan_by_id(self, loan_id):
        try:
            cursor = self.conn.cursor()
            cursor.execute("""
                SELECT l.loan_id, l.loan_type, l.loan_status, l.principal_amount, l.interest_rate, l.loan_term,
                       c.customer_id, c.name, c.email, c.phone, c.address, c.credit_score
                FROM Loan l
                JOIN Customer c ON l.customer_id = c.customer_id
                WHERE l.loan_id = ?
            """, (loan_id,))
            loan = cursor.fetchone()

            if loan is None:
                raise InvalidLoanException(f"Loan with ID {loan_id} not found.")

            print(f"""
Loan ID: {loan[0]}, Type: {loan[1]}, Status: {loan[2]}
Amount: ₹{loan[3]}, Interest Rate: {loan[4]}%, Term: {loan[5]} months
Customer ID: {loan[6]}, Name: {loan[7]}, Email: {loan[8]}, Phone: {loan[9]}
Address: {loan[10]}, Credit Score: {loan[11]}
            """)

        except InvalidLoanException as e:
            print(f"InvalidLoanException: {e}")
        except Exception as e:
            print(f"Error retrieving loan by ID: {e}")
