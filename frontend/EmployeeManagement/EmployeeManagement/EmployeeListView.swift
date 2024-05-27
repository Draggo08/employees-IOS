import SwiftUI

struct EmployeeListView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var newEmployeeName = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: UserProfileView(authViewModel: authViewModel)) {
                        Text("Профиль")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: {
                        authViewModel.logout()
                    }) {
                        Text("Выйти")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding()
                }

                HStack {
                    Text("Logged in as \(authViewModel.currentUser?.login ?? "")")
                        .padding()
                        .foregroundColor(.gray)
                    Spacer()
                }
                
                TextField("New Employee Name", text: $newEmployeeName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding([.leading, .trailing], 20)
                
                Button(action: {
                    authViewModel.addEmployee(name: newEmployeeName)
                }) {
                    Text("Add Employee")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()

                ScrollView {
                    LazyVStack {
                        ForEach(authViewModel.employees) { employee in
                            HStack {
                                Text(employee.name)
                                    .font(.subheadline)
                                Spacer()
                                Button(action: {
                                    authViewModel.deleteEmployee(id: employee.id)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding()
                                        .background(Color(red: 1, green: 0.8, blue: 0.8))
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding([.leading, .trailing], 20)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .onAppear {
                authViewModel.fetchEmployees()
            }
            .navigationBarTitle("Сотрудники", displayMode: .inline)
        }
    }
}
