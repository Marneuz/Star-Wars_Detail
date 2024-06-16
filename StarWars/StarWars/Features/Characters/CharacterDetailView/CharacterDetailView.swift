
import SwiftUI

struct CharacterDetailView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: CharacterDetailViewModel
    
    let characterUrl: String
    let popHandler: (() -> Void)?
    
    init(viewModel: CharacterDetailViewModel, characterUrl: String, popHandler: (() -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.characterUrl = characterUrl
        self.popHandler = popHandler
    }
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else if let character = viewModel.character {
                VStack {
                    Text("Gender: \(character.gender.rawValue)")
                    
                    Text("Birth year: \(character.birthYear)")
                        .padding()
                    
                    Button("View homeworld") {
                        if let url = URL(string: character.homeworld) {
                            UIApplication.shared.open(url)
                        }
                    }
                }.navigationTitle(character.name)
                    .toolbar {
                        Button("Favorite", systemImage: viewModel.isFavorite ? "star.fill" : "star") {
                            Task {
                                await toggleFavoriteCharacter(character: character)
                                
                                popHandler?()
                            }
                        }
                    }.task {
                        await viewModel.isFavoriteCharacter(character: character)
                    }
            }
        }.task {
            await viewModel.getCharacter(url: characterUrl)
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getCharacter(url: characterUrl)
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }
    }
    
    private func toggleFavoriteCharacter(character: Character) async {
        if viewModel.isFavorite {
            await viewModel.removeFavoriteCharacter(character: character)
        } else {
            await viewModel.addFavoriteCharacter(character: character)
        }
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeCharacterDetailView(characterUrl: "")
        .environmentObject(coordinator)
}
