//
//  CTSViewModel.swift
//  CalculadoraCTS
//

// ViewModels/CTSViewModel.swift
// Lógica de negocio, fórmulas y estado de la app

import Foundation
import Combine

// MARK: - Enum semestre

enum SemestreCTS: String, CaseIterable {
    case novAbrActual  = "Noviembre–Abril (depósito mayo)"
    case mayOctActual  = "Mayo–Octubre (depósito noviembre)"

    var descripcion: String { self.rawValue }
}

class CTSViewModel: ObservableObject {

    // MARK: - Datos personales (NUEVO)
    @Published var nombreTrabajador: String  = ""
    @Published var dniTrabajador: String     = ""
    @Published var cargo: String             = ""
    @Published var fechaIngreso: Date        = Date()
    @Published var semestre: SemestreCTS     = .novAbrActual

    // MARK: - Sección A: Datos laborales
    @Published var regimen:             RegimenLaboral   = .actividadPrivada
    @Published var pension:             SistemaPensiones = .afp
    @Published var diasSemana:          DiasSemanales    = .lunesViernes
    @Published var horasSemanales:      Double           = 40

    // MARK: - Sección B: Remuneración
    @Published var sueldoBasico:        Double           = 0
    @Published var otrasRemuneraciones: Double           = 0
    @Published var asignacionFamiliar:  Bool             = false
    let montoAsignacion:                Double           = 102.50

    // MARK: - Sección C: Gratificación y período
    @Published var gratificacion:       Double           = 0
    @Published var mesesCompletos:      Int              = 6
    @Published var diasAdicionales:     Int              = 0

    // MARK: - Inasistencias (NUEVO)
    @Published var diasInasistencia:    Int              = 0

    // MARK: - Propiedades calculadas en tiempo real

    var promedioDiario: Double {
        guard diasSemana.rawValue > 0 else { return 0 }
        return horasSemanales / Double(diasSemana.rawValue)
    }

    var esTiempoCompleto: Bool { promedioDiario >= 4.0 }
    var regimenValido: Bool    { regimen != .cas }
    var corresponde: Bool      { esTiempoCompleto && regimenValido }

    var totalRemuneracion: Double {
        sueldoBasico + otrasRemuneraciones +
        (asignacionFamiliar ? montoAsignacion : 0)
    }

    var sextoParte: Double { gratificacion / 6.0 }

    var mesesAjustados: Double {
        Double(mesesCompletos + (diasAdicionales >= 15 ? 1 : 0))
    }

    var factorProporcional: Double { mesesAjustados / 12.0 }

    // Descuento por inasistencias (proporcional a días del semestre ~180 días)
    var descuentoInasistencia: Double {
        guard corresponde && diasInasistencia > 0 else { return 0 }
        let ctsBruta = (totalRemuneracion + sextoParte) * factorProporcional
        return (ctsBruta / 180.0) * Double(diasInasistencia)
    }

    // MARK: - Cálculo principal

    func calcular() -> ResultadoCTS {
        let base   = totalRemuneracion + sextoParte
        let bruta  = corresponde ? base * factorProporcional : 0.0
        let descIn = corresponde ? descuentoInasistencia : 0.0
        let brutaConDesc = bruta - descIn
        let tasa   = pension.tasa
        let desc   = brutaConDesc * tasa
        let neta   = brutaConDesc - desc

        return ResultadoCTS(
            promedioDiario:        promedioDiario,
            esTiempoCompleto:      esTiempoCompleto,
            regimenValido:         regimenValido,
            corresponde:           corresponde,
            totalRemuneracion:     totalRemuneracion,
            sextoParte:            sextoParte,
            baseComputable:        base,
            mesesAjustados:        mesesAjustados,
            factorProporcional:    factorProporcional,
            ctsBruta:              bruta,
            descuentoInasistencia: descIn,
            tasaPrevisional:       tasa,
            descuento:             desc,
            ctsNeta:               neta
        )
    }

    // MARK: - Reset
    func limpiar() {
        nombreTrabajador    = ""
        dniTrabajador       = ""
        cargo               = ""
        fechaIngreso        = Date()
        semestre            = .novAbrActual
        regimen             = .actividadPrivada
        pension             = .afp
        diasSemana          = .lunesViernes
        horasSemanales      = 40
        sueldoBasico        = 0
        otrasRemuneraciones = 0
        asignacionFamiliar  = false
        gratificacion       = 0
        mesesCompletos      = 6
        diasAdicionales     = 0
        diasInasistencia    = 0
    }
}
