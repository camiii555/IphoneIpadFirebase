//
//  ImageFirebase.swift
//  IphoneIpadFirebase
//
//  Created by MacBook J&J  on 20/10/22.
//

import SwiftUI

struct ImageFirebase: View {
    let alternativeImage = UIImage(systemName: "photo")
    @ObservedObject var imageLoader: CoverViewModel
    init(imageUrl: String) {
        imageLoader = CoverViewModel(imageUrl: imageUrl)
    }
    
    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: image ?? alternativeImage!)
            .resizable()
            .cornerRadius(20)
            .shadow(radius: 5)
            .aspectRatio(contentMode: .fit)
    }
}

struct ImageFirebase_Previews: PreviewProvider {
    static var previews: some View {
        ImageFirebase(imageUrl: "")
    }
}
