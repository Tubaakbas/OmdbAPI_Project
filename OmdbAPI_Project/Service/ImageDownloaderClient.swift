//
//  ImageDownloaderClient.swift
//  OmdbAPI_Project
//
//  Created by iOS-Lab11 on 2.09.2024.
//

import Foundation

class ImageDownloaderClient : ObservableObject {
    
    //indirilen gorselin view tarafinda gorutulenmesi icin sinif ObservableObject yapildi
    @Published var indirilenGorsel : Data?
    
    //gorsel indirme fonksiyon
    //hangi url'den gorselin gelecegi belli
    func gorselIndir(url : String){
        //burasi calistiginda url düzgün alindi
        guard let imageUrl = URL(string: url) else
        {
            return
        }
        
        //URLSession cagrildiginda veri indirilenGorsel icerisine kaydedilecektir
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            // eger burasi calisiyorsa data geldi demektir
            guard let data = data, error == nil else {
                return
            }
            // gelen veriyi indirilenGorsel adli degiskene atama
            DispatchQueue.main.async{
                self.indirilenGorsel = data
            }
        }.resume()
    }
    
}

