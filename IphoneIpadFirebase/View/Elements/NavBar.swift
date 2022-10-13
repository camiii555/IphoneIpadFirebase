//
//  NavBar.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 6/09/22.
//

import SwiftUI
import Firebase

struct NavBar: View {
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index: String
    @Binding var menu: Bool
    @EnvironmentObject var loginShow: FirebaseViewModel
    var body: some View {
        HStack{
            Text("My Games")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: device == .phone ? 25 : 35))
            Spacer()
            if device == .pad {
                // Menu for iPad
                HStack(spacing: 25){
                    ButtonView(index: $index, menu: $menu, title: "Playstation")
                    ButtonView(index: $index, menu: $menu, title: "Xbox")
                    ButtonView(index: $index, menu: $menu, title: "Nintendo")
                    ButtonView(index: $index, menu: $menu, title: "Add")
                    Button {
                        // signOut Firebase session
                        try! Auth.auth().signOut()
                        UserDefaults.standard.removeObject(forKey: "logIn")
                        loginShow.loginShow = false
                    } label: {
                        Text("Exit")
                            .font(.title)
                            .frame(width: 100)
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                            .background {
                                Capsule()
                                    .stroke(Color.white)
                            }
                    }

                }
            } else {
                Button {
                    withAnimation {
                        menu.toggle()
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }

            }
        }
        .padding(.top, 30)
        .padding()
        .background(Color.purple)
    }
}
