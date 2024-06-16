

import Foundation

class FilmsViewModel: ObservableObject {
    
    private let filmsRepository: FilmsRepository
    @Published var films: [Film] = []
    @Published var error: Error?
    
    @Published var isLoading = false
    
    init(filmsRepository: FilmsRepository) {
        self.filmsRepository = filmsRepository
    }
    
    @MainActor
    func getFilms() async {
        error = nil
        isLoading = true
        
        do {
            films = try await filmsRepository.getFilms()
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }
    
}
