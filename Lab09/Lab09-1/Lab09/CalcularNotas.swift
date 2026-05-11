import SwiftUI

struct CalculoNotasView: View {
    @State private var nota1: String = ""
    @State private var nota2: String = ""
    @State private var nota3: String = ""
    @State private var nota4: String = ""
    @State private var laboratorioAnulado: Bool = false
    @State private var promedio: Double?
    @State private var mensajeError: String?
    @State private var mostrarResultado: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Cálculo de Notas de Teoría")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    Text("Programación en Móviles Avanzado")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    // Sección de ingreso de notas
                    VStack(spacing: 15) {
                        Text("Ingrese las 4 notas de teoría (0-20):")
                            .font(.headline)
                        
                        HStack(spacing: 15) {
                            NotaTextField(titulo: "Nota 1", texto: $nota1)
                            NotaTextField(titulo: "Nota 2", texto: $nota2)
                        }
                        
                        HStack(spacing: 15) {
                            NotaTextField(titulo: "Nota 3", texto: $nota3)
                            NotaTextField(titulo: "Nota 4", texto: $nota4)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    
                    // Toggle para laboratorio anulado
                    Toggle(isOn: $laboratorioAnulado) {
                        VStack(alignment: .leading) {
                            Text("¿Laboratorio Anulado (AN)?")
                                .font(.headline)
                            Text("Si el laboratorio está anulado, no se eliminará la menor nota")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(15)
                    
                    // Botón de calcular
                    Button(action: calcularPromedio) {
                        Text("Calcular Promedio")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    
                    // Mensaje de error
                    if let error = mensajeError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    // Resultado
                    if mostrarResultado, let promedioFinal = promedio {
                        VStack(spacing: 15) {
                            Text("Resultado")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            HStack {
                                Text("Promedio Final:")
                                    .font(.title2)
                                Text(String(format: "%.1f", promedioFinal))
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(promedioFinal >= 13 ? .green : .red)
                            }
                            
                            if laboratorioAnulado {
                                Text("⚠️ Laboratorio Anulado - No se eliminó la menor nota")
                                    .font(.caption)
                                    .foregroundColor(.orange)
                            } else {
                                Text("✓ Se eliminó la menor nota para el cálculo")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            
                            // Estado del curso
                            HStack {
                                Image(systemName: promedioFinal >= 13 ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .font(.title)
                                Text(promedioFinal >= 13 ? "APROBADO" : "DESAPROBADO")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(promedioFinal >= 13 ? .green : .red)
                            .padding()
                            .background((promedioFinal >= 13 ? Color.green : Color.red).opacity(0.1))
                            .cornerRadius(15)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                    
                    // Botón de limpiar
                    if mostrarResultado {
                        Button(action: limpiarCampos) {
                            Text("Nuevo Cálculo")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(15)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("TECSUP")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Función para validar y calcular el promedio
    func calcularPromedio() {
        // Limpiar mensajes anteriores
        mensajeError = nil
        mostrarResultado = false
        
        // Validar que todos los campos tengan valores
        guard let n1 = Double(nota1.replacingOccurrences(of: ",", with: ".")),
              let n2 = Double(nota2.replacingOccurrences(of: ",", with: ".")),
              let n3 = Double(nota3.replacingOccurrences(of: ",", with: ".")),
              let n4 = Double(nota4.replacingOccurrences(of: ",", with: ".")) else {
            mensajeError = "❌ Por favor, ingrese todas las notas. Use números válidos."
            return
        }
        
        // Validar que las notas estén entre 0 y 20
        let notas = [n1, n2, n3, n4]
        for (index, nota) in notas.enumerated() {
            if nota < 0 || nota > 20 {
                mensajeError = "❌ La nota \(index + 1) (\(nota)) debe estar entre 0 y 20"
                return
            }
        }
        
        // Calcular promedio según condiciones
        var notasParaPromedio: [Double]
        
        if laboratorioAnulado {
            // Si el laboratorio está anulado, se consideran todas las notas
            notasParaPromedio = notas
        } else {
            // Se elimina la menor nota
            var notasOrdenadas = notas.sorted()
            notasOrdenadas.removeFirst() // Eliminar la menor
            notasParaPromedio = notasOrdenadas
        }
        
        // Calcular el promedio
        let suma = notasParaPromedio.reduce(0, +)
        let promedioCalculado = suma / Double(notasParaPromedio.count)
        
        // Redondear el promedio
        promedio = round(promedioCalculado * 10) / 10 // Redondear a 1 decimal
        mostrarResultado = true
    }
    
    // Función para limpiar todos los campos
    func limpiarCampos() {
        nota1 = ""
        nota2 = ""
        nota3 = ""
        nota4 = ""
        laboratorioAnulado = false
        promedio = nil
        mensajeError = nil
        mostrarResultado = false
    }
}

// Componente personalizado para campos de texto de notas
struct NotaTextField: View {
    let titulo: String
    @Binding var texto: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(titulo)
                .font(.caption)
                .foregroundColor(.gray)
            TextField("0-20", text: $texto)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity)
        }
    }
}

// Vista previa
#Preview {
    CalculoNotasView()
}
