//
//  OzelImage.swift
//  OmdbAPI_Project
//
//  Created by iOS-Lab11 on 2.09.2024.
//

import SwiftUI

struct OzelImage: View {
    
    let url : String
    //indirilenGorsel adli değişkeni burada gösterebilmek için sinfin objesini yaratiyoruz
    @ObservedObject var imageDownloaderClient = ImageDownloaderClient()
    
    init (url: String){
        self.url = url
        self.imageDownloaderClient.gorselIndir(url: self.url)
    }
    var body: some View {
        //gorsel gelmedigi zaman placeholder'ı goster
        if let data = self.imageDownloaderClient.indirilenGorsel {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()

        } else  {
            return Image("progressBar")
                .resizable()

        }
    }
}

#Preview {
    OzelImage(url: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg")
}
