//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 6/09/22.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack(spacing: 20){
            Image("CoverWitchQueen")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Destiny 2")
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
        CardView()
    }
}
