//
//  InstructorModelo.swift
//  CalculadoraCTS
//
//  Created by Tecsup on 14/05/26.
//
// Models/InstructorModelo.swift
// Estructuras para el cálculo de pago de instructores

import Foundation

// MARK: - AFP con tasas reales 2026 (fuente SBS)

enum AFPEspecifica: String, CaseIterable {
    case habitat   = "AFP Habitat"
    case integra   = "AFP Integra"
    case prima     = "AFP Prima"
    case profuturo = "AFP Profuturo"

    // Aporte obligatorio (va al fondo del trabajador)
    var aporteObligatorio: Double { 0.10 }

    // Comisión por flujo (costo de administración)
    var comisionFlujo: Double {
        switch self {
        case .habitat:   return 0.0144
        case .integra:   return 0.0147
        case .prima:     return 0.0160
        case .profuturo: return 0.0169
        }
    }

    // Prima de seguro (igual para todas)
    var primaSeguro: Double { 0.0135 }

    // Total que se descuenta del sueldo bruto
    var totalDescuento: Double {
        aporteObligatorio + comisionFlujo + primaSeguro
    }

    var descripcion: String {
        let total = String(format: "%.2f%%", totalDescuento * 100)
        let flujo = String(format: "%.2f%%", comisionFlujo * 100)
        return "\(rawValue)  —  \(total) total (flujo \(flujo))"
    }
}

// MARK: - Sistema de pensiones completo

enum SistemaPensionesCompleto: String, CaseIterable {
    case afpHabitat   = "AFP Habitat"
    case afpIntegra   = "AFP Integra"
    case afpPrima     = "AFP Prima"
    case afpProfuturo = "AFP Profuturo"
    case onp          = "ONP"

    var tasaTotal: Double {
        switch self {
        case .afpHabitat:   return AFPEspecifica.habitat.totalDescuento
        case .afpIntegra:   return AFPEspecifica.integra.totalDescuento
        case .afpPrima:     return AFPEspecifica.prima.totalDescuento
        case .afpProfuturo: return AFPEspecifica.profuturo.totalDescuento
        case .onp:          return 0.13
        }
    }

    var esAFP: Bool { self != .onp }

    var descripcionCorta: String {
        switch self {
        case .afpHabitat:   return "Habitat (12.79%)"
        case .afpIntegra:   return "Integra (12.82%)"
        case .afpPrima:     return "Prima (12.95%)"
        case .afpProfuturo: return "Profuturo (13.04%)"
        case .onp:          return "ONP (13.00%)"
        }
    }
}

// MARK: - Resultado del pago de instructor

struct ResultadoInstructor {
    // Datos base
    let horasSemanales:     Double
    let pagoPorHora:        Double   // S/ 50
    let sistema:            SistemaPensionesCompleto

    // Sueldo bruto
    let sueldoBruto:        Double   // horas × 50 × 4

    // Descuentos del trabajador
    let descuentoAFP_ONP:   Double   // sueldoBruto × tasa
    let ingresoAnualProyect: Double  // sueldoBruto × 12
    let uitAnual:           Double   // 7 × 5350 = 37450
    let utilidadImponible:  Double   // max(0, anual - 7UIT)
    let irAnual:            Double   // IR calculado anual
    let irMensual:          Double   // irAnual / 12
    let pagaIR:             Bool     // supera el mínimo

    // Costo empleador (referencial)
    let essaludEmpleador:   Double   // sueldoBruto × 9%

    // Resultado final
    let sueldoNeto:         Double   // bruto - AFP/ONP - IR

    // Validación
    let superaMaxHoras:     Bool     // > 23 horas
    let horasEfectivas:     Double   // min(horas, 23)

    // Desglose AFP (solo si es AFP)
    var aporteObligatorio: Double {
        guard sistema.esAFP else { return 0 }
        return sueldoBruto * 0.10
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
}
