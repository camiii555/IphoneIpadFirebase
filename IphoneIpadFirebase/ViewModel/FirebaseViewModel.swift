//
//  FirebaseViewModel.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 8/09/22.
//

import Foundation
import Firebase

class FirebaseViewModel: ObservableObject {
    @Published var loginShow: Bool = false
    
    
    func Login(email: String, password: String, completation: @escaping  (_ done: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { userData, error in
            if userData != nil {
                print("Entro")
                completation(true)
            } else {
                if let error = error?.localizedDescription {
                    print("Error in firebase", error)
                } else {
                    print("Error in the app")
                }
            }
        }
    }
    
}

