//
//  FilmViewModel.swift
//  OmdbAPI_Project
//
//  Created by iOS-Lab11 on 1.09.2024.
//

import Foundation
import SwiftUI

//MVVM yapısından dolayı DownloaderClient burada uygulanacaktır.

//bu sinif sayesinde filmler FilmViewModel dizisini verecektir
class FilmListeViewModel : ObservableObject {
    // Gozlemlenen degiskenin basina @Published eklenir
    //oluşturulan struct'ın dizisi verildi
    @Published var filmler = [FilmViewModel]()
    // nesne olusturuldu
    let downloaderClient = DownloaderClient()
    
    func filmAramasiYap(filmIsmi : String) {
        
        downloaderClient.filmleriIndir(search: filmIsmi) { (sonuc) in
            switch sonuc {
                case.failure(let hata):
                print(hata)
                case.success(let filmDizisi):
                // if let filmDizisi yazildi opsiyonel olmaktan cikarildi
                if let filmDizisi = filmDizisi {
                    //Asenkron calisma
                    DispatchQueue.main.async {
                        self.filmler = filmDizisi.map(FilmViewModel.init)
                    }

                }
            }
        }
    }
}

struct FilmViewModel {
    // Model dosyası içinde bulunan Film dosyası
    let  film : Film
    // istenilen değişkenler
    var title : String {
        film.title
    }
    var poster : String {
        film.poster
    }
    var year : String {
        film.year
    }
    var imdbID : String {
        film.imdbID
    }
}
