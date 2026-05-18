//
//  CTSModelo.swift
//  CalculadoraCTS
//

// Models/CTSModelo.swift
// Estructuras de datos — sin lógica de UI

import Foundation

struct CTSEntrada {
    var regimen:             RegimenLaboral   = .actividadPrivada
    var pension:             SistemaPensiones = .afp
    var diasSemana:          DiasSemanales    = .lunesViernes
    var horasSemanales:      Double           = 40
    var sueldoBasico:        Double           = 0
    var otrasRemuneraciones: Double           = 0
    var asignacionFamiliar:  Bool             = false
    let montoAsignacion:     Double           = 102.50
    var gratificacion:       Double           = 0
    var mesesCompletos:      Int              = 6
    var diasAdicionales:     Int              = 0
    var diasInasistencia:    Int              = 0  // NUEVO
}

struct ResultadoCTS {
    // Validaciones
    let promedioDiario:        Double
    let esTiempoCompleto:      Bool
    let regimenValido:         Bool
    let corresponde:           Bool

    // Cálculos
    let totalRemuneracion:     Double
    let sextoParte:            Double
    let baseComputable:        Double
    let mesesAjustados:        Double
    let factorProporcional:    Double
    let ctsBruta:              Double
    let descuentoInasistencia: Double   // NUEVO
    let tasaPrevisional:       Double
    let descuento:             Double
    let ctsNeta:               Double

    var mensajeValidacion: String {
        if !regimenValido {
            return "Régimen CAS: no corresponde CTS (SUNAFIL)"
        }
        if !esTiempoCompleto {
            let hrs = String(format: "%.1f", promedioDiario)
            return "Tiempo parcial (\(hrs) h/día < 4 h): no corresponde CTS"
        }
        return "Corresponde CTS"
    }
}
