import SwiftUI

struct ContentView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            if authViewModel.isAuthenticated {
                EmployeeListView(authViewModel: authViewModel)  // Создадим позже
            } else {
                LoginView(authViewModel: authViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
