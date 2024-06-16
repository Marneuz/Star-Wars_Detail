
import SwiftUI

struct VehicleDetailView: View {
    
    let vehicle: Vehicle
    let vehicleType: VehicleType
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Class: \(vehicle.className ?? "N/A")")
                    .font(.headline)
                    .padding()
                
                Text("Passengers: \(vehicle.passengers)")
                
                HStack {
                    Text("Type: ")
                    Image(systemName: getTypeImage())
                }
            }
        }.navigationTitle(vehicle.model)
    }
    
    func getTypeImage() -> String {
        switch vehicleType {
        case .vehicle:
            "car"
        case .starship:
            "airplane"
        }
    }
}

#Preview {
    VehicleDetailView(vehicle: .example, vehicleType: .vehicle)
}
