//
//  InstructorResultadoView.swift
//  CalculadoraCTS
//
//  Created by Tecsup on 14/05/26.
//

// Views/Screens/InstructorResultadoView.swift
// Resultado del pago de instructores con desglose completo

import SwiftUI

struct InstructorResultadoView: View {
    @ObservedObject var vm: InstructorViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // ── Banner sueldo neto ───────────────────────────
                VStack(spacing: 8) {
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                    Text("Sueldo Neto del Instructor")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.85))
                    Text(vm.sueldoNeto.formatoSoles)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text("por mes")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.75))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 28)
                .background(
                    LinearGradient(
                        colors: [Color.azulTecsup, Color.azulTecsup.opacity(0.8)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(16)
                .shadow(color: Color.azulTecsup.opacity(0.3), radius: 10, y: 4)
                .padding(.horizontal, 20)
                .padding(.top, 8)

                // Aviso horas si aplica
                if vm.superaMaxHoras {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                        Text("Se aplicaron 23 horas (máximo). Ingresaste \(Int(vm.horasSemanales)) h.")
                            .font(.system(size: 13))
                            .foregroundColor(.orange)
                    }
                    .padding(12)
                    .background(Color.orange.opacity(0.08))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                }

                // ── Sueldo bruto ─────────────────────────────────
                TarjetaSeccion(titulo: "Sueldo bruto",
                               icono: "banknote.fill") {
                    VStack(spacing: 0) {
                        FilaDesglose(
                            etiqueta: "Horas efectivas por semana",
                            valor: "\(Int(vm.horasEfectivas)) horas"
                        )
                        Divider().padding(.horizontal, 16)
                        FilaDesglose(
                            etiqueta: "Pago por hora",
                            valor: "S/ 50.00"
                        )
                        Divider().padding(.horizontal, 16)
                        FilaDesglose(
                            etiqueta: "Semanas por mes",
                            valor: "× 4"
                        )
                        Divider().padding(.horizontal, 16)
                        FilaDesglose(
                            etiqueta: "Sueldo bruto mensual",
                            valor: vm.sueldoBruto.formatoSoles,
                            subtitulo: "\(Int(vm.horasEfectivas)) × S/50 × 4",
                            destacado: true
                        )
                    }
                }

                // ── Descuentos del trabajador ────────────────────
                TarjetaSeccion(titulo: "Descuentos al trabajador",
                               icono: "minus.circle.fill") {
                    VStack(spacing: 0) {

                        // AFP o ONP
                        if vm.sistema.esAFP {
                            FilaDesglose(
                                etiqueta: "Aporte obligatorio (10%)",
                                valor: "- \(vm.aporteObligatorio.formatoSoles)",
                                subtitulo: "Va al fondo del trabajador",
                                colorValor: .red
                            )
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(
                                etiqueta: "Comisión por flujo",
                                valor: "- \(vm.comisionFlujo.formatoSoles)",
                                subtitulo: "Costo de administración \(vm.sistema.rawValue)",
                                colorValor: .red
                            )
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(
                                etiqueta: "Prima de seguro (1.35%)",
                                valor: "- \(vm.primaSeguro.formatoSoles)",
                                subtitulo: "Invalidez, sobrevivencia y sepelio",
                                colorValor: .red
                            )
                        } else {
                            FilaDesglose(
                                etiqueta: "ONP (13%)",
                                valor: "- \(vm.descuentoPension.formatoSoles)",
                                subtitulo: "Sistema Nacional de Pensiones",
                                colorValor: .red
                            )
                        }

                        Divider().padding(.horizontal, 16)
                        FilaDesglose(
                            etiqueta: "Total \(vm.sistema.rawValue)",
                            valor: "- \(vm.descuentoPension.formatoSoles)",
                            destacado: true,
                            colorValor: .red
                        )

                        // IR 5ta
                        Divider().padding(.horizontal, 16)
                        if vm.pagaIR {
                            FilaDesglose(
                                etiqueta: "IR 5ta Categoría mensual",
                                valor: "- \(vm.irMensual.formatoSoles)",
                                subtitulo: "IR anual S/ \(vm.irAnual.formatoSoles) ÷ 12",
                                colorValor: .red
                            )
                        } else {
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("IR 5ta: No aplica — ingreso anual S/ \(vm.ingresoAnualProyectado.formatoSoles) no supera las 7 UIT")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.green.opacity(0.05))
                        }
                    }
                }

                // ── Resultado estilo boleta ──────────────────────
                TarjetaSeccion(titulo: "Resumen boleta de pago",
                               icono: "doc.text.fill") {
                    VStack(spacing: 0) {
                        FilaResultadoSunafil(
                            etiqueta: "Sueldo bruto",
                            valor: vm.sueldoBruto.formatoSoles
                        )
                        Divider().padding(.horizontal, 16)
                        FilaResultadoSunafil(
                            etiqueta: "(-) \(vm.sistema.rawValue)",
                            valor: "- \(vm.descuentoPension.formatoSoles)",
                            esDescuento: true
                        )
                        if vm.pagaIR {
                            Divider().padding(.horizontal, 16)
                            FilaResultadoSunafil(
                                etiqueta: "(-) IR 5ta Categoría",
                                valor: "- \(vm.irMensual.formatoSoles)",
                                esDescuento: true
                            )
                        }
                        Divider().padding(.horizontal, 16)
                        FilaResultadoSunafil(
                            etiqueta: "Sueldo Neto a pagar",
                            valor: vm.sueldoNeto.formatoSoles,
                            esFinal: true
                        )
                    }
                }

                // ── EsSalud referencial ──────────────────────────
                TarjetaSeccion(titulo: "Costo empleador (referencial)",
                               icono: "building.2.fill") {
                    VStack(spacing: 0) {
                        FilaDesglose(
                            etiqueta: "EsSalud (9%) — paga TECSUP",
                            valor: vm.essaludEmpleador.formatoSoles,
                            subtitulo: "No se descuenta al instructor"
                        )
                        Divider().padding(.horizontal, 16)
                        FilaDesglose(
                            etiqueta: "Costo total para TECSUP",
                            valor: (vm.sueldoBruto + vm.essaludEmpleador).formatoSoles,
                            subtitulo: "Bruto + EsSalud",
                            destacado: true
                        )
                    }
                }

                // ── IR detalle ───────────────────────────────────
                if vm.pagaIR {
                    TarjetaSeccion(titulo: "Detalle IR 5ta Categoría",
                                   icono: "percent") {
                        VStack(spacing: 0) {
                            FilaDesglose(
                                etiqueta: "Ingreso anual proyectado",
                                valor: vm.ingresoAnualProyectado.formatoSoles
                            )
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(
                                etiqueta: "(-) 7 UIT no afectas",
                                valor: "- \(vm.montoNoAfecto.formatoSoles)",
                                subtitulo: "7 × S/ 5,350"
                            )
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(
                                etiqueta: "Utilidad Imponible (UI)",
                                valor: vm.utilidadImponible.formatoSoles,
                                destacado: true
                            )
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(
                                etiqueta: "IR anual (tasas progresivas)",
                                valor: vm.irAnual.formatoSoles,
                                colorValor: .red
                            )
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(
                                etiqueta: "IR mensual (÷ 12)",
                                valor: vm.irMensual.formatoSoles,
                                destacado: true,
                                colorValor: .red
                            )
                        }
                    }
                }

                // ── Nueva consulta ───────────────────────────────
                Button {
                    vm.limpiar()
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
        .navigationTitle("Resultado — Instructor")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let vm = InstructorViewModel()
    vm.horasSemanales = 20
    vm.sistema = .afpHabitat
    return NavigationStack { InstructorResultadoView(vm: vm) }
}
