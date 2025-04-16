class InvalidRepaymentException(Exception):
    def __init__(self, message="The repayment amount is invalid"):
        self.message = message
        super().__init__(self.message)
    
    def __str__(self):
        return f"InvalidRepaymentException: {self.message}"