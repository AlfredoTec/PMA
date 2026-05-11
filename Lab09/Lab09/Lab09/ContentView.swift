import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack { // alineación vertical
            Text("Aplicaciones de Tecsup en SwiftUI!")
                .font(.title) // tamaño de fuente
                .foregroundColor(.red) // color de fuente
                .multilineTextAlignment(.center) // alineación de texto
            
            Text("Desarrollado Por: Juan León")
        }
        .padding(20) // espacio del texto con el contorno
        
        HStack(alignment: .center, spacing: 20) { // alineación horizontal
            Text("Actividad01")
            Text("Actividad02")
            Text("Actividad03")
        }
        
        ZStack { // superposición
            Rectangle()
                .fill(Color.blue)
                .frame(width: 200, height: 200)
            Text("Texto encima de la Imagen")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ContentView()
}
