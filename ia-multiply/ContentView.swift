import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var input: String = ""
    @State private var userInput: String = ""
    @State var currentQuestion = Question();
    @State var errorMessage = ""
    var body: some View {
        Text(currentQuestion.equation)
        Text(errorMessage)
        TextField(
            "Enter Answer",
            text: $input
        ).disableAutocorrection(true)
        .border(.secondary)
        .keyboardType(.numberPad)
        .padding()
        .frame(width: 200)
        .onChange(of: input) {
            if (!input.isEmpty ){
                if (input == currentQuestion.answer){
                    currentQuestion = Question()
                    errorMessage = "Correct!\nTry this one:"
                    input = ""
                } else if(input.count == currentQuestion.answer.count){
                    errorMessage = "Incorrect.\nTry again."
                }
            }
        }
        
    }
}

