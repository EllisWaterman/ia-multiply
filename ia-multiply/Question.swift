
import Foundation

class Question {
    var factor0 = Int()
    var factor1 = Int()
    var equation: String
    var answer: String
    init() {
//        let time = UInt32(NSDate().timeIntervalSinceReferenceDate)
//        srand(time)

        factor0 = Int.random(in: 1..<10)
        factor1 = Int.random(in: 1..<10)
        equation = "\(factor0) X \(factor1)"
        answer = String(factor0*factor1)
    }
}
