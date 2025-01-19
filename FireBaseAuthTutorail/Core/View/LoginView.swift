//
//  LoginView.swift
//  FireBaseAuthTutorail
//
//  Created by Sudhanshu Singh Rajput on 19/01/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email:String = ""
    @State private var password:String = ""
    @EnvironmentObject var viewModel:AuthViewModel
    var body: some View {
        NavigationStack{
            //image
            Image(systemName:"paperplane")
                .resizable()
                .scaledToFill()
                .frame(width: 100,height: 200)
                .padding(.vertical,32)
                .foregroundStyle(Color.init(red: 0, green: 0.387, blue: 0.5))
            
            VStack(spacing: 24){
                //email
                InputView(text:$email, title:"Email Address",placeholder: "name@example.com")
                    .textInputAutocapitalization(.never)
                //password
                InputView(text: $password, title: "Password", placeholder: "Enter Your Password",isSecureField: true)
            }.padding(.horizontal)
            .padding(.top,12)
            //sign In
            ButtonView(title: "SIGN IN") {
                Task{
                    try await viewModel.signIn(withEmail: email, password: password)
                }
            }
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0:0.5)
            .padding(.top,24)
            Spacer()
            //Sign Up
            NavigationLink {
                RegistrationView()
                    .navigationBarBackButtonHidden()
            } label: {
                HStack(spacing:3){
                    Text("Don't have an Account")
                    Text("Sign Up")
                }
                .font(.system(size: 14))
                .foregroundStyle(Color.init(red: 0, green: 0.387, blue: 0.5))
            }
        }
    }
}
extension LoginView:AuthenticationProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count >= 6
    }
}
#Preview {
    LoginView()
}
