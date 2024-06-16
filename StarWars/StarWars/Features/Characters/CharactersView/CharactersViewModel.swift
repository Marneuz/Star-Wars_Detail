

import Foundation

class CharactersViewModel: ObservableObject {
    
    private let charactersRepository: CharactersRepository
    
    @Published var isLoading = false
    @Published var characters: [Character] = []
    @Published var error: Error?
    
    init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
    
    @MainActor
    func getCharacters() async {
        error = nil
        isLoading = true
        
        do {
            characters = try await charactersRepository.getCharacters()
        } catch(let error) {
            self.error = error
        }
        
        isLoading = false
    }
    
}
