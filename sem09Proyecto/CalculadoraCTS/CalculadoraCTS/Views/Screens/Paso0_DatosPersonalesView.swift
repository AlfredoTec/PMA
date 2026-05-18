//
//  Paso0_DatosPersonalesView.swift
//  CalculadoraCTS
//

// Views/Screens/Paso0_DatosPersonalesView.swift
// Pantalla 0: Datos personales del trabajador

import SwiftUI

struct Paso0_DatosPersonalesView: View {
    @ObservedObject var viewModel: CTSViewModel
    @State private var mostrarError = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                PasoIndicador(pasoActual: 1, total: 4)
                    .padding(.top, 8)

                // ── Tarjeta datos personales ─────────────────────
                TarjetaSeccion(titulo: "Datos del trabajador",
                               icono: "person.fill") {
                    VStack(spacing: 0) {

                        // Nombre
                        CampoTexto(
                            etiqueta: "Nombre completo",
                            subtitulo: "Apellidos y nombres",
                            icono: "person",
                            texto: $viewModel.nombreTrabajador
                        )

                        Divider().padding(.horizontal, 16)

                        // DNI
                        CampoTexto(
                            etiqueta: "N° de DNI",
                            subtitulo: "8 dígitos",
                            icono: "creditcard",
                            texto: $viewModel.dniTrabajador,
                            soloNumeros: true,
                            limiteCaracteres: 8
                        )

                        Divider().padding(.horizontal, 16)

                        // Cargo
                        CampoTexto(
                            etiqueta: "Cargo",
                            subtitulo: "Ej: Docente, Instructor, Administrativo",
                            icono: "briefcase",
                            texto: $viewModel.cargo
                        )

                        Divider().padding(.horizontal, 16)

                        // Fecha de ingreso
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 8) {
                                Image(systemName: "calendar")
                                    .foregroundColor(Color.azulTecsup)
                                    .frame(width: 20)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Fecha de ingreso")
                                        .font(.system(size: 15))
                                    Text("Fecha de inicio del contrato")
                                        .font(.system(size: 11))
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                DatePicker(
                                    "",
                                    selection: $viewModel.fechaIngreso,
                                    displayedComponents: .date
                                )
                                .labelsHidden()
                                .tint(Color.azulTecsup)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)

                        Divider().padding(.horizontal, 16)

                        // Semestre de cálculo
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 8) {
                                Image(systemName: "calendar.badge.clock")
                                    .foregroundColor(Color.azulTecsup)
                                    .frame(width: 20)
                                Text("Semestre de cálculo")
                                    .font(.system(size: 15))
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 10)

                            ForEach(SemestreCTS.allCases, id: \.self) { s in
                                OpcionSeleccion(
                                    texto: s.descripcion,
                                    seleccionado: viewModel.semestre == s
                                ) { viewModel.semestre = s }

                                if s != SemestreCTS.allCases.last {
                                    Divider().padding(.horizontal, 16)
                                }
                            }
                        }
                        .padding(.bottom, 4)
                    }
                }

                // ── Botón siguiente ──────────────────────────────
                NavigationLink(destination:
                    Paso1_DatosView(viewModel: viewModel)
                ) {
                    HStack {
                        Text("Siguiente")
                            .font(.system(size: 17, weight: .bold))
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        viewModel.nombreTrabajador.trimmingCharacters(in: .whitespaces).isEmpty
                        ? Color.gray.opacity(0.4)
                        : Color.azulTecsup
                    )
                    .cornerRadius(14)
                }
                .disabled(viewModel.nombreTrabajador.trimmingCharacters(in: .whitespaces).isEmpty)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)

                if viewModel.nombreTrabajador.trimmingCharacters(in: .whitespaces).isEmpty {
                    Text("Ingresa el nombre del trabajador para continuar")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .padding(.bottom, 16)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Datos personales")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Campo de texto genérico

struct CampoTexto: View {
    let etiqueta: String
    let subtitulo: String
    let icono: String
    @Binding var texto: String
    var soloNumeros: Bool = false
    var limiteCaracteres: Int = 100
    @FocusState private var enfocado: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icono)
                .foregroundColor(Color.azulTecsup)
                .frame(width: 20)

            VStack(alignment: .leading, spacing: 2) {
                Text(etiqueta)
                    .font(.system(size: 15))
                Text(subtitulo)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
            }

            Spacer()

            TextField("", text: $texto)
                .multilineTextAlignment(.trailing)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color.azulTecsup)
                .keyboardType(soloNumeros ? .numberPad : .default)
                .focused($enfocado)
                .frame(maxWidth: 160)
                .onChange(of: texto) { nuevo in
                    if nuevo.count > limiteCaracteres {
                        texto = String(nuevo.prefix(limiteCaracteres))
                    }
                    if soloNumeros {
                        texto = nuevo.filter { $0.isNumber }
                    }
                }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .contentShape(Rectangle())
        .onTapGesture { enfocado = true }
    }
}

#Preview {
    NavigationStack {
        Paso0_DatosPersonalesView(viewModel: CTSViewModel())
    }
}
