class Customer:
    def __init__(self, customer_id=None, name="", email="", phone="", address="", credit_score=0):
        if not isinstance(credit_score, (int, float)) or credit_score < 0:
            raise ValueError("Credit score must be a positive number.")
        
        self.customer_id = customer_id
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
        self.credit_score = credit_score