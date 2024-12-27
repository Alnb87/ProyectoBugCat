import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        
        ScrollView {
            VStack(spacing: 5) {
                Text("Registro de Usuario")
                    .font(.largeTitle)
                    .padding()

                TextField("Nombre", text: $viewModel.nombre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Apellido", text: $viewModel.apellido)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("DNI", text: $viewModel.dni)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Celular", text: $viewModel.celular)
                    .keyboardType(.phonePad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Dirección", text: $viewModel.direccion)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Correo electrónico", text: $viewModel.email)
                    .keyboardType(.emailAddress) 
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Contraseña", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Confirmar contraseña", text: $viewModel.confirmarPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button("Registrar") {
                    viewModel.signUp()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
        }
        
        .alert(isPresented: $viewModel.showAlert) {
                  Alert(title: Text("Alerta"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))		
        }        .navigationTitle("Crear Cuenta")
        .navigationBarTitleDisplayMode(.inline)
    }
}



#Preview {
    RegisterView()
}
