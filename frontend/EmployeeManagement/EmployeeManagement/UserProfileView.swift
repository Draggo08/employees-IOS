import SwiftUI

struct UserProfileView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var newPassword: String = ""
    @State private var isChangingPassword: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Профиль пользователя")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)
                
                Group {
                    HStack {
                        Text("Логин:")
                            .font(.headline)
                        Spacer()
                        Text(authViewModel.currentUser?.login ?? "")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 5)
                    
                    HStack {
                        Text("Имя:")
                            .font(.headline)
                        Spacer()
                        Text(authViewModel.currentUser?.firstName ?? "")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 5)
                    
                    HStack {
                        Text("Фамилия:")
                            .font(.headline)
                        Spacer()
                        Text(authViewModel.currentUser?.lastName ?? "")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 5)
                    
                    HStack {
                        Text("Электронная почта:")
                            .font(.headline)
                        Spacer()
                        Text(authViewModel.currentUser?.email ?? "")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 5)
                    
                    HStack {
                        Text("Пароль:")
                            .font(.headline)
                        Spacer()
                        Text("********")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 5)
                }

                Button(action: {
                    isChangingPassword.toggle()
                }) {
                    Text("Сменить пароль")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                
                if isChangingPassword {
                    VStack(alignment: .leading) {
                        SecureField("Новый пароль", text: $newPassword)
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
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 5)
                }
                
                Spacer()
                
                HStack {
                    Text("Количество сотрудников: \(authViewModel.employees.count)")
                        .font(.headline)
                    Spacer()
                }
                .padding(.top, 20)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .shadow(radius: 5)
            }
            .padding()
        }
        .background(Color(UIColor.systemGray6))
        .navigationBarTitle("Профиль", displayMode: .inline)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(authViewModel: AuthViewModel())
    }
}
