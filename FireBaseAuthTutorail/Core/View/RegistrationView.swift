//
//  RegistrationView.swift
//  FireBaseAuthTutorail
//
//  Created by Sudhanshu Singh Rajput on 19/01/25.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var fullName:String = ""
    @State private var confirmPassword:String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel:AuthViewModel
    var body: some View {
        VStack{
            Image(systemName:"paperplane")
                .resizable()
                .scaledToFill()
                .frame(width: 100,height: 200)
                .padding(.vertical,32)
                .foregroundStyle(Color.init(red: 0, green: 0.387, blue: 0.5))
            VStack(spacing:24){
                InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                    .textInputAutocapitalization(.never)
                InputView(text: $fullName, title: "Full Name", placeholder: "Enter Your Name")
                
                InputView(text: $password, title: "Password", placeholder: "Enter Your Password",isSecureField: true)
                ZStack(alignment:.trailing){
                    InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm Your Password",isSecureField: true)
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        if password == confirmPassword{
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemGreen))
                        }
                        else{
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemRed))
                        }
                    }
                }
            }.padding(.horizontal)
                .padding(.top,12)
            
            ButtonView(title: "SIGN UP") {
                Task{
                    try await viewModel.createUser(withEmail: email, password: password, fullName: fullName)
                }
            }
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0:0.5)
            .padding(.top,24)
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3){
                    Text("Already have an Account?")
                    Text("Sign In")
                }
                .font(.system(size: 14))
                .foregroundStyle(Color.init(red: 0, green: 0.387, blue: 0.5))
            }
        }
    }
}
extension RegistrationView:AuthenticationProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>=6
        && password == confirmPassword
        && !fullName.isEmpty
        
    }
}
#Preview {
    RegistrationView()
}
