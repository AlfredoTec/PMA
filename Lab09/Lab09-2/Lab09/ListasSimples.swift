import SwiftUI

struct ListasSimples: View {
    let fruits = ["🍎 Apple", "🍌 Banana", "🍇 Grape", "🍓 Strawberry"]

    var body: some View {
        NavigationView {
            List(fruits, id: \.self) { fruit in
                Text(fruit)
                    .font(.body)
                }
            .navigationTitle("Lista de Frutas")
        }
    }
}

#Preview {
    ListasSimples()
}
