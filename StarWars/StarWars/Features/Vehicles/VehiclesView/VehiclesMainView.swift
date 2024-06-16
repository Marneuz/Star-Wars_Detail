
import SwiftUI

struct VehiclesMainView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    @State var selectedVehicleType = 0
    
    var body: some View {
        VStack {
            Picker("Select a vehicle list", selection: $selectedVehicleType) {
                Text("Vehicles").tag(0)
                Text("Starships").tag(1)
            }
            .pickerStyle(.segmented)
            
            switch selectedVehicleType {
            case 0:
                coordinator.makeVehiclesView()
            case 1:
                coordinator.makeStarshipsView()
            default:
                EmptyView()
            }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeVehiclesMainView()
        .environmentObject(coordinator)
}
