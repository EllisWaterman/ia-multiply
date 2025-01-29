//
//  DetailView.swift
//  IA-multiplyV01
//
//  Created by Period 1 on 1/29/25.
//
import SwiftUI

struct DetailView: View {
        @State var input: String = ""
        @State var userInput: String = ""
        @State var currentQuestion = Question();
        @State var errorMessage = ""
        @State var numQuestions = Int()
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
