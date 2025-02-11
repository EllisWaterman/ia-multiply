import SwiftUI

struct DetailView: View {
    @State var input: String = ""
    @State var userInput: String = ""
    @State var currentQuestion = Question()
    @State var errorMessage = ""
    @State var numQuestions = 0
    @FocusState private var isTextFieldFocused: Bool
    var delay: TimeInterval = 1.0
    @State var isActive = false

    var body: some View {
        NavigationStack {
            VStack {
                Text(errorMessage)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30))
                Text(currentQuestion.equation)
                
                TextField(
                    "Enter Answer",
                    text: $input
                )
                .disableAutocorrection(true)
                .border(.secondary)
                .keyboardType(.numberPad)
                .padding()
                .frame(width: 200)
                .focused($isTextFieldFocused)
                .onAppear {
                           isTextFieldFocused = true
                       }
                .onChange(of: input) { newValue in
                    if !newValue.isEmpty {
                        if newValue.trimmingCharacters(in: .whitespacesAndNewlines) == currentQuestion.answer {
                            currentQuestion = Question()
                            errorMessage = "Correct!\nTry this one:"
                            input = ""
                            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                errorMessage = ""
                            }
                            numQuestions += 1
                            if numQuestions >= 10 {
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                    isActive = true
                                }
                            }
                        } else if newValue.count == currentQuestion.answer.count {
                            errorMessage = "Incorrect.\nTry again."
                            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                errorMessage = ""
                            }
                        }
                    }
                }
                
                .navigationDestination(isPresented: $isActive) {
                    ContentView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}
