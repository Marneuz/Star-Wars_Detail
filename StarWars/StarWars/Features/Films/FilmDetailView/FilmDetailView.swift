

import SwiftUI

struct FilmDetailView: View {
    @EnvironmentObject var coordinator: Coordinator
    let film: Film
    
    var body: some View {
        ScrollView {
            VStack {
                Text(film.openingCrawl)
                    .font(.body)
                    .padding()
                Text(film.director)
                    .font(.headline)
                
                LazyVStack {
                    ForEach(film.characters, id: \.description) { character in
                        NavigationLink {
                            coordinator.makeCharacterDetailView(characterUrl: character)
                        } label: {
                            Text(character)
                        }
                    }
                }.padding()
                
                LazyVStack {
                    ForEach(film.planets, id: \.description) { planet in
                        Button(planet) {
                            if let url = URL(string: planet) {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                }
            }
        }.navigationTitle(film.title)
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeFilmDetailView(film: .example)
        .environmentObject(coordinator)
}
