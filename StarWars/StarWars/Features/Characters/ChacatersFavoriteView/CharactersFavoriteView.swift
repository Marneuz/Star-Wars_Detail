
import SwiftUI

struct CharactersFavoriteView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: CharactersFavoriteViewModel
    @State private var shouldReload = false
    
    init(viewModel: CharactersFavoriteViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else if !viewModel.favoriteCharacters.isEmpty {
                List(viewModel.favoriteCharacters, id: \.url) { character in
                    NavigationLink {
                        coordinator.makeCharacterDetailView(characterUrl: character.url, popHandler: {
                            Task {
                                await viewModel.getFavoriteCharacters()
                            }
                        })
                    } label: {
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.headline)
                            
                            Text(character.birthYear)
                        }
                    }
                }
            } else {
                Text("You do not have any favorite items yet!")
            }
        }.task {
            await viewModel.getFavoriteCharacters()
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getFavoriteCharacters()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }

    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeCharactersFavoriteView()
        .environmentObject(coordinator)
}
