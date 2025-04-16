from entity.customer import Customer
from entity.loan import HomeLoan, CarLoan
from service.loan_service_impl import LoanServiceImpl

def main():
    service = LoanServiceImpl()
    
    while True:
        print("\n--- Loan Management System ---")
        print("1. Apply for Loan")
        print("2. Calculate Interest")
        print("3. Check Loan Status")
        print("4. Calculate EMI")
        print("5. Make Loan Repayment")
        print("6. View All Loans")
        print("7. View Loan by ID")
        print("8. Exit")
        
        choice = input("Enter your choice (1-8): ")
        
        if choice == '1':
            try:
                customer_id = int(input("Enter Customer ID: "))
                name = input("Enter Name: ")
                email = input("Enter Email: ")
                phone = input("Enter Phone: ")
                address = input("Enter Address: ")
                
                try:
                 credit_score = int(input("Enter credit Score: "))
                 if credit_score < 300 or credit_score > 850:
                    print("credit score should be between 300 and 850.")
                    continue
                except ValueError:
                    print("credit score must be a number.")
                    continue
                
                customer = Customer(customer_id, name, email, phone, address, credit_score)
                
                loan_id = int(input("Enter Loan ID: "))
                principal = float(input("Enter Principal Amount: "))
                rate = float(input("Enter Interest Rate (%): "))
                term = int(input("Enter Loan Term (months): "))
                loan_type = input("Enter Loan Type (HomeLoan/CarLoan): ").lower()
                loan_status = "Pending"
                
                if loan_type == "homeloan":
                    property_address = input("Enter Property Address: ")
                    property_value = float(input("Enter Property Value: "))
                    loan = HomeLoan(
                        loan_id=loan_id,
                        customer=customer,
                        principal_amount=principal,
                        interest_rate=rate,
                        loan_term=term,
                        loan_status=loan_status,
                        property_address=property_address,
                        property_value=property_value
                    )
                elif loan_type == "carloan":
                    car_model = input("Enter Car Model: ")
                    car_value = float(input("Enter Car Value: "))
                    loan = CarLoan(
                        loan_id=loan_id,
                        customer=customer,
                        principal_amount=principal,
                        interest_rate=rate,
                        loan_term=term,
                        loan_status=loan_status,
                        car_model=car_model,
                        car_value=car_value
                    )
                else:
                    print("Invalid loan type.")
                    continue
                
                
                service.apply_loan(loan)
            
            except ValueError as e:
                print(f"Invalid input: {e}")
            except Exception as e:
                print(f"Error: {e}")
        
        elif choice == '2':
            try:
                loan_id = int(input("Enter Loan ID to calculate interest: "))
                service.calculate_interest(loan_id)
            except ValueError:
                print("Loan ID must be a number.")
        
        elif choice == '3':
            try:
                loan_id = int(input("Enter Loan ID to check status: "))
                service.loan_status(loan_id)
            except ValueError:
                print("Loan ID must be a number.")
        
        elif choice == '4':
            try:
                loan_id = int(input("Enter Loan ID to calculate EMI: "))
                service.calculate_emi(loan_id)
            except ValueError:
                print("Loan ID must be a number.")
        
        elif choice == '5':
            try:
                loan_id = int(input("Enter Loan ID for repayment: "))
                amount = float(input("Enter Repayment Amount: "))
                service.loan_repayment(loan_id, amount)
            except ValueError:
                print("Invalid input. Loan ID must be a number and amount must be a valid currency value.")
        
        elif choice == '6':
            service.get_all_loans()
        
        elif choice == '7':
            try:
                loan_id = int(input("Enter Loan ID to view details: "))
                service.get_loan_by_id(loan_id)
            except ValueError:
                print("Loan ID must be a number.")
        
        elif choice == '8':
            print("Exiting Loan Management System. Goodbye!")
            break
        
        else:
            print("Invalid choice. Please select between 1 and 8.")

if __name__ == "__main__":
    main()