
import SwiftUI

struct StarshipsView: View {
    @StateObject private var viewModel: StarshipsViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    init(viewModel: StarshipsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.starships, id: \.url) { vehicle in
                    NavigationLink {
                        coordinator.makeVehicleDetailView(vehicle: vehicle, vehicleType: .starship)
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
            await viewModel.getStarships()
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getStarships()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }

    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    
    return coordinator.makeStarshipsView()
        .environmentObject(coordinator)
}
