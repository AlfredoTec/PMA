import SwiftUI

struct MenuPrincipal: View {
    var body: some View {
        // agregar un Navegador
        NavigationStack {
            List {
                // utilizar el NavigationLink
                NavigationLink("Aplicacion01") {
                    Text("Pagina 2")
                }
                NavigationLink("Aplicacion02") {
                    Text("Pagina 3")
                }
                NavigationLink("Aplicacion03") {
                    Text("Pagina 4")
                }
                NavigationLink("Aplicacion04") {
                    Text("Pagina 5")
                }
            }
            .navigationTitle("Menu Principal")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    MenuPrincipal()
}
