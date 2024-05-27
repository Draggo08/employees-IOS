import SwiftUI

struct UserProfileView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var newPassword: String = ""
    @State private var isChangingPassword: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Профиль пользователя")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            HStack {
                Text("Логин:")
                    .font(.headline)
                Spacer()
                Text(authViewModel.currentUser?.login ?? "")
            }
            
            HStack {
                Text("Имя:")
                    .font(.headline)
                Spacer()
                Text(authViewModel.currentUser?.firstName ?? "")
            }
            
            HStack {
                Text("Фамилия:")
                    .font(.headline)
                Spacer()
                Text(authViewModel.currentUser?.lastName ?? "")
            }
            
            HStack {
                Text("Электронная почта:")
                    .font(.headline)
                Spacer()
                Text(authViewModel.currentUser?.email ?? "")
            }
            
            HStack {
                Text("Пароль:")
                    .font(.headline)
                Spacer()
                Text("********")
            }
            
            Button(action: {
                isChangingPassword.toggle()
            }) {
                Text("Сменить пароль")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
            if isChangingPassword {
                TextField("Новый пароль", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 20)
                
                Button(action: {
                    authViewModel.changePassword(newPassword: newPassword)
                    isChangingPassword = false
                }) {
                    Text("Сохранить пароль")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
            
            Spacer()
            
            HStack {
                Text("Количество сотрудников: \(authViewModel.employees.count)")
                    .font(.headline)
                Spacer()
            }
            .padding(.top, 20)
        }
        .padding()
        .navigationBarTitle("Профиль")
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(authViewModel: AuthViewModel())
    }
}
