

import Foundation

protocol VehiclesRemoteService {
    func getVehicles() async throws -> [Vehicle]
    func getStarships() async throws -> [Vehicle]
}
