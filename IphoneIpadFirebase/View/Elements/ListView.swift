//
//  ListView.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 20/10/22.
//

import SwiftUI

struct ListView: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    func getColumns() -> Int {
        return (device == .pad) ? 3 : ((device == .phone && width == .regular ? 3 : 1))
    }
    
    var plataform: String
    @StateObject var firebaseViewModel = FirebaseViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 20) {
                ForEach(firebaseViewModel.data){ item in
                    CardView(title: item.gameTitle, cover: item.gameCover)
                        .padding(.all)
                }
            }
        }.onAppear{
            firebaseViewModel.getData(plataform: plataform)
            print(firebaseViewModel.data)
        }
    }
}

