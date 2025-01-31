import SwiftUI

// TODO: Add the full onboarding process with questions about the user for a tailored experience

struct OnboardingView: View {
    @State private var currentForm: FormType = .none
    
    enum FormType {
        case none, login, register
    }
    
    var body: some View {
        ZStack {
            
            Color(hex: 0xB5CFE3)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Back button
                HStack(spacing: 0) {
                    if( currentForm != .none){
                        Button(action:{ self.currentForm = .none} ) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color(hex: 0x4C708A))
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 25)
                Spacer()
                Image("VLogo")
                    .resizable()
                    .frame(width: 250, height: 250)
                Spacer()
                VStack(spacing: 16) {
                    if currentForm == .login {
                        LoginForm()
                    } else if currentForm == .register {
                        RegisterForm()
                    } else {
                        // View where the user chooses between Sign in or Register -> Might change later idk
                        // We might need to add Sign up using Google, Apple, etc..
                        // That is for later though
                        // TODO: Sign up options
                        VStack(spacing: 30) {
                            HStack(spacing : 300){
                                Spacer()
                                Button(action: {
                                    withAnimation { currentForm = .login }
                                }) {
                                    Text("Sign in")
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(10)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(TrianglePrimaryButton())
                                Spacer()
                            }
                            
                            // START DIVIDER
                            VStack {
                                LabelledDivider(label: "or", horizontalPadding: 20, color: Color.white)
                                    .frame(height: 1)
                            }
                            .padding(.horizontal, 400)
                            // END DIVIDER
                            
                            HStack(spacing : 300){
                                Spacer()
                                Button(action: {
                                    withAnimation { currentForm = .register }
                                }) {
                                    Text("Create an account")
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(10)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(TriangleSecondaryButton())
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
            }
            .animation(.easeInOut, value: currentForm)
        }
    }
}

struct LoginForm: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.body)
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(60)
                            .frame(maxWidth: .infinity)
                            .transition(.opacity)
                }
                HStack(spacing:300) {
                    Spacer()
                    TextField("Username", text: $viewModel.username)
                        .textFieldStyle(TriangleTextFieldStyle())
                    Spacer()
                }
                HStack(spacing:300) {
                    Spacer()
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(TriangleTextFieldStyle())
                    Spacer()
                }
                HStack(spacing: 300) {
                    Spacer()
                    Button(action: viewModel.login) {
                        ZStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .scaleEffect(1.5)
                            } else {
                                Text("Sign in")
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(10)
                                    .contentShape(Rectangle())
                            }
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: viewModel.isLoading)
                    .buttonStyle(TrianglePrimaryButton())
                    .disabled(viewModel.isLoading)
                    Spacer()
                }
            }
            .padding()
        }
        .animation(.easeInOut, value: viewModel.errorMessage)
    }
}


// Register Form
struct RegisterForm: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.body)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(60)
                        .frame(maxWidth: .infinity)
                        .transition(.opacity)
            }
            HStack(spacing:300){
                Spacer()
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(TriangleTextFieldStyle())
                Spacer()
            }
            
            HStack(spacing:300){
                Spacer()
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(TriangleTextFieldStyle())
                Spacer()
            }
            
            HStack(spacing:300){
                Spacer()
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(TriangleTextFieldStyle())
                Spacer()
            }
            
            HStack(spacing:300){
                Spacer()
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .textFieldStyle(TriangleTextFieldStyle())
                Spacer()
            }
            HStack(spacing:300){
                Spacer()
                Button(action: viewModel.register) {
                    ZStack {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Text("Create Account")
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                                .contentShape(Rectangle())
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: viewModel.isLoading)
                .buttonStyle(TrianglePrimaryButton())
                .disabled(viewModel.isLoading)
                Spacer()
            }
            
        }
        .padding()
    }
}

// Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDevice("iPad Pro 11-inch")
    }
}

struct LabelledDivider: View {
    
    let label: String
    let horizontalPadding: CGFloat
    let color: Color
    
    init(label: String, horizontalPadding: CGFloat = 8, color: Color = Color(UIColor.separator)) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            line
            Text(label)
                .font(.callout)
                .foregroundColor(color)
                .lineLimit(1)
                .fixedSize()
                .offset(y: -1)
            line
        }
    }
    
    var line: some View {
        VStack() { Divider().frame(height: 1).background(color) }.padding(horizontalPadding)
    }
}
