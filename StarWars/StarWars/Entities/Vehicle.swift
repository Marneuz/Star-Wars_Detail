
import Foundation

struct Vehicle: Decodable {
    let name, model, manufacturer, costInCredits: String
    let length, maxAtmospheringSpeed, crew, passengers: String
    let cargoCapacity, consumables: String
    let hyperdriveRating, mglt, vehicleClass, starshipClass: String?
    let pilots, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew, passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        case mglt = "MGLT"
        case vehicleClass = "vehicle_class"
        case starshipClass = "starship_class"
        case pilots, films, created, edited, url
    }
    
    static var example: Vehicle {
        return Vehicle(name: "Chevrolet", model: "Corvette", manufacturer: "Chevrolet", costInCredits: "", length: "", maxAtmospheringSpeed: "", crew: "", passengers: "", cargoCapacity: "", consumables: "", hyperdriveRating: "", mglt: "", vehicleClass: "Class", starshipClass: "Class", pilots: [], films: [], created: "", edited: "", url: "")
    }
    
    var className: String? {
        return self.vehicleClass ?? self.starshipClass
    }
}

enum VehicleType {
    case vehicle
    case starship
}
