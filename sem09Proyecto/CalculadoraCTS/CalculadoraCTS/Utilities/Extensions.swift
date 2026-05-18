//
//  Extensions.swift
//  CalculadoraCTS
//
//  Created by Tecsup on 14/05/26.
//

import SwiftUI

// Utilities/Extensions.swift
// Extensiones y helpers reutilizables en toda la app



// MARK: - Colores TECSUP (sin depender de Assets.xcassets)

extension Color {
    /// Azul institucional TECSUP #1A527A
    static let azulTecsup = Color(red: 0.10, green: 0.32, blue: 0.53)

    /// Fondo suave azul para filas destacadas
    static let azulTecsupSuave = Color(red: 0.10, green: 0.32, blue: 0.53).opacity(0.08)
}

// MARK: - Formato moneda en soles

extension Double {
    /// Devuelve el número formateado como "S/ 1,272.39"
    var formatoSoles: String {
        let f = NumberFormatter()
        f.numberStyle            = .currency
        f.currencySymbol         = "S/ "
        f.minimumFractionDigits  = 2
        f.maximumFractionDigits  = 2
        f.groupingSeparator      = ","
        f.decimalSeparator       = "."
        return f.string(from: NSNumber(value: self)) ?? "S/ 0.00"
    }

    /// Devuelve el número como porcentaje: 0.1275 → "12.75%"
    var formatoPorcentaje: String {
        String(format: "%.2f%%", self * 100)
    }
}

// MARK: - View modifiers reutilizables

extension View {
    /// Aplica el estilo de tarjeta estándar de la app
    func estiloTarjeta() -> some View {
        self
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
    }

    /// Oculta el teclado al tocar fuera de un TextField
    func ocultarTeclado() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil, from: nil, for: nil
            )
        }
    }
}
