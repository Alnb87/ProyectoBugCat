import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Iniciar Sesión")
                    .font(.largeTitle)
                    .padding()

                TextField("Correo electrónico", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Contraseña", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Ingresar") {
                    
                    viewModel.signIn()
                    
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)

                HStack(spacing: 0) {
                    Text("¿No tienes una cuenta?")
                        .fontWeight(.bold)
                        .padding(.top, 40)
                    NavigationLink(destination: RegisterView()) {
                        
                        Text("Regístrate")
                            .foregroundColor(.blue)
                            .padding(.leading)
                            .padding(.top, 40)
                            .fontWeight(.medium)
                        
                    }
                    
                }

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
        }
            
        }
        
        
}



#Preview {
    LoginView()
}
