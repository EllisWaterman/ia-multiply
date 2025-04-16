import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var student: Student
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to Student Portal")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()
                
                NavigationLink(destination: DetailView().navigationBarBackButtonHidden(true)) {
                    Text("Start")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                
                Form {
                    Section(header: Text("Teacher Info").fontWeight(.bold)) {
                        TextField("Enter Teacher Name", text: Binding(
                            get: { student.teacherName ?? "" },
                            set: { newValue in
                                student.teacherName = newValue
                                saveContext()
                            }
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Section(header: Text("Student Info").fontWeight(.bold)) {
                        TextField("Enter Student Name", text: Binding(
                            get: { student.studentName ?? "" },
                            set: { newValue in
                                student.studentName = newValue
                                saveContext()
                            }
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
                .frame(maxWidth: 300)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 5)
            }
            .padding()
            .background(LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.2), .white]),
                startPoint: .top, endPoint: .bottom
            ))
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
}
