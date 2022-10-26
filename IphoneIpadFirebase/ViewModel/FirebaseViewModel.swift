//
//  FirebaseViewModel.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 8/09/22.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseViewModel: ObservableObject {
    
    @Published var loginShow: Bool = false
    @Published var data = [FirebaseModel]()
    
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
    func saveToDataBase(gameTitle: String, gameDescription: String, gamePlataform: String, gameCover: Data, completation: @escaping (_ done: Bool) -> Void) {
        
        let storage = Storage.storage().reference()
        let coverName = UUID()
        let directory = storage.child("gallery/\(coverName)")
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        directory.putData(gameCover, metadata: metaData) { data, error in
            if error == nil {
                print("successful image save")
                // Guardo texto
                let db = Firestore.firestore()
                let id = UUID().uuidString
                guard let idUser = Auth.auth().currentUser?.uid else { return }
                guard let emailUser = Auth.auth().currentUser?.email else { return }
                let fields: [String: Any] = ["gameTitle": gameTitle, "gameDescription": gameDescription, "cover": String(describing: directory), "idUser": idUser, "emailUser": emailUser]
                db.collection(gamePlataform).document(id).setData(fields) { error in
                    if let error = error?.localizedDescription {
                        print("Error when saving in firestone", error)
                    } else {
                        print("successful save")
                        completation(true)
                    }
                }
                // Termino de guadar texto
            } else {
                if let error = error?.localizedDescription {
                    print("error uploading image - storage", error)
                } else {
                    print("crash in the app")
                }
            }
        }
    }
    
    // MARK: Get Data Record
    func getData(plataform: String) {
        let db = Firestore.firestore()
        
        db.collection(plataform).addSnapshotListener { querySnapshot, error in
            if let error = error?.localizedDescription {
                print("add functionality to upload images to firebase storage", error)
            } else {
                self.data.removeAll()
                for document in querySnapshot!.documents {
                    let value = document.data()
                    let id = document.documentID
                    let gameTitle = value["gameTitle"] as? String ?? "no title"
                    let gameDescription = value["gameDescription"] as? String ?? "no title"
                    let gameCover = value["cover"] as? String ?? "no title"
                    
                    DispatchQueue.main.async {
                        let records = FirebaseModel(id: id, gameTitle: gameTitle, gameDescription: gameDescription, gameCover: gameCover)
                        self.data.append(records)
                    }
                }
            }
        }
    }
    
    // MARK: Delete Record
    func deleteRecord(indexRecord: FirebaseModel, plataform: String) {
        // delete firestore
        let id = indexRecord.id
        let db = Firestore.firestore()
        db.collection(plataform).document(id).delete()
        // delete of storage
        let imagen = indexRecord.gameCover
        let deleteImage = Storage.storage().reference(forURL: imagen)
        deleteImage.delete(completion: nil)
    }
    
    // MARK: Edit Record
    func editRecord(gameTitle: String, gameDescription: String, pltaform: String , id: String, completation: @escaping (_ done: Bool) -> Void) {
        let db = Firestore.firestore()
        let fields: [String: Any] = ["gameTitle": gameTitle, "gameDescription": gameDescription]
        db.collection(pltaform).document(id).updateData(fields) { error in
            if let error = error?.localizedDescription {
                print("Error, Failed to edit", error)
            } else {
                print("update completed - text only")
                completation(true)
            }
        }
    }
    
    // MARK: Edit Record With Image
    func editRecordWithImage(gameTitle: String, gameDescription: String, pltaform: String , id: String, indexRecord: FirebaseModel, gameCover: Data, completation: @escaping (_ done: Bool) -> Void) {
        // Delete Image
        let imagen = indexRecord.gameCover
        let deleteImage = Storage.storage().reference(forURL: imagen)
        deleteImage.delete(completion: nil)
        // Upload new image
        let storage = Storage.storage().reference()
        let coverName = UUID()
        let directory = storage.child("gallery/\(coverName)")
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        directory.putData(gameCover, metadata: metaData) { data, error in
            if error == nil {
                // Editing Text
                print("successful new image save")
                let db = Firestore.firestore()
                let fields: [String: Any] = ["gameTitle": gameTitle, "gameDescription": gameDescription, "gameCover": String(describing: directory)]
                db.collection(pltaform).document(id).updateData(fields) { error in
                    if let error = error?.localizedDescription {
                        print("Error, Failed to edit", error)
                    } else {
                        print("update completed - text only")
                        completation(true)
                    }
                }
                
            } else {
                if let error = error?.localizedDescription {
                    print("error uploading image - storage", error)
                } else {
                    print("crash in the app")
                }
            }
        }
        
        
    }
    
}
    


