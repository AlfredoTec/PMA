import SwiftUI

struct SettingScreen: View {
    @State var isOn = false

    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Toggle(isOn: $isOn, label: {
                        Text("Suscriptor")
                    })

                    Toggle(isOn: $isOn, label: {
                        Text("Suscriptor")
                    })

                    Toggle(isOn: $isOn, label: {
                        Text("Suscriptor")
                    })
                }

                Spacer()
            }
            .navigationTitle("Controles")
        }
    }
}

#Preview {
    SettingScreen()
}
