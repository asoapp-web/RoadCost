import SwiftUI
import Combine

final class AddExpenseViewModel: ObservableObject {
    @Published var amount: String = ""
    @Published var selectedCategory: ExpenseCategory = .food
    @Published var selectedDate: Date = Date()
    @Published var note: String = ""
    @Published var isPresented: Bool = false
    @Published var isValid: Bool = false
    
    private let dataManager: DataManager
    var onSave: (() -> Void)?
    
    init(dataManager: DataManager = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func validateForm() {
        isValid = Double(amount) != nil && !amount.isEmpty
    }
    
    func saveExpense() {
        guard let amountValue = Double(amount) else { return }
        
        let expense = Expense(
            amount: amountValue,
            category: selectedCategory,
            date: selectedDate,
            note: note.isEmpty ? nil : note
        )
        
        do {
            try dataManager.saveExpense(expense)
            onSave?()
            resetForm()
            isPresented = false
        } catch {
            print("Error saving expense: \(error)")
        }
    }
    
    func resetForm() {
        amount = ""
        selectedCategory = .food
        selectedDate = Date()
        note = ""
        isValid = false
    }
}
