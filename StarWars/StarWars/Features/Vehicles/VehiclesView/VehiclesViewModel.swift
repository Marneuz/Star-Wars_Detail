

import Foundation

class VehiclesViewModel: ObservableObject {
    private let vehiclesRepository: VehiclesRepository
    
    @Published var isLoading = false
    @Published var vehicles: [Vehicle] = []
    @Published var error: Error?
    
    init(vehiclesRepository: VehiclesRepository) {
        self.vehiclesRepository = vehiclesRepository
    }
    
    @MainActor
    func getVehicles() async {
        error = nil
        isLoading = true
        
        do {
            vehicles = try await vehiclesRepository.getVehicles()
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }
}
