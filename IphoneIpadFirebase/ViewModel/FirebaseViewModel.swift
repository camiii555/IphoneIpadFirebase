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
                print("Successfull")
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
    
    func createUser(email: String, password: String, completation: @escaping (_ done: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password:password) { user, error in
            if user != nil {
                print("registration completed")
                completation(true)
            } else {
                if let error = error?.localizedDescription {
                    print("Error in firebase registration error", error)
                } else {
                    print("Error in the app")
                }
            }
        }
    }
    
    // MARK: DATABASE
    func saveToDataBase(gameTitle: String, gameDescription: String, gamePlataform: String, gameCover: String, completation: @escaping (_ done: Bool) -> Void) {
        let db = Firestore.firestore()
        let id = UUID().uuidString
        guard let idUser = Auth.auth().currentUser?.uid else { return }
        guard let emailUser = Auth.auth().currentUser?.email else { return }
        let fields: [String: Any] = ["gameTitle": gameTitle, "gameDescription": gameDescription, "cover": gameCover, "idUser": idUser, "emailUser": emailUser]
        db.collection(gamePlataform).document(id).setData(fields) { error in
            if let error = error?.localizedDescription {
                print("Error when saving in firestone", error)
            } else {
                print("successful save")
                completation(true)
            }
        }
    }
}


