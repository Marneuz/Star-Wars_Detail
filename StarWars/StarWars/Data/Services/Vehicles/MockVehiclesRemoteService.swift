
import Foundation

struct MockVehiclesRemoteService: VehiclesRemoteService {
    
    func getVehicles() async throws -> [Vehicle] {
        return [.example, .example, .example]
    }
    
    func getStarships() async throws -> [Vehicle] {
        return [.example, .example, .example]
    }
    
}
