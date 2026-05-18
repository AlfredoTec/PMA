//
//  RegimenLaboral.swift
//  CalculadoraCTS
//
//  Created by Tecsup on 14/05/26.
//
// Models/RegimenLaboral.swift
// Enumeraciones del dominio laboral
// Basado en D.S. 001-97-TR y DL 728

import Foundation

enum RegimenLaboral: String, CaseIterable {
    case actividadPrivada = "Actividad Privada (DL 728)"
    case cas              = "CAS (D. Leg. 1057)"
}

enum SistemaPensiones: String, CaseIterable {
    case afp = "AFP"
    case onp = "ONP"

    var tasa: Double {
        switch self {
        case .afp: return 0.1275   // 12.75%
        case .onp: return 0.1300   // 13.00%
        }
    }

    var descripcion: String {
        switch self {
        case .afp: return "AFP — 12.75%"
        case .onp: return "ONP — 13.00%"
        }
    }
}

enum DiasSemanales: Int, CaseIterable {
    case lunesViernes = 5
    case lunesSabado  = 6

    var descripcion: String {
        switch self {
        case .lunesViernes: return "Lunes a Viernes (5 días)"
        case .lunesSabado:  return "Lunes a Sábado (6 días)"
        }
    }
}
