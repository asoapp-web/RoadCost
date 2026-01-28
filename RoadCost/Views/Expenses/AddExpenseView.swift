import SwiftUI

struct AddExpenseView: View {
    @StateObject var viewModel: AddExpenseViewModel
    @Binding var isPresented: Bool
    var onSave: () -> Void
    
    init(viewModel: AddExpenseViewModel, isPresented: Binding<Bool>, onSave: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isPresented = isPresented
        self.onSave = onSave
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            OrbitalCirclesView()
            
            VStack(spacing: 24) {
                // Header
                HStack {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.white.opacity(0.6))
                    }
                    Spacer()
                    Text("New Expense")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Spacer()
                    Button(action: {
                        viewModel.saveExpense()
                        onSave()
                        isPresented = false
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(viewModel.isValid ? Color.accentYellow : .white.opacity(0.3))
                    }
                    .disabled(!viewModel.isValid)
                }
                .padding()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Amount
                        VStack(alignment: .leading) {
                            Text("Amount")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.6))
                                .padding(.leading)
                            
                            AmountTextField(text: $viewModel.amount)
                        }
                        
                        // Category
                        VStack(alignment: .leading) {
                            Text("Category")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.6))
                                .padding(.leading)
                            
                            CategoryPickerView(selection: $viewModel.selectedCategory)
                                .padding()
                                .glassCard()
                        }
                        
                        // Date
                        DatePickerView(date: $viewModel.selectedDate)
                        
                        // Note
                        VStack(alignment: .leading) {
                            Text("Note")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.6))
                                .padding(.leading)
                            
                            HStack {
                                Image(systemName: "note.text")
                                    .foregroundStyle(Color.accentYellow)
                                
                                CustomTextField(
                                    text: $viewModel.note,
                                    placeholder: "Expense description",
                                    placeholderColor: UIColor(Color.accentYellow.opacity(0.6)),
                                    textColor: .white,
                                    fontSize: 17,
                                    fontWeight: .regular,
                                    keyboardType: .default,
                                    textAlignment: .left
                                )
                            }
                            .padding()
                            .glassCard()
                        }
                    }
                    .padding()
                }
            }
        }
        .onChange(of: viewModel.amount) { _, _ in
            viewModel.validateForm()
        }
    }
}
