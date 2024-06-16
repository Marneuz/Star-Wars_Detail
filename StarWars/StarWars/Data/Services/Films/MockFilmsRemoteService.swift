

import Foundation

struct MockFilmsRemoteService: FilmsRemoteService {
    
    func getFilms() async throws -> [Film] {
        return [.example, .example, .example]
    }
}
