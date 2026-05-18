//
//  MenuPrincipal.swift
//  CalculadoraCTS
//
//  Created by Tecsup on 14/05/26.
//

import SwiftUI

struct MenuPrincipal: View {
    @StateObject private var viewModel = CTSViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.10, green: 0.32, blue: 0.53),
                        Color(red: 0.18, green: 0.44, blue: 0.65)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    // ── Logo ─────────────────────────────────────
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.15))
                                .frame(width: 90, height: 90)
                            Image(systemName: "building.columns.fill")
                                .font(.system(size: 46))
                                .foregroundColor(.white)
                        }
                        Text("TECSUP")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Text("Calculadora Laboral")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.85))
                    }

                    Spacer().frame(height: 36)

                    // ── Módulo 1: CTS ────────────────────────────
                    NavigationLink(destination:
                        Paso0_DatosPersonalesView(viewModel: viewModel)
                    ) {
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.15))
                                    .frame(width: 52, height: 52)
                                Image(systemName: "banknote.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Calculadora CTS")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(Color(red: 0.10, green: 0.32, blue: 0.53))
                                Text("Compensación por Tiempo de Servicios")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 0.10, green: 0.32, blue: 0.53).opacity(0.7))
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(red: 0.10, green: 0.32, blue: 0.53).opacity(0.5))
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding(18)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                    }
                    .padding(.horizontal, 24)

                    Spacer().frame(height: 16)

                    // ── Módulo 2: Pago Instructores ───────────────
                    NavigationLink(destination: InstructorView()) {
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.15))
                                    .frame(width: 52, height: 52)
                                Image(systemName: "person.fill.checkmark")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Pago de Instructores")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(Color(red: 0.10, green: 0.32, blue: 0.53))
                                Text("AFP específica · IR 5ta · Sueldo por horas")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 0.10, green: 0.32, blue: 0.53).opacity(0.7))
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(red: 0.10, green: 0.32, blue: 0.53).opacity(0.5))
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding(18)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                    }
                    .padding(.horizontal, 24)

                    Spacer().frame(height: 32)

                    // ── Info cards ───────────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundColor(.white).frame(width: 22)
                            Text("Basada en SUNAFIL y D.S. 001-97-TR")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                        }
                        HStack(spacing: 10) {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.white).frame(width: 22)
                            Text("Valida jornada parcial y régimen CAS")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                        }
                        HStack(spacing: 10) {
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.white).frame(width: 22)
                            Text("AFP Habitat · Integra · Prima · Profuturo · ONP")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    .padding(16)
                    .background(Color.white.opacity(0.12))
                    .cornerRadius(14)
                    .padding(.horizontal, 24)

                    Spacer().frame(height: 16)

                    Text("(*) Cálculo referencial según SUNAFIL\nDepósito CTS: 1–15 mayo y 1–15 noviembre")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview { MenuPrincipal() }
