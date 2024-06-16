

import Foundation

class CharactersFavoriteViewModel: ObservableObject {
    
    let charactersRepository: CharactersRepository
    
    @Published var isLoading = false
    @Published var favoriteCharacters: [Character] = []
    @Published var error: Error?
    
    init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
    
    @MainActor
    func getFavoriteCharacters() async {
        error = nil
        isLoading = true
        
        do {
            favoriteCharacters = try await charactersRepository.getFavoriteCharacters()
        } catch (let error) {
            self.error = error
        }
        
        isLoading = false
    }
    
}
