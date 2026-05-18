//
//  Paso3_ResultadoView.swift
//  CalculadoraCTS
//
//  Created by Tecsup on 14/05/26.
//

// Views/Screens/Paso3_ResultadoView.swift
// Paso 3: Resultado CTS con desglose completo estilo SUNAFIL

import SwiftUI

// Views/Screens/Paso3_ResultadoView.swift
// Paso 4: Resultado CTS con desglose completo + datos del trabajador



struct Paso3_ResultadoView: View {
    @ObservedObject var viewModel: CTSViewModel
    @Environment(\.dismiss) var dismiss

    private var resultado: ResultadoCTS { viewModel.calcular() }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                PasoIndicador(pasoActual: 4, total: 4)
                    .padding(.top, 8)

                // ── Datos del trabajador (resumen) ───────────────
                if !viewModel.nombreTrabajador.isEmpty {
                    VStack(spacing: 0) {
                        HStack(spacing: 12) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 36))
                                .foregroundColor(Color.azulTecsup)
                            VStack(alignment: .leading, spacing: 3) {
                                Text(viewModel.nombreTrabajador)
                                    .font(.system(size: 16, weight: .bold))
                                if !viewModel.cargo.isEmpty {
                                    Text(viewModel.cargo)
                                        .font(.system(size: 13))
                                        .foregroundColor(.secondary)
                                }
                                if !viewModel.dniTrabajador.isEmpty {
                                    Text("DNI: \(viewModel.dniTrabajador)")
                                        .font(.system(size: 12))
                                        .foregroundColor(.secondary)
                                }
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 3) {
                                Text(viewModel.semestre.descripcion
                                    .components(separatedBy: "(").first ?? "")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(Color.azulTecsup)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        .padding(16)
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
                    .padding(.horizontal, 20)
                }

                // ── Banner principal ─────────────────────────────
                if resultado.corresponde {
                    BannerResultado(
                        valor: resultado.ctsNeta,
                        titulo: "CTS Neta a depositar"
                    )
                } else {
                    BannerNoCorresponde(mensaje: resultado.mensajeValidacion)
                }

                // ── Desglose ─────────────────────────────────────
                if resultado.corresponde {

                    TarjetaSeccion(titulo: "Remuneración computable",
                                   icono: "banknote") {
                        VStack(spacing: 0) {
                            FilaDesglose(etiqueta: "Remuneración básica",
                                         valor: viewModel.sueldoBasico.formatoSoles)
                            if viewModel.otrasRemuneraciones > 0 {
                                Divider().padding(.horizontal, 16)
                                FilaDesglose(etiqueta: "Otras remuneraciones fijas",
                                             valor: viewModel.otrasRemuneraciones.formatoSoles)
                            }
                            if viewModel.asignacionFamiliar {
                                Divider().padding(.horizontal, 16)
                                FilaDesglose(etiqueta: "Asignación familiar",
                                             valor: viewModel.montoAsignacion.formatoSoles)
                            }
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(etiqueta: "Total remuneración mensual",
                                         valor: resultado.totalRemuneracion.formatoSoles,
                                         destacado: true)
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(etiqueta: "1/6 de gratificación",
                                         valor: resultado.sextoParte.formatoSoles,
                                         subtitulo: "Art. 9, D.S. 001-97-TR")
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(etiqueta: "Base computable",
                                         valor: resultado.baseComputable.formatoSoles,
                                         subtitulo: "Remun. total + 1/6 gratif.",
                                         destacado: true)
                        }
                    }

                    TarjetaSeccion(titulo: "Cálculo proporcional",
                                   icono: "function") {
                        VStack(spacing: 0) {
                            FilaDesglose(etiqueta: "Meses ajustados",
                                         valor: "\(Int(resultado.mesesAjustados)) mes(es)",
                                         subtitulo: "Art. 12, D.S. 004-97-TR")
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(etiqueta: "Factor proporcional",
                                         valor: String(format: "%.4f", resultado.factorProporcional),
                                         subtitulo: "Meses ÷ 12")
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(etiqueta: "CTS Bruta",
                                         valor: resultado.ctsBruta.formatoSoles,
                                         destacado: true)
                        }
                    }

                    // Inasistencias (solo si hay)
                    if resultado.descuentoInasistencia > 0 {
                        TarjetaSeccion(titulo: "Descuento por inasistencias",
                                       icono: "calendar.badge.minus") {
                            VStack(spacing: 0) {
                                FilaDesglose(
                                    etiqueta: "Días de inasistencia: \(viewModel.diasInasistencia)",
                                    valor: "- \(resultado.descuentoInasistencia.formatoSoles)",
                                    subtitulo: "Art. 8, D.S. 001-97-TR",
                                    colorValor: .red
                                )
                                Divider().padding(.horizontal, 16)
                                FilaDesglose(
                                    etiqueta: "CTS Bruta tras descuento",
                                    valor: (resultado.ctsBruta - resultado.descuentoInasistencia).formatoSoles,
                                    destacado: true
                                )
                            }
                        }
                    }

                    TarjetaSeccion(titulo: "Descuentos previsionales",
                                   icono: "minus.circle.fill") {
                        VStack(spacing: 0) {
                            FilaDesglose(
                                etiqueta: "\(viewModel.pension.rawValue) — \(resultado.tasaPrevisional.formatoPorcentaje)",
                                valor: "- \(resultado.descuento.formatoSoles)",
                                colorValor: .red
                            )
                            Divider().padding(.horizontal, 16)
                            HStack(spacing: 8) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 13))
                                Text("EsSalud 9% → pago del empleador, no descuenta al docente")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.blue.opacity(0.05))
                        }
                    }

                    // Resultado estilo SUNAFIL
                    TarjetaSeccion(titulo: "Resultado — según SUNAFIL",
                                   icono: "building.columns.fill") {
                        VStack(spacing: 0) {
                            FilaResultadoSunafil(etiqueta: "Cálculo CTS",
                                                  valor: resultado.ctsBruta.formatoSoles)
                            if resultado.descuentoInasistencia > 0 {
                                Divider().padding(.horizontal, 16)
                                FilaResultadoSunafil(
                                    etiqueta: "Descuentos por inasistencia",
                                    valor: "- \(resultado.descuentoInasistencia.formatoSoles)",
                                    esDescuento: true
                                )
                            }
                            Divider().padding(.horizontal, 16)
                            FilaResultadoSunafil(
                                etiqueta: "Descuentos por \(viewModel.pension.rawValue)",
                                valor: "- \(resultado.descuento.formatoSoles)",
                                esDescuento: true
                            )
                            Divider().padding(.horizontal, 16)
                            FilaResultadoSunafil(
                                etiqueta: "Monto a depositar o pagar",
                                valor: resultado.ctsNeta.formatoSoles,
                                esFinal: true
                            )
                            Text("(*) El presente cálculo es según los datos registrados y es referencial")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(12)
                        }
                    }

                    HStack(spacing: 10) {
                        Image(systemName: "calendar.badge.clock")
                            .foregroundColor(Color.azulTecsup)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Depósitos semestrales")
                                .font(.system(size: 13, weight: .semibold))
                            Text("1–15 de mayo  y  1–15 de noviembre")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(14)
                    .background(Color.azulTecsupSuave)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                }

                // ── Nueva consulta ───────────────────────────────
                Button {
                    viewModel.limpiar()
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.counterclockwise")
                        Text("Nueva consulta")
                            .font(.system(size: 17, weight: .bold))
                    }
                    .foregroundColor(Color.azulTecsup)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.azulTecsupSuave)
                    .cornerRadius(14)
                    .overlay(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.azulTecsup, lineWidth: 1.5))
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Resultado CTS")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let vm = CTSViewModel()
    vm.nombreTrabajador = "García López, María"
    vm.cargo            = "Docente"
    vm.dniTrabajador    = "45678901"
    vm.sueldoBasico     = 2500
    vm.gratificacion    = 2500
    vm.mesesCompletos   = 6
    vm.diasInasistencia = 2
    return NavigationStack { Paso3_ResultadoView(viewModel: vm) }
}
