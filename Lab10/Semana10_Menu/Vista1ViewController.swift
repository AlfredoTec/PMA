import UIKit

class Vista1ViewController: UIViewController {
    let numero1TextField = UITextField()
    let numero2TextField = UITextField()
    let resultadoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Vista 1 - Multiplicador"

        configurarTextField(numero1TextField, placeholder: "Ingrese número 1")
        configurarTextField(numero2TextField, placeholder: "Ingrese número 2")
        let calcularButton = UIButton(type: .system)
        calcularButton.setTitle("Calcular", for: .normal)
        calcularButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        calcularButton.addTarget(self, action: #selector(calcular), for: .touchUpInside)

        resultadoLabel.text = "Resultado:"
        resultadoLabel.font = .systemFont(ofSize: 20)
        resultadoLabel.textAlignment = .center

        let volverButton = UIButton(type: .system)
        volverButton.setTitle("Volver al menú", for: .normal)
        volverButton.titleLabel?.font = .systemFont(ofSize: 16)
        volverButton.addTarget(self, action: #selector(volverAlMenu), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [
            numero1TextField,
            numero2TextField,
            calcularButton,
            resultadoLabel,
            volverButton
        ])

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numero1TextField.widthAnchor.constraint(equalToConstant: 200),
            numero2TextField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configurarTextField(_ textField: UITextField, placeholder: String) {
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc func calcular() {
        guard let texto1 = numero1TextField.text, let texto2 = numero2TextField.text,
                let num1 = Double(texto1), let num2 = Double(texto2) else {
                resultadoLabel.text = "Ingrese números válidos"
            return
        }

        let resultado = num1 * num2
        resultadoLabel.text = "Resultado: \(resultado)"
    }

    @objc func volverAlMenu() {
        navigationController?.popViewController(animated: true)
    }
}
