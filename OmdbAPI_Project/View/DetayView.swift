//
//  DetayView.swift
//  OmdbAPI_Project
//
//  Created by iOS-Lab11 on 4.09.2024.
//

import SwiftUI

struct DetayView: View {
    //FilmListeView tarafinda kullanilacak imdbId
    let imdbId : String
    //view acildiginda calisacak
    @ObservedObject var filmDetayViewModel = FilmDetayViewModel()
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                OzelImage(url: filmDetayViewModel.filmDetayi?.poster ?? "")
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.3)
                Spacer()
            }

            
            Text(filmDetayViewModel.filmDetayi?.title ?? "Film Adi")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.green)
                .padding()
            
            Text("Yıl:  \(filmDetayViewModel.filmDetayi?.year ?? "Yıl")")
                .padding()
                .foregroundColor(.green)
            
            Text(filmDetayViewModel.filmDetayi?.plot ?? "Film Özeti").padding([.leading, .trailing])
                .foregroundColor(.brown)

            Text("Yönetmen:  \(filmDetayViewModel.filmDetayi?.director ?? "Yönetmen")")
                .padding()
                .foregroundColor(.blue)
                
            Text("Yazarlar:  \(filmDetayViewModel.filmDetayi?.writer ?? "Yazarlar")")
                .padding()
                .foregroundColor(.blue)

        }.onAppear(perform: {
            self.filmDetayViewModel
                .filmDetayiAl(imdbId: imdbId)
        })
    }
}

#Preview {
    DetayView(imdbId: "test")
}
