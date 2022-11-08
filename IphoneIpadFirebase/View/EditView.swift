//
//  EditView.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 8/11/22.
//

import SwiftUI

struct EditView: View {
    @State private var gameTitle = ""
    @State private var gameDescription = ""
    var plataform: String
    var data: FirebaseModel
    @StateObject var saveDatabase = FirebaseViewModel()
    
    @State private var imageData: Data = .init(capacity: 0)
    @State private var showMenu = false
    @State private var imagePicker = false
    @State private var source: UIImagePickerController.SourceType = .camera
    
    @State private var progress = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.yellow.edgesIgnoringSafeArea(.all)
                VStack{
                    NavigationLink("Photo", isActive: $imagePicker) {
                        ImagePicker(showPhoto: $imagePicker, image: $imageData, source: source)
                        EmptyView()
                    }.navigationBarHidden(true)
                    
                   TextField("Title", text: $gameTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear(){
                            self.gameTitle = data.gameTitle
                        }
                    TextEditor(text: $gameDescription)
                        .frame(height: 200)
                        .onAppear(){
                            self.gameDescription = data.gameDescription
                        }
                    
                    Button {
                        showMenu.toggle()
                    } label: {
                        Text("Load image")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }.confirmationDialog("Menu", isPresented: $showMenu, titleVisibility: .visible) {
                        Button("Camera") {
                            source = .camera
                            imagePicker.toggle()
                        }
                        Button("Gallery") {
                            source = .photoLibrary
                            imagePicker.toggle()
                        }
                        Button("Cancel") {
                            
                        }
                    }
                    
                    
                    if imageData.count != 0 {
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .frame(width: 250, height: 250)
                            .cornerRadius(15)
                        
                    }
                    
                    Button {
                        if imageData.isEmpty {
                            saveDatabase.editRecord(gameTitle: gameTitle, gameDescription: gameDescription, pltaform: plataform, id: data.id) { done in
                                if done {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        } else {
                            progress = true
                            saveDatabase.editRecordWithImage(gameTitle: gameTitle, gameDescription: gameDescription, pltaform: plataform, id: data.id, indexRecord: data, gameCover: imageData) { done in
                                if done {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    } label: {
                        Text("Edit")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }
                    
                    if progress {
                        Text("Wait a moment please").foregroundColor(.black)
                        ProgressView()
                    }


                    Spacer()
                }.padding(.all)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
}
