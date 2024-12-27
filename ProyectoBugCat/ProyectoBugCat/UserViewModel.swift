import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var nombre: String = ""
    @Published var apellido: String = ""
    @Published var dni: String = ""
    @Published var celular: String = ""
    @Published var confirmarPassword: String = ""
    @Published var direccion: String = ""
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    
   
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.errorMessage = "Inicio de sesión exitoso"
            }
        }
    }
    
    func signUp() {
        
        guard password == confirmarPassword else {
            errorMessage = "Las contraseñas no coinciden"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            guard let uid = result?.user.uid else {
                self.errorMessage = "No se pudo obtener el UID del usuario"
                return
            }
            
            let db = Firestore.firestore()
            let userData: [String: Any] = [
                "email": self.email,
                "nombre": self.nombre,
                "apellido": self.apellido,
                "dni": self.dni,
                "celular": self.celular,
                "direccion": self.direccion
            ]
            
            db.collection("usuarios").document(uid).setData(userData) { error in
                if let error = error {
                    self.errorMessage = "Error al guardar la información del usuario: \(error.localizedDescription)"
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   
                        self.alertMessage = "Tu cuenta ha sido creada correctamente."
                        self.showAlert = true
                    }
                               
            }
        }
    }
    }
    }
