from abc import ABC, abstractmethod
from entity.loan import Loan

class ILoanService(ABC):
    
    @abstractmethod
    def apply_loan(self, loan: Loan):
        pass

    @abstractmethod
    def calculate_interest(self, loan_id: str):
        pass
    
    @abstractmethod
    def loan_status(self, loan_id: str):
        pass
    
    @abstractmethod
    def calculate_emi(self, loan_id: str):
        pass

    @abstractmethod
    def loan_repayment(self, loan_id: str, amount: float):
        pass
    
    @abstractmethod
    def get_all_loans(self):
        pass

    @abstractmethod
    def get_loan_by_id(self, loan_id: str):
        pass
