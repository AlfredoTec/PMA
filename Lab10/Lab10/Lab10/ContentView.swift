import SwiftUI
import UIKit

// Vamos a hacer el protocolo UIViewControllerRepresentable para usar UIKit en SwiftUI
struct UIViewControllerHosting: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return MiViewController() // Reemplaza MiViewController con el controlador real de UIKit
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update logic here
    }
}

// Vista principal en SwiftUI - Tecsup
struct ContentView: View {
    var body: some View {
        // Utilizamos una VStack
        VStack(spacing: 20) {
            // Texto superior en SwiftUI
            Text("Vista SwiftUI arriba")
                .font(.title2)
                .padding()

            // Aquí insertamos nuestro UIViewController desde UIKit usando nuestro UIViewControllerRepresentable()
            UIViewControllerHosting()
                .frame(height: 300) // Altura fija para mostrar el controlador

            // Texto inferior en SwiftUI
            Text("Vista SwiftUI abajo")
                .font(.title2)
                .padding()
        }
    }
}

// Iniciar Preview (esto es puramente para incremento de desarrollo; no es necesario incluida en tu proyecto final)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
