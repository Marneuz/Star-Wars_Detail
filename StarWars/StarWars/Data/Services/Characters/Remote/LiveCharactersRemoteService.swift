
import Foundation

struct LiveCharactersRemoteService: CharactersRemoteService {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCharacters() async throws -> [Character] {
        let response: APIResponse<Character> = try await networkClient.getCall(url: NetworkConstants.peopleNetworkUrl, queryParams: nil)
        
        return response.results
    }
    
    func getCharacter(url: String) async throws -> Character {
        let response: Character = try await networkClient.getCall(url: url, queryParams: nil)
        
        return response
    }
    
}
