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
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .shadow(radius: 5)
            
            SecureField("Password", text: $authViewModel.password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .shadow(radius: 5)
            
            Button(action: {
                authViewModel.login()
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
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
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 5)
            }
            .padding()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .navigationBarTitle("Login", displayMode: .inline)
    }
}
