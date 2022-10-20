//
//  CoverViewModel.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 19/10/22.
//

import Foundation
import FirebaseStorage

class CoverViewModel: ObservableObject {
    
    @Published var data: Data? = nil
    
    init(imageUrl: String) {
        let storageImage = Storage.storage().reference(forURL: imageUrl)
        storageImage.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error?.localizedDescription {
                print("Error bringing image", error)
            } else {
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }
    }
}
