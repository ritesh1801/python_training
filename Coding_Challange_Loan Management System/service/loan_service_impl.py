from dao.loan_repository_impl import LoanRepositoryImpl
from service.loan_service import ILoanService
from entity.loan import Loan

class LoanServiceImpl(ILoanService):
    
    def __init__(self):
        self.loan_repository = LoanRepositoryImpl()

    def apply_loan(self, loan: Loan):
        self.loan_repository.apply_loan(loan)
        
    def calculate_interest(self, loan_id: str):
        return self.loan_repository.calculate_interest(loan_id)
    
    def loan_status(self, loan_id: str):
        self.loan_repository.loan_status(loan_id)
    
    def calculate_emi(self, loan_id: str):
        return self.loan_repository.calculate_emi(loan_id)
    
    def loan_repayment(self, loan_id: str, amount: float):
        self.loan_repository.loan_repayment(loan_id, amount)
    
    def get_all_loans(self):
        self.loan_repository.get_all_loans()
    
    def get_loan_by_id(self, loan_id: str):
        self.loan_repository.get_loan_by_id(loan_id)
