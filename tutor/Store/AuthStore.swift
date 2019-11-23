//
//  AuthStore.swift
//  tutor
//
//  Created by Peranut W. on 23/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

class AuthStore: ObservableObject {
    @Published var user: GIDGoogleUser?
}
