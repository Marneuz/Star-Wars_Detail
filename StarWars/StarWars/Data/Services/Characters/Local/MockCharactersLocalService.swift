

import Foundation

struct MockCharactersLocalService: CharactersLocalService {
    
    func getFavoriteCharacters() async throws -> [Character] {
        return [.example, .example]
    }
    
    func addFavoriteCharacter(character: Character) async throws {
        print("Added to favorites")
    }
    
    func removeFavoriteCharacter(character: Character) async throws {
        print("Removed from favorites")
    }
    
    func isFavoriteCharacter(character: Character) async throws -> Bool {
        return true
    }
    
}
