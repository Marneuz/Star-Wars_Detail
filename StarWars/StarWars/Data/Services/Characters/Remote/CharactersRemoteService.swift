

import Foundation

protocol CharactersRemoteService {
    func getCharacters() async throws -> [Character]
    
    func getCharacter(url: String) async throws -> Character
}
