//
//  Paso1_DatosView.swift
//  CalculadoraCTS
//
//  Created by Tecsup on 14/05/26.
//

import SwiftUI

// Views/Screens/Paso1_DatosView.swift
// Paso 1: Datos del trabajador + validación de jornada
// Vista SOLO muestra datos — la lógica está en CTSViewModel

struct Paso1_DatosView: View {
    @ObservedObject var viewModel: CTSViewModel
    @State private var mostrarAlertaCAS = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                PasoIndicador(pasoActual: 1, total: 3)
                    .padding(.top, 8)

                // ── Régimen laboral ──────────────────────────────
                TarjetaSeccion(titulo: "Régimen laboral",
                               icono: "briefcase.fill") {
                    VStack(spacing: 0) {
                        ForEach(RegimenLaboral.allCases, id: \.self) { r in
                            OpcionSeleccion(
                                texto: r.rawValue,
                                seleccionado: viewModel.regimen == r
                            ) {
                                viewModel.regimen = r
                                if r == .cas { mostrarAlertaCAS = true }
                            }
                            if r != RegimenLaboral.allCases.last {
                                Divider().padding(.horizontal, 16)
                            }
                        }
                    }
                }

                // ── Jornada laboral ──────────────────────────────
                TarjetaSeccion(titulo: "Jornada laboral",
                               icono: "clock.fill") {
                    VStack(spacing: 16) {

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Días laborados por semana")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 16)

                            ForEach(DiasSemanales.allCases, id: \.self) { d in
                                OpcionSeleccion(
                                    texto: d.descripcion,
                                    seleccionado: viewModel.diasSemana == d
                                ) { viewModel.diasSemana = d }

                                if d != DiasSemanales.allCases.last {
                                    Divider().padding(.horizontal, 16)
                                }
                            }
                        }

                        Divider()

                        // Slider horas semanales
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Horas trabajadas por semana")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(Int(viewModel.horasSemanales)) h")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.azulTecsup)
                            }
                            .padding(.horizontal, 16)

                            Slider(value: $viewModel.horasSemanales,
                                   in: 1...48, step: 1)
                                .tint(Color.azulTecsup)
                                .padding(.horizontal, 16)
                        }

                        // Semáforo reactivo
                        SemaforoJornada(
                            promedio: viewModel.promedioDiario,
                            esTiempoCompleto: viewModel.esTiempoCompleto
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)
                    }
                }

                // ── Sistema de pensiones ─────────────────────────
                TarjetaSeccion(titulo: "Sistema de pensiones",
                               icono: "shield.fill") {
                    VStack(spacing: 0) {
                        ForEach(SistemaPensiones.allCases, id: \.self) { p in
                            OpcionSeleccion(
                                texto: p.descripcion,
                                seleccionado: viewModel.pension == p
                            ) { viewModel.pension = p }

                            if p != SistemaPensiones.allCases.last {
                                Divider().padding(.horizontal, 16)
                            }
                        }
                    }
                }

                // ── Botón Siguiente ──────────────────────────────
                NavigationLink(destination:
                    Paso2_RemuneracionView(viewModel: viewModel)
                ) {
                    HStack {
                        Text(viewModel.corresponde ? "Siguiente" : "Ver motivo")
                            .font(.system(size: 17, weight: .bold))
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.azulTecsup)
                    .cornerRadius(14)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Paso 1 de 3")
        .navigationBarTitleDisplayMode(.inline)
        .ocultarTeclado()
        .alert("Régimen CAS", isPresented: $mostrarAlertaCAS) {
            Button("Entendido", role: .cancel) {
                viewModel.regimen = .actividadPrivada
            }
        } message: {
            Text("Al pertenecer al régimen CAS no corresponde pago de CTS según SUNAFIL.")
        }
    }
}

#Preview {
    NavigationStack {
        Paso1_DatosView(viewModel: CTSViewModel())
    }
}

