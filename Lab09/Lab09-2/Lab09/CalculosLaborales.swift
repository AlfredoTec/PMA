import SwiftUI

// MARK: - Modelo de Cálculo CTS

/// Calcula la Compensación por Tiempo de Servicios (CTS)
struct CalculoCTS {
    /// Sueldo mensual del trabajador
    var sueldo: Double = 0
    /// Gratificación semestral percibida (monto completo)
    var gratificacion: Double = 0
    /// Meses trabajados en el semestre (0...6)
    var mesesTrabajados: Double = 0

    /// CTS = (Sueldo + 1/6 de la gratificación) × (Meses trabajados / 12)
    var resultado: Double {
        let computable = sueldo + (gratificacion / 6)
        let proporcion = mesesTrabajados / 12
        return computable * proporcion
    }
}

// MARK: - Vista para CTS
struct CTSView: View {
    @State private var sueldo: String = ""
    @State private var gratificacion: String = ""
    @State private var meses: String = ""

    private var calculo: CalculoCTS {
        CalculoCTS(
            sueldo: Double(sueldo) ?? 0,
            gratificacion: Double(gratificacion) ?? 0,
            mesesTrabajados: min(Double(meses) ?? 0, 6)
        )
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Datos del trabajador")) {
                    TextField("Sueldo mensual (S/)", text: $sueldo)
                        .keyboardType(.decimalPad)
                    TextField("Gratificación semestral (S/)", text: $gratificacion)
                        .keyboardType(.decimalPad)
                    TextField("Meses trabajados (0-6)", text: $meses)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Resultado CTS")) {
                    HStack {
                        Text("CTS a depositar:")
                        Spacer()
                        Text("S/ \(calculo.resultado, specifier: "%.2f")")
                            .bold()
                    }
                    Text("Sueldo + 1/6 gratificación: S/ \(calculo.sueldo + calculo.gratificacion/6, specifier: "%.2f")")
                    Text("Proporción (meses/12): \(calculo.mesesTrabajados/12, specifier: "%.4f")")
                }
            }
            .navigationTitle("Cálculo CTS")
        }
    }
}

// MARK: - Preview
struct CTSView_Previews: PreviewProvider {
    static var previews: some View {
        CTSView()
    }
}
