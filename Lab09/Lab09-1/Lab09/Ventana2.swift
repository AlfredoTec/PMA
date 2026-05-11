import SwiftUI

struct Ventana2: View {
    var body: some View {
        VStack {
            Text("Tecsup - Software")
                .font(.largeTitle)
            
            HStack {
                Text("Izquierda")
                Spacer()
                Text("Derecha")
            }
            .padding()
            
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 200, height: 200)
                Text("Alumnos de 5to Ciclo")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    Ventana2()
}
