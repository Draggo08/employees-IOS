import SwiftUI

struct RegistrationView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.badge.plus")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
            
            TextField("First Name", text: $authViewModel.firstName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
            
            TextField("Last Name", text: $authViewModel.lastName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
            
            TextField("Email", text: $authViewModel.email)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
            
            TextField("Username", text: $authViewModel.username) // Используем переменную 'username'
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
            
            SecureField("Password", text: $authViewModel.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
            
            Button(action: {
                authViewModel.register()
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            .padding(.top, 20)
            
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
        .navigationBarTitle("Register", displayMode: .inline)
    }
}
