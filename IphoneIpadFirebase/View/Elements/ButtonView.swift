//
//  ButtonView.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 6/09/22.
//

import SwiftUI

struct ButtonView: View {
    @Binding var index: String
    @Binding var menu: Bool
    var title: String
    var device = UIDevice.current.userInterfaceIdiom
    var body: some View {
        Button {
            withAnimation {
                index = title
                if device == .phone {
                    menu.toggle()
                }
            }
        } label: {
            Text(title)
                .font(.title)
                .fontWeight(index == title ? .bold : .none)
                .foregroundColor(index == title ? .white : Color.white.opacity(0.6))
        }

    }
}

