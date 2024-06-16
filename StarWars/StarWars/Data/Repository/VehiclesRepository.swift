
import Foundation

struct VehiclesRepository {
    let remoteService: VehiclesRemoteService
    
    init(remoteService: VehiclesRemoteService) {
        self.remoteService = remoteService
    }
    
    func getVehicles() async throws -> [Vehicle] {
        return try await remoteService.getVehicles()
    }
    
    func getStartships() async throws -> [Vehicle] {
        return try await remoteService.getStarships()
    }
}
