
import Foundation

struct MockCharactersRemoteService: CharactersRemoteService {
    
    func getCharacters() async throws -> [Character] {
        return [.example, .example, .example]
    }
    
    func getCharacter(url: String) async throws -> Character {
        return .example
    }
    
}
