import UIKit

class Vista2ViewController: UIViewController {

    let capitalTextField = UITextField()
    let tasaInterestTextField = UITextField()
    let añosTextField = UITextField()
    let resultadoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Interés Compuesto"

        // Configuración de los campos de texto
        configurarTextField(capitalTextField, placeholder: "Monto Inicial")
        configurarTextField(tasaInterestTextField, placeholder: "Tasa Anual (%)")
        configurarTextField(añosTextField, placeholder: "Años")

        // Botón de cálculo
        let calcularButton = UIButton(type: .system)
        calcularButton.setTitle("📈 Calcular Interés", for: .normal)
        calcularButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        calcularButton.addTarget(self, action: #selector(calcularInteresCompuesto), for: .touchUpInside)

        // Configuración de resultado
        resultadoLabel.text = "Monto final:"
        resultadoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        resultadoLabel.textAlignment = .center
        resultadoLabel.numberOfLines = 0

        // Botón de volver
        let volverButton = UIButton(type: .system)
        volverButton.setTitle("← REGRESAR", for: .normal)
        volverButton.titleLabel?.font = .systemFont(ofSize: 16)
        volverButton.addTarget(self, action: #selector(volverAlMenu), for: .touchUpInside)

        // Stack View
        let stackView = UIStackView(arrangedSubviews: [
            capitalTextField,
            tasaInterestTextField,
            añosTextField,
            calcularButton,
            resultadoLabel,
            volverButton
        ])

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        resultadoLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            // Centro el stack view verticalmente
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            // Ancho fijo para todos los campos
            capitalTextField.widthAnchor.constraint(equalToConstant: 250),
            tasaInterestTextField.widthAnchor.constraint(equalToConstant: 250),
            añosTextField.widthAnchor.constraint(equalToConstant: 250),

            // Anchura mínima adecuada para el resultado (2 líneas de texto)
            resultadoLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
    }

    private func configurarTextField(_ textField: UITextField, placeholder: String) {
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false

        switch placeholder {
        case "Monto Inicial", "Tasa Anual (%)", "Años":
            textField.keyboardType = .decimalPad
        default:
            textField.keyboardType = .default
        }

        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing

        // Configuración adicional para oscurecer el teclado numérico si es necesario
        textField.keyboardAppearance = .light
    }

    @objc func calcularInteresCompuesto() {
        // Validación de inputs
        guard let capitalString = capitalTextField.text, !capitalString.isEmpty,
              let tasaString = tasaInterestTextField.text, !tasaString.isEmpty,
              let añosString = añosTextField.text, !añosString.isEmpty,

              let capital = Double(capitalString),
              let tasa = Double(tasaString),
              let años = Double(añosString) else {

            resultadoLabel.text = "❌ Error: Todos los campos deben ser números válidos"
            resultadoLabel.textColor = .red
            return
        }

        // Cálculo del interés compuesto
        let interesDecimal = tasa / 100
        let montoFinal = capital * pow((1 + interesDecimal), años)

        // Formatear el resultado como moneda (con decimales sin símbolos)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2

        if let formattedResult = formatter.string(from: NSNumber(value: montoFinal)) {
            resultadoLabel.text = "Monto final: S/ \(formattedResult)"
            resultadoLabel.textColor = .black
        } else {
            // Poner el valor exacto sin formato en caso de fallo
            resultadoLabel.text = "Monto final: \(montoFinal)"
            resultadoLabel.textColor = .black
        }
    }

    @objc func volverAlMenu() {
        navigationController?.popViewController(animated: true)
    }
}
