
import Foundation

class Coordinator: ObservableObject {
    private let filmsRepository: FilmsRepository
    private let vehiclesRepository: VehiclesRepository
    private let charactersRepository: CharactersRepository
    
    init(mock: Bool = false) {
        let networkClient = URLSessionNetworkClient()
        
        // MARK: Films
        let filmsRemoteService: FilmsRemoteService = mock ? MockFilmsRemoteService() : LiveFilmsRemoteService(networkClient: networkClient)
        
        self.filmsRepository = FilmsRepository(remoteService: filmsRemoteService)
        
        // MARK: Vehicles
        let vehiclesRemoteService: VehiclesRemoteService = mock ? MockVehiclesRemoteService() : LiveVehiclesRemoteService(networkClient: networkClient)
        
        self.vehiclesRepository = VehiclesRepository(remoteService: vehiclesRemoteService)
        
        // MARK: Characters
        let charactersRemoteService: CharactersRemoteService = mock ? MockCharactersRemoteService() : LiveCharactersRemoteService(networkClient: networkClient)
        
        let persistentController = CoreDataPersistentController()
        
        let charactersLocalService: CharactersLocalService = mock ? MockCharactersLocalService() : CoreDataCharactersLocalService(container: persistentController.container)
        
        self.charactersRepository = CharactersRepository(remoteService: charactersRemoteService, localService: charactersLocalService)
    }
    
    // MARK: Film views
    func makeFilmsView() -> FilmsView {
        return FilmsView(viewModel: makeFilmsViewModel())
    }
    
    func makeFilmDetailView(film: Film) -> FilmDetailView {
        return FilmDetailView(film: film)
    }
    
    // MARK: Vehicle views
    func makeVehiclesMainView() -> VehiclesMainView {
        return VehiclesMainView()
    }
    
    func makeVehiclesView() -> VehiclesView {
        return VehiclesView(viewModel: makeVehiclesViewModel())
    }
    
    func makeStarshipsView() -> StarshipsView {
        return StarshipsView(viewModel: makeStarshipsViewModel())
    }
    
    func makeVehicleDetailView(vehicle: Vehicle, vehicleType: VehicleType) -> VehicleDetailView {
        return VehicleDetailView(vehicle: vehicle, vehicleType: vehicleType)
    }
    
    // MARK: Character view
    func makeCharactersView() -> CharactersView {
        return CharactersView(viewModel: makeCharactersViewModel())
    }
    
    func makeCharacterDetailView(characterUrl: String, popHandler: (() -> Void)? = nil) -> CharacterDetailView {
        return CharacterDetailView(viewModel: makeCharacterDetailViewModel(), characterUrl: characterUrl, popHandler: popHandler)
    }
    
    func makeCharactersFavoriteView() -> CharactersFavoriteView {
        return CharactersFavoriteView(viewModel: makeCharactersFavoriteViewModel())
    }
    
    // MARK: Viewmodels
    private func makeFilmsViewModel() -> FilmsViewModel {
        return FilmsViewModel(filmsRepository: filmsRepository)
    }
    
    private func makeVehiclesViewModel() -> VehiclesViewModel {
        return VehiclesViewModel(vehiclesRepository: vehiclesRepository)
    }
    
    private func makeStarshipsViewModel() -> StarshipsViewModel {
        return StarshipsViewModel(vehiclesRepository: vehiclesRepository)
    }
    
    private func makeCharactersViewModel() -> CharactersViewModel {
        return CharactersViewModel(charactersRepository: charactersRepository)
    }
    
    private func makeCharacterDetailViewModel() -> CharacterDetailViewModel {
        return CharacterDetailViewModel(charactersRepository: charactersRepository)
    }
    
    private func makeCharactersFavoriteViewModel() -> CharactersFavoriteViewModel {
        return CharactersFavoriteViewModel(charactersRepository: charactersRepository)
    }
}
