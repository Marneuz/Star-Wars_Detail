
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        TabView {
            coordinator.makeFilmsView()
                .tabItem {
                    Label("Films", systemImage: "film")
                }
            coordinator.makeCharactersView()
                .tabItem {
                    Label("Characters", systemImage: "person.3")
                }
            coordinator.makeVehiclesMainView()
                .tabItem {
                    Label("Vehicles", systemImage: "car")
                }
            coordinator.makeCharactersFavoriteView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return ContentView()
        .environmentObject(coordinator)
}
