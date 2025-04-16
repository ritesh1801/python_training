class LowCreditScoreException(Exception):
    def __init__(self, message="Credit score too low to approve the loan"):
        super().__init__(message)
