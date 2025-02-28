import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var student: Student
    
    var body: some View {
        NavigationView {
            NavigationLink {
                DetailView()
            } label: {
                Text("Student Home")
            }
        }
        Text("Teacher Name")
        TextField(
            "",
            text: Binding(
                get: { student.teacherName ?? "" },
                set: { newValue in
                    student.teacherName = newValue
                    saveContext()
                }
            ))
        .disableAutocorrection(true)
        .border(.secondary)
        .padding()
        .frame(width: 200)
        
        Text("Student Name")
        TextField(
            "",
            text: Binding(
                get: { student.studentName ?? "" },
                set: { newValue in
                    student.studentName = newValue
                    saveContext()
                }
            ))
        .disableAutocorrection(true)
        .border(.secondary)
        .padding()
        .frame(width: 200)
    }
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
    
}
