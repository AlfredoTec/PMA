import UIKit

class Vista3ViewController: UIViewController {

    // Campos de entrada
    private let stackContainer = UIStackView()

    private let montoLabel = UILabel()
    private let montoTextField = UITextField()

    private let tasaLabel = UILabel()
    private let tasaTextField = UITextField()

    private let plazoLabel = UILabel()
    private let plazoTextField = UITextField()

    // Campos de resultados
    private let cuotaLabel = UILabel()
    private let interesLabel = UILabel()
    private let totalLabel = UILabel()

    // Botones
    private let calcularButton = UIButton()
    private let regresarButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        view.backgroundColor = .white
        title = "Simulador de Préstamos - PERÚ 🇹🇪" // Corregido a emoji de Perú

        // Configuramos todos los componentes
        configurarLabels()
        configurarTextFields()
        configurarLabelsResultados()
        configurarBotones()

        // Distribuimos los componentes en la vista
        distribuirComponentes()

        // Diseño de la interfaz
        diseñoInterfaz()

        // Conectamos el testoField con su delegate para aceptar solo números
        montoTextField.delegate = self
        tasaTextField.delegate = self
        plazoTextField.delegate = self
    }

    private func configurarLabels() {
        montoLabel.text = "Monto (S/)"
        montoLabel.font = UIFont.boldSystemFont(ofSize: 16)

        tasaLabel.text = "TEA (Tasa Anual %)"
        tasaLabel.font = UIFont.boldSystemFont(ofSize: 16)

        plazoLabel.text = "Plazo (meses)"
        plazoLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }

    private func configurarTextFields() {
        let textFields = [montoTextField, tasaTextField, plazoTextField]

        for field in textFields {
            field.borderStyle = .roundedRect
            field.backgroundColor = .white
            field.textAlignment = .center

            // Saltar al siguiente campo con el Return key
            field.returnKeyType = .next
            field.keyboardAppearance = .light
        }

        // Configuramos un teclado específico según el textoField
        montoTextField.keyboardType = .decimalPad
        tasaTextField.keyboardType = .decimalPad
        plazoTextField.keyboardType = .numberPad
    }

    private func configurarLabelsResultados() {
        cuotaLabel.text = "Cuota Mensual:"
        cuotaLabel.font = UIFont.boldSystemFont(ofSize: 16)

        cuotaLabel.textAlignment = .left

        interesLabel.text = "Interés Total:"
        interesLabel.font = UIFont.boldSystemFont(ofSize: 16)
        interesLabel.textAlignment = .left

        totalLabel.text = "Monto Total:"
        totalLabel.font = UIFont.boldSystemFont(ofSize: 16)
        totalLabel.textColor = .systemOrange
        totalLabel.textAlignment = .left
    }

    private func configurarBotones() {
        calcularButton.setTitle("📊 CALCULAR PRÉSTAMO", for: .normal)
        calcularButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        calcularButton.backgroundColor = .systemGreen
        calcularButton.setTitleColor(.white, for: .normal)
        calcularButton.addTarget(self, action: #selector(calculateLoan), for: .touchUpInside)
        calcularButton.layer.cornerRadius = 8

        regresarButton.setTitle("← REGRESAR", for: .normal)
        regresarButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        regresarButton.setTitleColor(.blue, for: .normal)
        regresarButton.addTarget(self, action: #selector(returnToMenu), for: .touchUpInside)
    }

    private func distribuirComponentes() {
        // Creamos un stack view para los inputs
        let inputsStackView = UIStackView(arrangedSubviews: [
            crearStackDeCampos(con: montoLabel, textField: montoTextField),
            crearStackDeCampos(con: tasaLabel, textField: tasaTextField),
            crearStackDeCampos(con: plazoLabel, textField: plazoTextField),
            calcularButton
        ])
        inputsStackView.distribution = .fillEqually
        inputsStackView.axis = .vertical
        inputsStackView.spacing = 15

        // Creamos un stack view para results
        let resultsStackView = UIStackView(arrangedSubviews: [
            cuotaLabel, interesLabel, totalLabel
        ])
        resultsStackView.axis = .vertical
        resultsStackView.distribution = .fillEqually
        resultsStackView.spacing = 10

        let definitiveStackView = UIStackView(arrangedSubviews: [
            inputsStackView,
            resultsStackView,
            regresarButton
        ])

        definitiveStackView.axis = .vertical
        definitiveStackView.spacing = 20

        // Añadimos la vista principal creado al ViewController
        view.addSubview(definitiveStackView)
        stackContainer.distribution = UIStackView.Distribution.fill
        definitiveStackView.translatesAutoresizingMaskIntoConstraints = false

        // Hacemos constraints inferiores y laterales
        NSLayoutConstraint.activate([
            definitiveStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            definitiveStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            definitiveStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }

    private func crearStackDeCampos(con label: UILabel, textField: UITextField) -> UIView {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }

    private func diseñoInterfaz() {
        // Número y diseño de cada campo de intento
        [montoTextField, tasaTextField, plazoTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalToConstant: 180),
                $0.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
    }

    @objc private func calculateLoan() {
        guard let montoStr = montoTextField.text, let monto = Double(montoStr),
              let tasaStr = tasaTextField.text, let tasa = Double(tasaStr),
              let plazoStr = plazoTextField.text, let plazo = Int(plazoStr) else {
            presentAlert(title: "Error", message: "Todos los campos deben ser valores válidos.")
            return
        }

        // Validación de valores
        if monto <= 0 || tasa <= 0 || plazo <= 0 {
            presentAlert(title: "Error", message: "Los valores deben ser mayores que cero.")
            return
        }

        // Conversión de la tasa anual a tasa mensual
        let tasaMensual = tasa / 100 / 12

        // Fórmula para el cálculo de la cuota con interés compuesto
        let cuotaMensual = monto * (tasaMensual * pow(1 + tasaMensual, Double(plazo))) / (pow(1 + tasaMensual, Double(plazo)) - 1)

        // Cálculo adicional
        let montoTotal = cuotaMensual * Double(plazo)
        let interesTotal = montoTotal - monto

        // Formateo para presentar los resultados
        let formatter: NumberFormatter = {
            let f = NumberFormatter()
            f.numberStyle = .decimal
            f.maximumFractionDigits = 2
            return f
        }()

        cuotaLabel.text! += " S/ \(formatter.string(from: NSNumber(value: cuotaMensual)) ?? "0.00")"
        interesLabel.text! += " S/ \(formatter.string(from: NSNumber(value: interesTotal)) ?? "0.00")"
        totalLabel.text! += " S/ \(formatter.string(from: NSNumber(value: montoTotal)) ?? "0.00")"
    }

    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @objc private func returnToMenu() {
        navigationController?.popViewController(animated: true)
    }
}

extension Vista3ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == montoTextField {
            tasaTextField.becomeFirstResponder()
        } else if textField == tasaTextField {
            plazoTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Permitir sólo un punto decimal y ceros
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let allowedStrings = CharacterSet(charactersIn: string)

        // Evitar añadir puntos después de otro que ya esté presente
        if string == "." && textField.text?.contains(".") ?? false {
            return false
        }
        return allowedStrings.isSubset(of: allowedCharacters)
    }
}
