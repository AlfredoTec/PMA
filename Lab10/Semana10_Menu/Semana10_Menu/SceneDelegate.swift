import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Verifica que la escena proporcionada sea del tipo UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Crea una nueva ventana usando la escena válida
        let window = UIWindow(windowScene: windowScene)

        // Crea el controlador raíz dentro de un UINavigationController
        let rootVC = UINavigationController(rootViewController: MenuViewController())

        // Asigna el controlador raíz de la ventana
        window.rootViewController = rootVC

        // Guarda la referencia a la ventana en la propiedad del SceneDelegate
        self.window = window

        // Hace que la ventana sea visible y activa en pantalla
        window.makeKeyAndVisible()
    }
}
