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
    var delay: TimeInterval = 1.0
    @State var isActive = false


    var body: some View {
        NavigationStack {
            VStack {
                navigationDestination(isPresented: $isActive) {
                    ContentView()
                }
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
                .onChange(of: input) {
                    
                    if(numQuestions >= 10) {
                        isActive = true
                    } else if (!input.isEmpty){
                        if (input == currentQuestion.answer){
                            currentQuestion = Question()
                            errorMessage = "Correct!\nTry this one:"
                            input = ""
                            DispatchQueue.main.asyncAfter(deadline: .now()+delay) {
                                errorMessage = ""
                            }
                            numQuestions += 1
                        } else if(input.count == currentQuestion.answer.count){
                            errorMessage = "Incorrect.\nTry again."
                            DispatchQueue.main.asyncAfter(deadline: .now()+delay) {
                                errorMessage = ""
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }
}
