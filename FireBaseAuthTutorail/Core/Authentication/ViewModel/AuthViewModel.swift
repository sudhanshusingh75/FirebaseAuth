//
//  AuthViewModel.swift
//  FireBaseAuthTutorail
//
//  Created by Sudhanshu Singh Rajput on 19/01/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
protocol AuthenticationProtocol{
    var formIsValid : Bool{
        get
    }
}
@MainActor
class AuthViewModel : ObservableObject{
    @Published var userSession:FirebaseAuth.User?
    @Published var currentUser:User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    func signIn(withEmail email:String,password:String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }
        catch{
            
        }
    }
    func createUser(withEmail email:String,password:String,fullName:String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }
        catch{
            print("DEBUG: Failed to Create a user with Error\(error.localizedDescription)")
        }
    }
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }
        catch{
            print("DEBUG: Failed to SignOut with Error\(error.localizedDescription)")
        }
    }
    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid else{return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument()else{return}
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
