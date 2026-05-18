//
//  MiViewControllerRepresentable.swift
//  Lab10
//
//  Created by Tecsup on 18/05/26.
//

import Foundation
import SwiftUI

struct MiViewControllerRepresentable:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> MiViewController {
        return MiViewController()
    }
    
    func updateUIViewController(_ uiViewController: MiViewController, context: Context) {
        //
    }
}
