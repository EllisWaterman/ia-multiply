import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Student")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        ensureSingleStudentExists()
    }

    private func ensureSingleStudentExists() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        do {
            let students = try context.fetch(fetchRequest)
            if students.isEmpty {
                let newStudent = Student(context: context)
                newStudent.created_at = Date()
                try context.save()
            }
        } catch {
            print("Error ensuring single student: \(error)")
        }
    }

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    func fetchStudent() -> Student {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.fetchLimit = 1
        do {
            let students = try viewContext.fetch(fetchRequest)
            if let student = students.first {
                return student
            } else {
                return createStudent()
            }
        } catch {
            print("Failed to fetch Student: \(error)")
            return createStudent()
        }
    }

    private func createStudent() -> Student {
        let newStudent = Student(context: viewContext)
        newStudent.created_at = Date()
        do {
            try viewContext.save()
        } catch {
            fatalError("Failed to save default Student: \(error)")
        }
        return newStudent
    }
}

