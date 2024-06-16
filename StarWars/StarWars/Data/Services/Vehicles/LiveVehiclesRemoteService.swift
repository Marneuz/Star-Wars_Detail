
import Foundation

struct LiveVehiclesRemoteService: VehiclesRemoteService {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getVehicles() async throws -> [Vehicle] {
        let response: APIResponse<Vehicle> = try await networkClient.getCall(url: NetworkConstants.vehiclesNetworkUrl, queryParams: nil)
        
        return response.results
    }
    
    func getStarships() async throws -> [Vehicle] {
        let response: APIResponse<Vehicle> = try await networkClient.getCall(url: NetworkConstants.starshipsNetworkUrl, queryParams: nil)
        
        return response.results
    }
}
