import SwiftUI

struct DetailView: View {
    @State var input: String = ""
    @State var userInput: String = ""
    @State var currentQuestion = Question()
    @State var errorMessage = ""
    @State var numQuestions = 0
    @State var numRight = 0
    @State var numWrong = 0
    @State var startTime = 0
    @FocusState private var isTextFieldFocused: Bool
    var delay: TimeInterval = 1.0
    @State var isActive = false
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(currentQuestion.equation)
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()
                
                ZStack {
                    Text("Correct!\nTry this one:")
                        .font(.system(size: 30))
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                        .opacity(errorMessage.contains("Correct") ? 1 : 0)
                        .animation(.easeInOut, value: errorMessage)
                    
                    Text("Incorrect.\nTry again.")
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .opacity(errorMessage.contains("Incorrect") ? 1 : 0)
                        .animation(.easeInOut, value: errorMessage)
                }
                .frame(height: 50) // Fixed space to prevent movement
                
                TextField("Answer", text: $input)
                    .font(.system(size: 48))
                    .disableAutocorrection(true)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 250)
                    .focused($isTextFieldFocused)
                    .onAppear {
                        isTextFieldFocused = true
                        startTime = Int(Date().timeIntervalSince1970)
                    }
                    .onChange(of: input) { newValue in
                        if !newValue.isEmpty {
                            if newValue.trimmingCharacters(in: .whitespacesAndNewlines) == currentQuestion.answer {
                                currentQuestion = Question()
                                errorMessage = "Correct!\nTry this one:"
                                numRight += 1
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
                                numWrong += 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                    errorMessage = ""
                                }
                            }
                        }
                    }
                
                .navigationDestination(isPresented: $isActive) {
                    let student = PersistenceController.shared.fetchStudent()
                    let score = Score(
                        student: student.studentName!,
                        teacher: student.teacherName!,
                        numberCorrect: numRight - numWrong,
                        numberWrong: numWrong,
                        problemSetStartTime: startTime,
                        problemSetEndTime: Int(Date().timeIntervalSince1970)
                    )
                    ResultView(score: score)
                        .navigationBarBackButtonHidden(true)
                }
                Spacer()
            }
            .padding()
            .background(LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.2), .white]),
                startPoint: .top, endPoint: .bottom
            ))
            .cornerRadius(15)
            .shadow(radius: 5)
        }
    }
}
