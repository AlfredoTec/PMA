import SwiftUI

struct CourseDetailView: View {
    let curso: Cursos
    
    var body: some View {
        VStack(spacing: 20) {
            Text(curso.title)
                .font(.largeTitle)
                .bold()
            Text("Lenguaje: \(curso.language)")
                .foregroundColor(.blue)
            Text(curso.description)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .padding()
        .navigationTitle(curso.title)
    }
}
