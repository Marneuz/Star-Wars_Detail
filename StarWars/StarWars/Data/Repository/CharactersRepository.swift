

import Foundation

struct CharactersRepository {
    let remoteService: CharactersRemoteService
    let localService: CharactersLocalService
    
    init(remoteService: CharactersRemoteService, localService: CharactersLocalService) {
        self.remoteService = remoteService
        self.localService = localService
    }
    
    func getCharacters() async throws -> [Character] {
        return try await remoteService.getCharacters()
    }
    
    func getCharacter(url: String) async throws -> Character {
        return try await remoteService.getCharacter(url: url)
    }
    
    func getFavoriteCharacters() async throws -> [Character] {
        return try await localService.getFavoriteCharacters()
    }
    
    func addFavoriteCharacter(character: Character) async throws {
        try await localService.addFavoriteCharacter(character: character)
    }
    
    func removeFavoriteCharacter(character: Character) async throws {
        try await localService.removeFavoriteCharacter(character: character)
    }
    
    func isFavoriteCharacter(character: Character) async throws -> Bool {
        return try await localService.isFavoriteCharacter(character: character)
    }
}
