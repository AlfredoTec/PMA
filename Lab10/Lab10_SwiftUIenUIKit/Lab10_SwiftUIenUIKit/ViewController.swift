import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 50))

        view.addSubview(button)
        button.center = view.center

        button.setTitle("Mostrar SwiftUI", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc func didTapButton() {
        let vc = UIHostingController(rootView: SettingScreen())
        present(vc, animated: true)
    }
}
