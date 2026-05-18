import UIKit
import SwiftUI

class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let menuView = MenuNavegacionView { opcion in
            switch opcion {
            case "vista1":
                self.navigationController?.pushViewController(Vista1ViewController(), animated: true)
            case "vista2":
                self.navigationController?.pushViewController(Vista2ViewController(), animated: true)
            case "vista3":
                self.navigationController?.pushViewController(Vista3ViewController(), animated: true)
            default:
                break
            }
        }

        let hosting = UIHostingController(rootView: menuView)
        addChild(hosting)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hosting.view)

        NSLayoutConstraint.activate([
            hosting.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hosting.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        hosting.didMove(toParent: self)
    }
}
