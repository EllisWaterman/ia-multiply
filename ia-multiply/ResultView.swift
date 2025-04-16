//
//  ResultView.swift
//  ia-multiply
//
//  Created by ellis on 3/26/25.
//

import Foundation
import SwiftUI
import SwiftData
struct ResultView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let score: Score
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Results")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Text("Teacher: \(score.teacher)")
                .font(.title2)
                .padding()
                .frame(width: 250)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Text("Student: \(score.student)")
                .font(.title2)
                .padding()
                .frame(width: 250)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Text("Number Right: \(score.numberCorrect)")
                .font(.title2)
                .foregroundColor(.green)
            
            Text("Number Wrong: \(score.numberWrong)")
                .font(.title2)
                .foregroundColor(.red)
            
            Text("Seconds Taken: \(score.problemSetEndTime - score.problemSetStartTime)")
                .font(.title2)
                .padding()
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(10)
            
            NavigationLink(destination: DetailView().navigationBarBackButtonHidden(true)) {
                Text("Play Again")
                    .font(.title2)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
        .onAppear {
            performAction()
        }
    }
    
    func performAction() {
        print("ResultView appeared!")
        score.postScores()
    }
}
