import SwiftUI
import CloudKit

class RegisterViewViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let cloudKitManager = CloudKitManager.shared

    func register() {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "All fields are required."
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Invalid email format."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        guard isStrongPassword(password) else {
            errorMessage = "Password must be at least 8 characters long and contain an uppercase letter, lowercase letter, and a number."
            return
        }

        isLoading = true

        cloudKitManager.fetchUserForRegistration(username: username) { exists, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Error checking username: \(error.localizedDescription)"
                }
                return
            }

            if exists {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Username is already taken. Choose another."
                }
                return
            }

            self.cloudKitManager.saveUser(username: self.username, email: self.email, password: self.password) { success, error in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let error = error {
                        self.errorMessage = "Registration failed: \(error.localizedDescription)"
                    } else {
                        print("✅ Registration successful!")
                        self.errorMessage = nil
                    }
                }
            }
        }
    }

    /// Validate email format using regex
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    /// Check password strength: min 8 chars, includes upper, lower, and number
    private func isStrongPassword(_ password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}
