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
    
    var body: some View {
        VStack(spacing: 20){
            ImageFirebase(imageUrl: cover)
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "", cover: "")
    }
}
