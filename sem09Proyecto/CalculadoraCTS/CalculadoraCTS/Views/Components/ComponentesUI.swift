//
//  ComponentesUI.swift
//  CalculadoraCTS
//

// Views/Components/ComponentesUI.swift
// Componentes de UI reutilizables en todas las pantallas

import SwiftUI

// MARK: - Indicador de pasos (1 de 3, 2 de 3, 3 de 3)

struct PasoIndicador: View {
    let pasoActual: Int
    let total: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...total, id: \.self) { paso in
                if paso < pasoActual {
                    Circle()
                        .fill(Color.azulTecsup)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Image(systemName: "checkmark")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                        )
                } else if paso == pasoActual {
                    Circle()
                        .fill(Color.azulTecsup)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Text("\(paso)")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white)
                        )
                } else {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Text("\(paso)")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        )
                }
                if paso < total {
                    Rectangle()
                        .fill(paso < pasoActual
                              ? Color.azulTecsup
                              : Color.gray.opacity(0.2))
                        .frame(height: 2)
                }
            }
        }
        .padding(.horizontal, 40)
    }
}

// MARK: - Tarjeta de sección con cabecera

struct TarjetaSeccion<Contenido: View>: View {
    let titulo: String
    let icono: String
    @ViewBuilder let contenido: () -> Contenido

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: icono)
                    .foregroundColor(Color.azulTecsup)
                    .font(.system(size: 15))
                Text(titulo)
                    .font(.system(size: 15, weight: .semibold))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Divider()

            contenido()
        }
        .estiloTarjeta()
        .padding(.horizontal, 20)
    }
}

// MARK: - Fila de opción seleccionable (radio button)

struct OpcionSeleccion: View {
    let texto: String
    let seleccionado: Bool
    let accion: () -> Void

    var body: some View {
        Button(action: accion) {
            HStack {
                Text(texto)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                Spacer()
                if seleccionado {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color.azulTecsup)
                        .font(.system(size: 20))
                } else {
                    Circle()
                        .stroke(Color.gray.opacity(0.35), lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(seleccionado
                        ? Color.azulTecsup.opacity(0.06)
                        : Color.clear)
        }
    }
}

// MARK: - Semáforo de jornada laboral

struct SemaforoJornada: View {
    let promedio: Double
    let esTiempoCompleto: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: esTiempoCompleto
                  ? "checkmark.circle.fill"
                  : "xmark.circle.fill")
                .font(.system(size: 22))
                .foregroundColor(esTiempoCompleto ? .green : .red)

            VStack(alignment: .leading, spacing: 2) {
                Text("Promedio: \(String(format: "%.1f", promedio)) h/día")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(esTiempoCompleto ? .green : .red)
                Text(esTiempoCompleto
                     ? "Tiempo completo → corresponde CTS"
                     : "Tiempo parcial (< 4 h/día) → sin CTS")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(12)
        .background(esTiempoCompleto
                    ? Color.green.opacity(0.08)
                    : Color.red.opacity(0.08))
        .cornerRadius(10)
    }
}

// MARK: - Campo de entrada de moneda (CORREGIDO)
// El problema anterior: textoValor no sincronizaba bien con el @Binding
// Solución: usar onEditingChanged + onChange combinados

struct CampoMoneda: View {
    let etiqueta: String
    let subtitulo: String
    @Binding var valor: Double
    @State private var textoValor: String = ""
    @FocusState private var enfocado: Bool

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(etiqueta)
                    .font(.system(size: 15))
                Text(subtitulo)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
            }
            Spacer()
            HStack(spacing: 4) {
                Text("S/")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                TextField("0.00", text: $textoValor)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 90)
                    .focused($enfocado)
                    // ✅ CORRECCIÓN CLAVE: actualizar valor en cada cambio de texto
                    .onChange(of: textoValor) { nuevoTexto in
                        let limpio = nuevoTexto
                            .replacingOccurrences(of: ",", with: ".")
                            .trimmingCharacters(in: .whitespaces)
                        valor = Double(limpio) ?? 0
                    }
                    // ✅ Mostrar valor actual al aparecer el campo
                    .onAppear {
                        if valor > 0 {
                            textoValor = String(format: "%.2f", valor)
                        } else {
                            textoValor = ""
                        }
                    }
                    // ✅ Al perder foco formatear con 2 decimales
                    .onChange(of: enfocado) { estaEnfocado in
                        if !estaEnfocado && valor > 0 {
                            textoValor = String(format: "%.2f", valor)
                        }
                    }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
        .onTapGesture { enfocado = true }
    }
}

// MARK: - Fila de desglose del cálculo

struct FilaDesglose: View {
    let etiqueta: String
    let valor: String
    var subtitulo: String? = nil
    var destacado: Bool    = false
    var colorValor: Color  = .primary

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text(etiqueta)
                    .font(.system(size: destacado ? 14 : 13,
                                  weight: destacado ? .semibold : .regular))
                if let sub = subtitulo {
                    Text(sub)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Text(valor)
                .font(.system(size: destacado ? 15 : 14,
                               weight: destacado ? .bold : .medium))
                .foregroundColor(
                    colorValor == .primary
                        ? (destacado ? Color.azulTecsup : .primary)
                        : colorValor
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, destacado ? 14 : 11)
        .background(destacado ? Color.azulTecsupSuave : Color.clear)
    }
}

// MARK: - Fila resultado estilo SUNAFIL

struct FilaResultadoSunafil: View {
    let etiqueta: String
    let valor: String
    var esDescuento: Bool = false
    var esFinal: Bool     = false

    var body: some View {
        HStack {
            Text(etiqueta)
                .font(.system(size: esFinal ? 15 : 14,
                               weight: esFinal ? .bold : .medium))
                .foregroundColor(esFinal ? .primary : .secondary)
            Spacer()
            Text(valor)
                .font(.system(size: esFinal ? 18 : 15,
                               weight: esFinal ? .bold : .semibold))
                .foregroundColor(
                    esFinal     ? Color.azulTecsup :
                    esDescuento ? .red : .primary
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, esFinal ? 16 : 12)
        .background(esFinal ? Color.azulTecsupSuave : Color.clear)
    }
}

// MARK: - Banner resultado (CTS Neta)

struct BannerResultado: View {
    let valor: Double
    let titulo: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 36))
                .foregroundColor(.white)
            Text(titulo)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.85))
            Text(valor.formatoSoles)
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .background(
            LinearGradient(
                colors: [Color.azulTecsup, Color.azulTecsup.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .shadow(color: Color.azulTecsup.opacity(0.3), radius: 10, y: 4)
        .padding(.horizontal, 20)
    }
}

// MARK: - Banner "no corresponde"

struct BannerNoCorresponde: View {
    let mensaje: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
            Text("No corresponde CTS")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            Text(mensaje)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.85))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .padding(.horizontal, 20)
        .background(Color.red.opacity(0.85))
        .cornerRadius(16)
        .padding(.horizontal, 20)
    }
}

// MARK: - Fila informativa con ícono

struct InfoRow: View {
    let icono: String
    let texto: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icono)
                .foregroundColor(.white)
                .frame(width: 24)
            Text(texto)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
            Spacer()
        }
    }
}



