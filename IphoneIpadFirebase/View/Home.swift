//
//  Home.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 6/09/22.
//

import SwiftUI
import Firebase

struct Home: View {
    @State private var index = "Playstation"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    @EnvironmentObject var loginShow: FirebaseViewModel
    
    func getColumns() -> Int {
        return (device == .pad) ? 3 : ((device == .phone && width == .regular ? 3 : 1))
    }
    
    var body: some View {
        ZStack{
            VStack{
                NavBar(index: $index, menu: $menu)
                ZStack{
                    if index == "Playstation" {
                        ListView(plataform: "playstation")
                    } else if index == "Xbox" {
                        ListView(plataform: "xbox")
                    } else if index == "Nintendo" {
                        ListView(plataform: "nintendo")
                    } else {
                        AddView()
                    }
                }
            }
            // Ends design for the ipad
            
            if menu {
                HStack{
                   Spacer()
                    VStack{
                        HStack{
                            Spacer()
                            Button {
                                withAnimation {
                                    menu.toggle()
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            }

                        }.padding()
                            .padding(.top, 50)
                        VStack(alignment: .trailing){
                            ButtonView(index: $index, menu: $menu, title: "Playstation")
                            ButtonView(index: $index, menu: $menu, title: "Xbox")
                            ButtonView(index: $index, menu: $menu, title: "Nintendo")
                            Button {
                                try! Auth.auth().signOut()
                                UserDefaults.standard.removeObject(forKey: "logIn")
                                loginShow.loginShow = false
                            } label: {
                                Text("Salir")
                                    .foregroundColor(.white)
                                    .bold()
                            }

                        }
                        Spacer()
                    }
                    .frame(width: widthMenu - 200)
                    .background(Color.purple)
                }
            }
        }
        .background(Color("fontColor"))
    }
}
