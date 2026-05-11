import SwiftUI

struct ContentView: View {
    @State private var courses: [Cursos] = [
        Cursos(title: "Fundamentos de Python", language: "Python", description: "Aprende desde cero."),
        Cursos(title: "Desarrollo Web", language: "JavaScript", description: "Crea sitios modernos."),
        Cursos(title: "Apps iOS", language: "Swift", description: "Construye apps móviles.")
    ]
    @State private var showingAddCourse = false

    var body: some View {
        NavigationView {
            List(courses) { course in
                NavigationLink(destination: CourseDetailView(curso: course)) {
                    VStack(alignment: .leading) {
                        Text(course.title)
                            .font(.headline)
                        Text(course.language)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Cursos")
            .toolbar {
                Button(action: {
                    showingAddCourse = true
                }) {
                    Image(systemName: "plus")
                    Text("Agregar")
                }
            }
            .sheet(isPresented: $showingAddCourse) {
                CourseFormView { newCourse in
                    courses.append(newCourse)
                    showingAddCourse = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
