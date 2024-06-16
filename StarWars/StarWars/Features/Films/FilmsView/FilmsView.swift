

import SwiftUI

struct FilmsView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: FilmsViewModel
    
    init(viewModel: FilmsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.films, id: \.episodeID) { film in
                    NavigationLink {
                        coordinator.makeFilmDetailView(film: film)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(film.title)
                                .font(.headline)
                            Text(film.releaseDate)
                                .font(.body)
                        }.frame(
                            maxWidth: .infinity,
                            alignment: .topLeading
                        )
                    }

                }.refreshable {
                    print("Refresh action")
                    Task {
                        await viewModel.getFilms()
                    }
                }
            }
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getFilms()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }.task {
            await viewModel.getFilms()
        }

    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeFilmsView()
}
