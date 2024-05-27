import SwiftUI

struct EmployeeListView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var newEmployeeName = ""
    
    var body: some View {
        VStack {
            NavigationLink(destination: UserProfileView(authViewModel: authViewModel)) {
                Text("Профиль")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding()

            HStack {
                Text("Logged in as \(authViewModel.currentUser?.login ?? "")")
                    .padding()
                Spacer()
            }
            
            TextField("New Employee Name", text: $newEmployeeName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding([.leading, .trailing], 20)
            
            Button(action: {
                authViewModel.addEmployee(name: newEmployeeName)
            }) {
                Text("Add Employee")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding()
            
            List {
                ForEach(authViewModel.employees) { employee in
                    HStack {
                        Text(employee.name)
                        Spacer()
                        Button(action: {
                            authViewModel.deleteEmployee(id: employee.id)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .onAppear {
            authViewModel.fetchEmployees()
        }
    }
}
