//
//  InstructorViewModel.swift
//  CalculadoraCTS
//
//  Created by Tecsup on 14/05/26.
//
// ViewModels/InstructorViewModel.swift
// Lógica de cálculo del pago de instructores
// Enunciado: pago S/50/hora, máx 23h semanales, AFP específica, IR 5ta

import Foundation
import Combine

class InstructorViewModel: ObservableObject {

    // MARK: - Entradas del usuario
    @Published var horasSemanales:  Double                  = 20
    @Published var sistema:         SistemaPensionesCompleto = .afpHabitat

    // MARK: - Constantes del enunciado
    let pagoPorHora:    Double = 50.0    // S/ 50 por hora (enunciado)
    let maxHoras:       Double = 23.0   // máximo 23 horas semanales
    let uitVigente:     Double = 5350.0 // UIT 2025
    let essaludTasa:    Double = 0.09   // 9% empleador

    // MARK: - Propiedades calculadas (reactivas para la UI)

    var horasEfectivas: Double {
        min(horasSemanales, maxHoras)
    }

    var superaMaxHoras: Bool {
        horasSemanales > maxHoras
    }

    var sueldoBruto: Double {
        horasEfectivas * pagoPorHora * 4
    }

    var descuentoPension: Double {
        sueldoBruto * sistema.tasaTotal
    }

    var ingresoAnualProyectado: Double {
        sueldoBruto * 12
    }

    // 7 UIT = monto no afecto al IR (deducción legal)
    var montoNoAfecto: Double {
        7 * uitVigente   // S/ 37,450
    }

    // Utilidad Imponible = ingreso anual - 7 UIT
    var utilidadImponible: Double {
        max(0, ingresoAnualProyectado - montoNoAfecto)
    }

    var pagaIR: Bool {
        utilidadImponible > 0
    }

    // Cálculo IR 5ta categoría con tasas progresivas
    // Tramo 1: hasta 5 UIT    → 8%
    // Tramo 2: de 5 a 20 UIT  → 14%
    // Tramo 3: de 20 a 35 UIT → 17%
    // Tramo 4: de 35 a 45 UIT → 20%
    // Tramo 5: más de 45 UIT  → 30%
    var irAnual: Double {
        guard pagaIR else { return 0 }
        let uit = uitVigente
        var impuesto = 0.0
        var base = utilidadImponible

        let tramos: [(limite: Double, tasa: Double)] = [
            (5 * uit,  0.08),
            (15 * uit, 0.14),
            (15 * uit, 0.17),
            (10 * uit, 0.20),
            (Double.infinity, 0.30)
        ]

        for tramo in tramos {
            if base <= 0 { break }
            let gravado = min(base, tramo.limite)
            impuesto += gravado * tramo.tasa
            base -= gravado
        }
        return impuesto
    }

    var irMensual: Double {
        irAnual / 12.0
    }

    // EsSalud — costo del empleador (no descuenta al trabajador)
    var essaludEmpleador: Double {
        sueldoBruto * essaludTasa
    }

    // Sueldo neto = bruto - pensión - IR mensual
    var sueldoNeto: Double {
        sueldoBruto - descuentoPension - irMensual
    }

    // MARK: - Desglose AFP detallado
    var aporteObligatorio: Double {
        sistema.esAFP ? sueldoBruto * 0.10 : 0
    }
    var comisionFlujo: Double {
        switch sistema {
        case .afpHabitat:   return sueldoBruto * AFPEspecifica.habitat.comisionFlujo
        case .afpIntegra:   return sueldoBruto * AFPEspecifica.integra.comisionFlujo
        case .afpPrima:     return sueldoBruto * AFPEspecifica.prima.comisionFlujo
        case .afpProfuturo: return sueldoBruto * AFPEspecifica.profuturo.comisionFlujo
        case .onp:          return 0
        }
    }
    var primaSeguro: Double {
        sistema.esAFP ? sueldoBruto * 0.0135 : 0
    }

    // MARK: - Generar resultado completo
    func calcular() -> ResultadoInstructor {
        return ResultadoInstructor(
            horasSemanales:      horasSemanales,
            pagoPorHora:         pagoPorHora,
            sistema:             sistema,
            sueldoBruto:         sueldoBruto,
            descuentoAFP_ONP:    descuentoPension,
            ingresoAnualProyect: ingresoAnualProyectado,
            uitAnual:            montoNoAfecto,
            utilidadImponible:   utilidadImponible,
            irAnual:             irAnual,
            irMensual:           irMensual,
            pagaIR:              pagaIR,
            essaludEmpleador:    essaludEmpleador,
            sueldoNeto:          sueldoNeto,
            superaMaxHoras:      superaMaxHoras,
            horasEfectivas:      horasEfectivas
        )
    }

    func limpiar() {
        horasSemanales = 20
        sistema        = .afpHabitat
    }
}
