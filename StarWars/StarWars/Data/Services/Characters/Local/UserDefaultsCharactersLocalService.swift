

import Foundation

struct UserDefaultsCharactersLocalService: CharactersLocalService {
    
    private let favoriteCharactersKey = "favorite_characters"
    
    func getFavoriteCharacters() async throws -> [Character] {
        guard let data = UserDefaults.standard.data(forKey: favoriteCharactersKey) else {
            return []
        }
        
        return try JSONDecoder().decode([Character].self, from: data)
    }
    
    func addFavoriteCharacter(character: Character) async throws {
        var characters = try await getFavoriteCharacters()
        characters.append(character)
        try await saveFavoriteCharacters(characters: characters)
    }
    
    func removeFavoriteCharacter(character: Character) async throws {
        var characters = try await getFavoriteCharacters()
        characters.removeAll { ch in
            ch.url == character.url
        }
        try await saveFavoriteCharacters(characters: characters)
    }
    
    func isFavoriteCharacter(character: Character) async throws -> Bool {
        let characters = try await getFavoriteCharacters()
        
        return characters.contains { ch in
            ch.url == character.url
        }
    }
    
    private func saveFavoriteCharacters(characters: [Character]) async throws {
        let data = try JSONEncoder().encode(characters)
        UserDefaults.standard.set(data, forKey: favoriteCharactersKey)
    }
}
