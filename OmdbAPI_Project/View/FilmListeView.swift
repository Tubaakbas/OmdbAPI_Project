//
//  ContentView.swift
//  OmdbAPI_Project
//
//  Created by iOS-Lab11 on 29.08.2024.
//

import SwiftUI

struct FilmListeView: View {
    
    //FilmViewModel dosyasının içinde bulunan FilmListeViewModel sınıfının filmler adli degiskenine ulasmak icin obje olusturuldu ve gözlemlenen olduğu belirtildi
    @ObservedObject var filmListeViewModel : FilmListeViewModel
    
    @State var aranacakFilm = ""
    
    init() {
        self.filmListeViewModel = FilmListeViewModel()

    }
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("Aranacak Film", text: $aranacakFilm, onCommit: {
                    self.filmListeViewModel.filmAramasiYap(filmIsmi: aranacakFilm.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? aranacakFilm)
                }).padding().textFieldStyle(RoundedBorderTextFieldStyle())
                //liste içerisende gosterilecektir
                List(filmListeViewModel.filmler, id: \.imdbID) { film in
                    
                    // DetayView oluşturulduktan sonraki kodlar
                    NavigationLink(
                        destination: DetayView(imdbId: film.imdbID),
                        label: {
                            HStack {
                                OzelImage(url: film.poster)
                                    .frame(width: 90, height: 130)
                                VStack (alignment: .leading) {
                                    Text(film.title)
                                        .foregroundColor(.orange)
                                    Text(film.year)
                                }
                            }
                        })
  
                }.navigationTitle(Text("Film"))
            }
        }
    }
}

#Preview {
    FilmListeView()
}
