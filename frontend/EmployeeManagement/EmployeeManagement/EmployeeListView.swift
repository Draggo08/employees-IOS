import SwiftUI

struct EmployeeListView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var employees: [Employee] = []
    @State private var newEmployeeName = ""

    var body: some View {
        VStack {
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
                addEmployee()
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
                ForEach(employees) { employee in
                    HStack {
                        Text(employee.name)
                        Spacer()
                        Button(action: {
                            deleteEmployee(employee.id)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .onAppear {
            fetchEmployees()
        }
    }
    
    func fetchEmployees() {
        NetworkService.shared.fetchEmployees { result in
            switch result {
            case .success(let employees):
                DispatchQueue.main.async {
                    self.employees = employees
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addEmployee() {
        NetworkService.shared.addEmployee(name: newEmployeeName) { result in
            switch result {
            case .success(let employees):
                DispatchQueue.main.async {
                    self.employees = employees
                    newEmployeeName = ""
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteEmployee(_ id: String) {
        NetworkService.shared.deleteEmployee(id: id) { result in
            switch result {
            case .success(let employees):
                DispatchQueue.main.async {
                    self.employees = employees
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct EmployeeListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListView(authViewModel: AuthViewModel())
    }
}
