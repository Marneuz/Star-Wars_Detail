

import SwiftUI

struct CharactersView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: CharactersViewModel
    
    init(viewModel: CharactersViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.characters, id: \.url) { character in
                    NavigationLink {
                        coordinator.makeCharacterDetailView(characterUrl: character.url)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.headline)
                            
                            Text(character.birthYear)
                        }
                    }
                }
            }
        }.task {
            await viewModel.getCharacters()
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getCharacters()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }

    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    
    return coordinator.makeCharactersView()
        .environmentObject(coordinator)
}
