//
//  FilmDetayViewModel.swift
//  OmdbAPI_Project
//
//  Created by iOS-Lab11 on 4.09.2024.
//

import Foundation

class FilmDetayViewModel : ObservableObject {
    // burasi normalde FilmDetay? idi sonrasinda structta yazılan detaylar alindi
    @Published var filmDetayi : FilmDetaylariViewModel?
    
    // filmDetaylariniIndir fonksiyonuna erişme
    let downloaderClient = DownloaderClient()
    
    func filmDetayiAl(imdbId : String){
        downloaderClient.filmDetayiniIndir(imdbId: imdbId) { (sonuc) in
            switch sonuc {
            case.failure(let hata):
                print(hata)
            case .success(let filmDetay):
                DispatchQueue.main.async {
                    self.filmDetayi = FilmDetaylariViewModel(detay: filmDetay)
                }
            }
        }
    }
}

struct FilmDetaylariViewModel {
    let detay : FilmDetay
    
    var title : String {
        detay.title
    }
    
    var poster : String {
        detay.poster
    }
    
    var year : String {
        detay.year
    }
    
    var imdbId : String {
        detay.imdbId
    }
    
    var director : String {
        detay.director
    }
    
    var writer : String {
        detay.writer
    }
    
    var awards : String {
        detay.awards
    }
    
    var plot : String {
        detay.plot
    }
}
