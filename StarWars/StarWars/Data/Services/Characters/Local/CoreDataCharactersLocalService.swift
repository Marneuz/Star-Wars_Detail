

import Foundation
import CoreData

struct CoreDataCharactersLocalService: CharactersLocalService {
    
    let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func getFavoriteCharacters() async throws -> [Character] {
        let fetchRequest = CDCharacters.fetchRequest()
        let cdCharacters = try container.viewContext.fetch(fetchRequest)
        
        let characters = cdCharacters.map { cdCharacter in
            return Character(name: cdCharacter.name ?? "", height: cdCharacter.height ?? "", mass: cdCharacter.mass ?? "", hairColor: cdCharacter.hairColor ?? "", skinColor: cdCharacter.skinColor ?? "", eyeColor: cdCharacter.eyeColor ?? "", birthYear: cdCharacter.birthYear ?? "", gender: Gender(rawValue: cdCharacter.gender ?? "") ?? .nA, homeworld: cdCharacter.homeworld ?? "", films: cdCharacter.films ?? [], species: cdCharacter.species ?? [], vehicles:  cdCharacter.vehicles ?? [], starships: cdCharacter.starships ?? [], created: cdCharacter.created ?? "", edited: cdCharacter.edited ?? "", url: cdCharacter.url ?? "")
        }
        
        return characters
    }
    
    func addFavoriteCharacter(character: Character) async throws {
        let cdCharacter = CDCharacters(context: container.viewContext)
        cdCharacter.name = character.name
        cdCharacter.height = character.height
        cdCharacter.mass = character.mass
        cdCharacter.hairColor = character.hairColor
        cdCharacter.skinColor = character.skinColor
        cdCharacter.eyeColor = character.eyeColor
        cdCharacter.birthYear = character.birthYear
        cdCharacter.gender = character.gender.rawValue
        cdCharacter.homeworld = character.homeworld
        cdCharacter.films = character.films
        cdCharacter.species = character.species
        cdCharacter.vehicles = character.vehicles
        cdCharacter.starships = character.starships
        cdCharacter.created = character.created
        cdCharacter.edited = character.edited
        cdCharacter.url = character.url
        
        try container.viewContext.save()
    }
    
    func removeFavoriteCharacter(character: Character) async throws {
        let fetchRequest = CDCharacters.fetchRequest()
        let cdCharacters = try container.viewContext.fetch(fetchRequest)
        
        guard let cdCharacter = (cdCharacters.first { ch in
            ch.url == character.url
        }) else {
            return
        }
        
        container.viewContext.delete(cdCharacter)
        
        try container.viewContext.save()
    }
    
    func isFavoriteCharacter(character: Character) async throws -> Bool {
        let characters = try await getFavoriteCharacters()
        
        return characters.contains { ch in
            ch.url == character.url
        }
    }
    
    
}
