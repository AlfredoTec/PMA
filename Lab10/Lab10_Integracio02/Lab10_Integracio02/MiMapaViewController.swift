import SwiftUI
import UIKit
import MapKit

// MARK: - UIKit's UIViewController
class MiMapaViewController: UIViewController {
    var mapa = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Setup the map
        mapa.frame = view.bounds
        mapa.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapa)

        // Set initial center in Lima, Peru coordinates
        let coordenada = CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428)
        let region = MKCoordinateRegion(
            center: coordenada,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
        mapa.setRegion(region, animated: true)
    }
}

// MARK: - Custom Representable Component
struct UIMapView: UIViewControllerRepresentable {
    let controller = MiMapaViewController()

    func makeUIViewController(context: Context) -> MiMapaViewController {
        return controller
    }

    func updateUIViewController(_ uiViewController: MiMapaViewController, context: Context) {
        // Can be empty since `MiMapaViewController` doesn't change dynamically
    }
}
