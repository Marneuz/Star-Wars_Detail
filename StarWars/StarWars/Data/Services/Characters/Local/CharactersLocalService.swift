
import Foundation

protocol CharactersLocalService {
    func getFavoriteCharacters() async throws -> [Character]
    
    func addFavoriteCharacter(character: Character) async throws
    
    func removeFavoriteCharacter(character: Character) async throws
    
    func isFavoriteCharacter(character: Character) async throws -> Bool
}
