//
//  ContentView.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 6/09/22.
//

import SwiftUI
 
struct ContentView: View {
    @EnvironmentObject var loginshow: FirebaseViewModel
    var body: some View {
        return Group{
            if loginshow.loginShow {
                Home()
                    .edgesIgnoringSafeArea(.all)
                    .preferredColorScheme(.dark)
            } else {
                Login()
                    .preferredColorScheme(.light)
            }
        }.onAppear {
            if (UserDefaults.standard.object(forKey: "logIn")) != nil {
                loginshow.loginShow = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
