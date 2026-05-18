//
//  InstructorView.swift
//  CalculadoraCTS
//
//  Created by Tecsup on 14/05/26.
//

import SwiftUI

// Views/Screens/InstructorView.swift
// Módulo 2: Cálculo del pago de instructores TECSUP

struct InstructorView: View {
    @StateObject private var vm = InstructorViewModel()
    @State private var mostrarResultado = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // ── Banner informativo ───────────────────────────
                HStack(spacing: 12) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(Color.azulTecsup)
                        .font(.system(size: 20))
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Pago por hora: S/ 50.00")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Máximo 23 horas semanales según enunciado")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding(14)
                .background(Color.azulTecsupSuave)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top, 8)

                // ── Horas semanales ──────────────────────────────
                TarjetaSeccion(titulo: "Horas trabajadas",
                               icono: "clock.fill") {
                    VStack(spacing: 16) {

                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Horas semanales")
                                    .font(.system(size: 15))
                                Text("Máximo permitido: 23 horas")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Stepper(value: $vm.horasSemanales,
                                    in: 1...30, step: 1) {
                                Text("\(Int(vm.horasSemanales)) h")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(
                                        vm.superaMaxHoras
                                        ? .red : Color.azulTecsup
                                    )
                                    .frame(minWidth: 60, alignment: .trailing)
                            }
                            .fixedSize()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 4)

                        // Aviso si supera el máximo
                        if vm.superaMaxHoras {
                            HStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                Text("Supera el máximo. Se usarán 23 horas para el cálculo.")
                                    .font(.system(size: 12))
                                    .foregroundColor(.orange)
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 4)
                        }

                        Divider().padding(.horizontal, 16)

                        // Sueldo bruto reactivo
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Sueldo bruto mensual")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.secondary)
                                Text("\(Int(vm.horasEfectivas)) h × S/50 × 4 semanas")
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(vm.sueldoBruto.formatoSoles)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(Color.azulTecsup)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.azulTecsupSuave)
                        .padding(.bottom, 4)
                    }
                }

                // ── Sistema de pensiones ─────────────────────────
                TarjetaSeccion(titulo: "Sistema de pensiones",
                               icono: "shield.fill") {
                    VStack(spacing: 0) {

                        // Sección AFP
                        VStack(alignment: .leading, spacing: 6) {
                            Text("AFP — Sistema Privado de Pensiones")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 16)
                                .padding(.top, 10)

                            ForEach([SistemaPensionesCompleto.afpHabitat,
                                     .afpIntegra, .afpPrima, .afpProfuturo],
                                    id: \.self) { s in
                                OpcionSeleccion(
                                    texto: s.descripcionCorta,
                                    seleccionado: vm.sistema == s
                                ) { vm.sistema = s }
                                Divider().padding(.horizontal, 16)
                            }
                        }

                        // Sección ONP
                        VStack(alignment: .leading, spacing: 6) {
                            Text("ONP — Sistema Nacional de Pensiones")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 16)
                                .padding(.top, 8)

                            OpcionSeleccion(
                                texto: SistemaPensionesCompleto.onp.descripcionCorta,
                                seleccionado: vm.sistema == .onp
                            ) { vm.sistema = .onp }
                        }
                        .padding(.bottom, 8)

                        // Desglose AFP en tiempo real
                        if vm.sistema.esAFP {
                            Divider().padding(.horizontal, 16)
                            VStack(spacing: 6) {
                                FilaDesglose(etiqueta: "Aporte obligatorio (10%)",
                                             valor: vm.aporteObligatorio.formatoSoles)
                                FilaDesglose(etiqueta: "Comisión por flujo",
                                             valor: vm.comisionFlujo.formatoSoles)
                                FilaDesglose(etiqueta: "Prima de seguro (1.35%)",
                                             valor: vm.primaSeguro.formatoSoles)
                                FilaDesglose(etiqueta: "Total descuento AFP",
                                             valor: vm.descuentoPension.formatoSoles,
                                             destacado: true)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }

                // ── IR 5ta Categoría ─────────────────────────────
                TarjetaSeccion(titulo: "Impuesto a la Renta 5ta Categoría",
                               icono: "percent") {
                    VStack(spacing: 0) {

                        FilaDesglose(
                            etiqueta: "Ingreso anual proyectado",
                            valor: vm.ingresoAnualProyectado.formatoSoles,
                            subtitulo: "Sueldo bruto × 12 meses"
                        )
                        Divider().padding(.horizontal, 16)
                        FilaDesglose(
                            etiqueta: "Deducción: 7 UIT",
                            valor: "- \(vm.montoNoAfecto.formatoSoles)",
                            subtitulo: "7 × S/ 5,350 — monto no afecto",
                            colorValor: .secondary
                        )
                        Divider().padding(.horizontal, 16)
                        FilaDesglose(
                            etiqueta: "Utilidad Imponible (UI) anual",
                            valor: vm.utilidadImponible.formatoSoles,
                            destacado: true
                        )
                        Divider().padding(.horizontal, 16)

                        if vm.pagaIR {
                            FilaDesglose(
                                etiqueta: "IR anual (tasas progresivas)",
                                valor: vm.irAnual.formatoSoles,
                                colorValor: .red
                            )
                            Divider().padding(.horizontal, 16)
                            FilaDesglose(
                                etiqueta: "IR mensual (IR anual ÷ 12)",
                                valor: vm.irMensual.formatoSoles,
                                destacado: true,
                                colorValor: .red
                            )
                        } else {
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("No paga IR — ingreso anual no supera las 7 UIT (S/ \(vm.montoNoAfecto.formatoSoles))")
                                    .font(.system(size: 13))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(Color.green.opacity(0.06))
                        }
                    }
                }

                // ── EsSalud (referencial) ────────────────────────
                TarjetaSeccion(titulo: "EsSalud — costo del empleador",
                               icono: "cross.circle.fill") {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("EsSalud (9% del sueldo bruto)")
                                .font(.system(size: 15))
                            Text("Lo paga TECSUP — no descuenta al instructor")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text(vm.essaludEmpleador.formatoSoles)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(Color.gray.opacity(0.04))
                }

                // ── Botón calcular ───────────────────────────────
                NavigationLink(destination:
                    InstructorResultadoView(vm: vm)
                ) {
                    HStack {
                        Text("Ver pago neto")
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
                .padding(.bottom, 32)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Pago de Instructores")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack { InstructorView() }
}
