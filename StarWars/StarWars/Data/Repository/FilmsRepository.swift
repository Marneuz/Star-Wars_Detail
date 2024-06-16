
import Foundation

struct FilmsRepository {
    private let remoteService: FilmsRemoteService
    
    init(remoteService: FilmsRemoteService) {
        self.remoteService = remoteService
    }
    
    func getFilms() async throws -> [Film] {
        return try await remoteService.getFilms()
    }
}
