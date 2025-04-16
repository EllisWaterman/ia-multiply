//
//  Score.swift
//  ia-multiply
//
//  Created by ellis on 3/27/25.
//

import Foundation

class Score: Codable {
    let student: String
    let teacher: String
    let problemSetStartTime: Int
    let problemSetEndTime: Int
    let numberCorrect: Int
    let numberWrong: Int
    let operatorType: String
    let factorUpperBound: Int
    let factorLowerBound: Int
    
    init(student: String, teacher: String, numberCorrect: Int, numberWrong: Int, problemSetStartTime: Int, problemSetEndTime: Int) {
        self.student = student
        self.teacher = teacher
        self.problemSetStartTime = problemSetStartTime
        self.problemSetEndTime = problemSetEndTime
        self.numberCorrect = numberCorrect
        self.numberWrong = numberWrong
        self.operatorType = "multiplication"
        self.factorUpperBound = 9
        self.factorLowerBound = 1
    }
    
    func postScores() {
        guard let url = URL(string: "https://t2ujycl4jf.execute-api.us-east-1.amazonaws.com/Prod/results") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(self)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode JSON: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
            }
        }.resume()
    }
}
