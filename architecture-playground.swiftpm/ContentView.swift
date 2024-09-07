import SwiftUI
import Combine

struct ContentView: View {
    
    var body: some View {
        TabbedContentView()
    }
}

struct TabbedContentView: View {
    var body: some View {
        TabView {
            SwiftUIContentView(viewModel: ViewModel(dataService: MockDataService()))
                .tabItem {
                    Label("SwiftUI", systemImage: "swift")
                }
            
            UIKitViewControllerWrapper(viewModel: ViewModel(dataService: MockDataService()))
                .tabItem {
                    Label("UIKit", systemImage: "app.fill")
                }
        }
    }
}



// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
