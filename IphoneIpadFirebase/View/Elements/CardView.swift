//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 6/09/22.
//

import SwiftUI

struct CardView: View {
    
    var title: String
    var cover: String
    
    var index: FirebaseModel
    var plataform: String
    @StateObject var firebaseViewModel = FirebaseViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            ImageFirebase(imageUrl: cover)
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.black)
            Button {
                firebaseViewModel.deleteRecord(indexRecord: index, plataform: plataform)
            } label: {
                Text("Delete")
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .background(Capsule().stroke(Color.red))
            }

        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}
