
import Foundation

struct LiveFilmsRemoteService: FilmsRemoteService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getFilms() async throws -> [Film] {
        let response: APIResponse<Film> = try await networkClient.getCall(url: NetworkConstants.filmsNetworkUrl, queryParams: nil)
        
        return response.results
    }
}
