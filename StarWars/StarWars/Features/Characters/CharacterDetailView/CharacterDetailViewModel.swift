

import Foundation

class CharacterDetailViewModel: ObservableObject {
    
    private let charactersRepository: CharactersRepository
    
    @Published var isLoading = false
    @Published var character: Character?
    @Published var error: Error?
    @Published var isFavorite = false
    
    init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
    
    @MainActor
    func getCharacter(url: String) async {
        error = nil
        isLoading = true
        
        do {
            character = try await charactersRepository.getCharacter(url: url)
        } catch (let error) {
            self.error = error
        }
        
        isLoading = false
    }
    
    @MainActor
    func addFavoriteCharacter(character: Character) async {
        error = nil
        
        do {
            try await charactersRepository.addFavoriteCharacter(character: character)
            isFavorite = true
        } catch (let error) {
            self.error = error
        }
    }
    
    @MainActor
    func removeFavoriteCharacter(character: Character) async {
        error = nil
        
        do {
            try await charactersRepository.removeFavoriteCharacter(character: character)
            isFavorite = false
        } catch (let error) {
            self.error = error
        }
    }
    
    @MainActor
    func isFavoriteCharacter(character: Character) async {
        error = nil
        
        do {
            isFavorite = try await charactersRepository.isFavoriteCharacter(character: character)
        } catch (let error) {
            self.error = error
        }
    }
    
}
