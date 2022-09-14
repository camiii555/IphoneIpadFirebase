//
//  Login.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 9/09/22.
//

import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow: FirebaseViewModel
    var device = UIDevice.current.userInterfaceIdiom
    var body: some View {
        ZStack {
            Color.purple.edgesIgnoringSafeArea(.all)
            VStack{
                Text("My Games")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .frame(width: device == .pad ? 400: nil)
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: device == .pad ? 400: nil)
                    .padding(.bottom, 20)
                
                Button {
                    login.Login(email: email, password: password) { done in
                        if done {
                            UserDefaults.standard.set(true, forKey: "logIn")
                            loginShow.loginShow.toggle()
                        }
                    }
                } label: {
                    Text("Log in")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 200)
                        .padding(.vertical, 10)
                        
                }.background(
                    Capsule()
                        .stroke(Color.white)
                )
                
            }.padding(.all)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
