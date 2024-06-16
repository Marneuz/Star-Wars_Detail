
import Foundation

class StarshipsViewModel: ObservableObject {
    private let vehiclesRepository: VehiclesRepository
    
    @Published var isLoading = false
    @Published var starships: [Vehicle] = []
    @Published var error: Error?
    
    init(vehiclesRepository: VehiclesRepository) {
        self.vehiclesRepository = vehiclesRepository
    }
    
    @MainActor
    func getStarships() async {
        error = nil
        isLoading = true
        
        do {
            starships = try await vehiclesRepository.getStartships()
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }
}
