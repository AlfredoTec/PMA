import SwiftUI

struct MenuNavegacionView: View {
    var onSelect: (String)-> Void

    var body: some View {
        Menu("Ir a vista") {
            Button("Vista 1"){ onSelect("vista1") } // Llama a onSelect con "vista1"
            Button("Vista 2"){ onSelect("vista2") } // Llama a onSelect con "vista2"
            Button("Vista 3"){ onSelect("vista3") } // Llama a onSelect con "vista3"
        }
        .font(.title2)
        .padding()
    }
}

#Preview {
    MenuNavegacionView(onSelect: { _ in })
}
