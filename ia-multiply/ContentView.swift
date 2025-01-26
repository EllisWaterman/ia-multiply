import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var answer: String = ""
    @State private var userInput: String = ""
    @State var currentQuestion = Question();
    @State var errorMessage = ""
    var body: some View {
        Text(currentQuestion.equation)
        Text(errorMessage)
        TextField(
            "Enter Answer",
            text: $answer
        ).disableAutocorrection(true)
        .border(.secondary)
        .keyboardType(.numberPad)
        .padding()
        .frame(width: 200)
        .onChange(of: answer) {
            if (!answer.isEmpty){
                if (Int(answer) == currentQuestion.factor0 * currentQuestion.factor1){
                    currentQuestion = Question()
                    errorMessage = "Correct!\nTry this one:"
                    answer = ""
                } else {
                    errorMessage = "Incorrect.\nTry again."
                }
            }
        }
        
    }
}
