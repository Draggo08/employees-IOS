import SwiftUI

struct LoginView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
            
            TextField("Email", text: $authViewModel.email)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
            
            SecureField("Password", text: $authViewModel.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
            
            Button(action: {
                authViewModel.login() // Вызов метода 'login'
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding(.top, 20)
            
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            NavigationLink(destination: RegistrationView(authViewModel: authViewModel)) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .padding()
        .navigationBarTitle("Login", displayMode: .inline)
    }
}
