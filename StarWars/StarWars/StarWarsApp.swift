
import SwiftUI

@main
struct StarWarsApp: App {
    
    let coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coordinator)
        }
    }
}
