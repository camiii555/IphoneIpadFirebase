//
//  AddView.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 12/10/22.
//

import SwiftUI

struct AddView: View {
    @State private var gameTitle = ""
    @State private var gameDescription = ""
    var consoles = ["playstation", "xbox", "nintendo"]
    @State private var plataform = "playstation"
    @StateObject var saveDatabase = FirebaseViewModel()
    
    @State private var imageData: Data = .init(capacity: 0)
    @State private var showMenu = false
    @State private var imagePicker = false
    @State private var source: UIImagePickerController.SourceType = .camera
    
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
                    TextEditor(text: $gameDescription)
                        .frame(height: 200)
                    Picker("consoles", selection: $plataform) {
                        ForEach(consoles, id:\.self){ item in
                            Text(item)
                                .foregroundColor(.black)
                        }
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
                        saveDatabase.saveToDataBase(gameTitle: gameTitle, gameDescription: gameDescription, gamePlataform: plataform, gameCover: "link") { done in
                            if done {
                                gameTitle = ""
                                gameDescription = ""
                            }
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }
                    Spacer()
                }.padding(.all)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
}
