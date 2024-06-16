

import SwiftUI

struct VehiclesView: View {
    
    @StateObject private var viewModel: VehiclesViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    init(viewModel: VehiclesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.vehicles, id: \.url) { vehicle in
                    NavigationLink {
                        coordinator.makeVehicleDetailView(vehicle: vehicle, vehicleType: .vehicle)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(vehicle.model)
                                .font(.headline)
                            Text(vehicle.name)
                                .font(.body)
                        }
                    }
                }
            }
        }.task {
            await viewModel.getVehicles()
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getVehicles()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }

    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    
    return coordinator.makeVehiclesView()
        .environmentObject(coordinator)
}
