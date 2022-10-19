//
//  ImagePicker.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 18/10/22.
//

import Foundation
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
   
    @Binding var showPhoto: Bool
    @Binding var image: Data
    var source: UIImagePickerController.SourceType
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(connection: self)
    }
    
    
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = source
        controller.allowsEditing = true
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var connection: ImagePicker
        
        init(connection: ImagePicker) {
            self.connection = connection
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("it was canceled")
            self.connection.showPhoto.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            let data = image.jpegData(compressionQuality: 0.100)
            self.connection.image = data!
            self.connection.showPhoto.toggle()
        }
    }
    
}
