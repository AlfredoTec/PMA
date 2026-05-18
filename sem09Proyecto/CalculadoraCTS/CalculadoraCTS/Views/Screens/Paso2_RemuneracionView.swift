//
//  Paso2_RemuneracionView.swift
//  CalculadoraCTS
//
//  Created by Tecsup on 14/05/26.
//
// Views/Screens/Paso2_RemuneracionView.swift
// Paso 3 (antes 2): Sueldos, gratificación, período e inasistencias

import SwiftUI

struct Paso2_RemuneracionView: View {
    @ObservedObject var viewModel: CTSViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                PasoIndicador(pasoActual: 3, total: 4)
                    .padding(.top, 8)

                // ── Remuneración computable ──────────────────────
                TarjetaSeccion(titulo: "Remuneración computable",
                               icono: "banknote.fill") {
                    VStack(spacing: 0) {

                        CampoMoneda(etiqueta: "Remuneración básica mensual",
                                    subtitulo: "Campo obligatorio",
                                    valor: $viewModel.sueldoBasico)

                        Divider().padding(.horizontal, 16)

                        CampoMoneda(etiqueta: "Otras remuneraciones fijas",
                                    subtitulo: "Permanentes y mensuales (opcional)",
                                    valor: $viewModel.otrasRemuneraciones)

                        Divider().padding(.horizontal, 16)

                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Asignación familiar")
                                    .font(.system(size: 15))
                                Text("S/ \(String(format: "%.2f", viewModel.montoAsignacion)) — valor legal vigente")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Toggle("", isOn: $viewModel.asignacionFamiliar)
                                .tint(Color.azulTecsup)
                                .labelsHidden()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)

                        Divider()

                        HStack {
                            Text("Total remuneración mensual")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(viewModel.totalRemuneracion.formatoSoles)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color.azulTecsup)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.azulTecsupSuave)
                    }
                }

                // ── Gratificación semestral ──────────────────────
                TarjetaSeccion(titulo: "Gratificación semestral",
                               icono: "gift.fill") {
                    VStack(spacing: 0) {
                        CampoMoneda(etiqueta: "Monto de gratificación percibida",
                                    subtitulo: "Ingresa el monto del semestre",
                                    valor: $viewModel.gratificacion)

                        Divider().padding(.horizontal, 16)

                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("1/6 de gratificación")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.secondary)
                                Text("Art. 9, D.S. 001-97-TR")
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(viewModel.sextoParte.formatoSoles)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(Color.azulTecsup)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.azulTecsupSuave)
                    }
                }

                // ── Período trabajado ────────────────────────────
                TarjetaSeccion(titulo: "Período trabajado en el semestre",
                               icono: "calendar.badge.clock") {
                    VStack(spacing: 16) {

                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Meses completos trabajados")
                                    .font(.system(size: 15))
                                Text("Entre 0 y 6 meses")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Stepper(value: $viewModel.mesesCompletos, in: 0...6) {
                                Text("\(viewModel.mesesCompletos) mes\(viewModel.mesesCompletos == 1 ? "" : "es")")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.azulTecsup)
                                    .frame(minWidth: 70, alignment: .trailing)
                            }
                            .fixedSize()
                        }
                        .padding(.horizontal, 16)

                        Divider().padding(.horizontal, 16)

                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Días adicionales")
                                    .font(.system(size: 15))
                                Text("≥ 15 días suma 1 mes completo")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Stepper(value: $viewModel.diasAdicionales, in: 0...29) {
                                Text("\(viewModel.diasAdicionales) día\(viewModel.diasAdicionales == 1 ? "" : "s")")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.azulTecsup)
                                    .frame(minWidth: 70, alignment: .trailing)
                            }
                            .fixedSize()
                        }
                        .padding(.horizontal, 16)

                        // Meses ajustados reactivo
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Meses ajustados → Factor")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.secondary)
                                Text("Art. 12, D.S. 004-97-TR")
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("\(Int(viewModel.mesesAjustados)) m  →  \(String(format: "%.4f", viewModel.factorProporcional))")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color.azulTecsup)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.azulTecsupSuave)
                        .padding(.bottom, 4)
                    }
                }

                // ── Inasistencias (NUEVO) ────────────────────────
                TarjetaSeccion(titulo: "Días de inasistencia",
                               icono: "calendar.badge.minus") {
                    VStack(spacing: 0) {

                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Días de inasistencia en el semestre")
                                    .font(.system(size: 15))
                                Text("(**) Art. 8, D.S. 001-97-TR")
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Stepper(value: $viewModel.diasInasistencia, in: 0...180) {
                                Text("\(viewModel.diasInasistencia) día\(viewModel.diasInasistencia == 1 ? "" : "s")")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(
                                        viewModel.diasInasistencia > 0 ? .red : Color.azulTecsup
                                    )
                                    .frame(minWidth: 70, alignment: .trailing)
                            }
                            .fixedSize()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)

                        if viewModel.diasInasistencia > 0 {
                            Divider().padding(.horizontal, 16)
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Descuento por inasistencia")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.secondary)
                                    Text("Proporcional sobre CTS bruta")
                                        .font(.system(size: 11))
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("- \(viewModel.descuentoInasistencia.formatoSoles)")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.red)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.red.opacity(0.05))
                        }

                        Divider().padding(.horizontal, 16)

                        HStack(spacing: 8) {
                            Image(systemName: "info.circle")
                                .foregroundColor(.orange)
                                .font(.system(size: 13))
                            Text("Solo se descuentan inasistencias injustificadas. Las justificadas no se consideran.")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.orange.opacity(0.05))
                    }
                }

                // ── Nota EsSalud ─────────────────────────────────
                HStack(spacing: 10) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                    Text("EsSalud (9%) lo paga el empleador. No se descuenta al docente en CTS.")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                .padding(14)
                .background(Color.blue.opacity(0.07))
                .cornerRadius(10)
                .padding(.horizontal, 20)

                // ── Botón Calcular ───────────────────────────────
                NavigationLink(destination:
                    Paso3_ResultadoView(viewModel: viewModel)
                ) {
                    HStack {
                        Text("Ver resultado CTS")
                            .font(.system(size: 17, weight: .bold))
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(viewModel.sueldoBasico > 0
                                ? Color.azulTecsup
                                : Color.gray.opacity(0.4))
                    .cornerRadius(14)
                }
                .disabled(viewModel.sueldoBasico <= 0)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)

                if viewModel.sueldoBasico <= 0 {
                    Text("Ingresa la remuneración básica para continuar")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .padding(.bottom, 16)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Paso 3 de 4")
        .navigationBarTitleDisplayMode(.inline)
        .ocultarTeclado()
    }
}

#Preview {
    NavigationStack {
        Paso2_RemuneracionView(viewModel: CTSViewModel())
    }
}
