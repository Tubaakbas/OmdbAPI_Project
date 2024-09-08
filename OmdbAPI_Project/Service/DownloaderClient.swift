//
//  DownloaderClient.swift
//  OmdbAPI_Project
//
//  Created by iOS-Lab11 on 29.08.2024.
//

import Foundation


class DownloaderClient {
    //Bu fonksiyon birden fazla film indirilebiliyor
    func filmleriIndir(search : String, completion: @escaping(Result<[Film]?, DownloaderError>) -> Void)
    {
        //url oluşturma
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=6da69fbd")
        else {
            return completion(.failure(.yanlisUrl))
        }
        //url'yi kullanma
        //3 parametre kullanılır: veri, cevap, hata
        URLSession.shared.dataTask(with: url) { data, response, error in
            //veri veya hata mesajının boş olması
            guard let data = data, error == nil else {
                return completion(.failure(.veriGelmedi))
            } 
            //gelen veri Json decoder ile decoder ediliyor
            guard let filmCevabi = try? JSONDecoder().decode(GelenFilmler.self, from: data) else {
                return completion(.failure(.veriIslenmedi))
            }
            
            completion(.success(filmCevabi.filmler))
        }.resume() //işlemlerin başlatılması 
        
        
    }
    
    // bu fonksiyon imdbID'yi referans alarak tek film indiriyor
    func filmDetayiniIndir(imdbId : String, completion: @escaping (Result<FilmDetay, DownloaderError>)-> Void){
        
        guard let url = URL(string: "https://www.omdbapi.com/?i=\(imdbId)&apikey=6da69fbd") else {
            return completion(.failure(.yanlisUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, request, error in
            guard let data = data, error == nil else {
                return completion(.failure(.veriGelmedi))
            }
            
            guard let gelenFilmDetayi = try? JSONDecoder().decode(FilmDetay.self, from: data) else {
                return completion(.failure(.veriIslenmedi))
            }
            
            completion(.success(gelenFilmDetayi))
        }.resume()
    }
}


enum DownloaderError: Error {
    case yanlisUrl
    case veriGelmedi
    case veriIslenmedi
}
    
