from entity.customer import Customer

class Loan:
    def __init__(self, loan_id, customer, principal_amount, interest_rate, loan_term, loan_type = None, loan_status="Pending", property_address="", property_value=""):
        self.loan_id = loan_id
        self.customer = customer
        self.principal_amount = principal_amount
        self.interest_rate = interest_rate
        self.loan_term = loan_term
        self.loan_status = loan_status
        self.loan_type = loan_type
        

class HomeLoan(Loan):
    def __init__(self, property_address="", property_value=0, **args):
        super().__init__(**args)
        self.property_address = property_address
        self.property_value = property_value
        self.loan_type = "HomeLoan"

class CarLoan(Loan):
    def __init__(self, car_model="", car_value=0, **args):
        super().__init__(**args)
        self.car_model = car_model
        self.car_value = car_value
        self.loan_type = "CarLoan"

