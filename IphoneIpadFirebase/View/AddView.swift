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
    
    var body: some View {
        ZStack{
            Color.yellow.edgesIgnoringSafeArea(.all)
            VStack{
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
    }
}
