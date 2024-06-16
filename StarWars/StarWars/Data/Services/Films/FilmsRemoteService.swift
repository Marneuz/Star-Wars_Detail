
import Foundation

protocol FilmsRemoteService {
    func getFilms() async throws -> [Film]
}
