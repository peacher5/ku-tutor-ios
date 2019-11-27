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
import KeychainSwift

enum SignInStatus {
    case Loading, NotSignedIn, SignedIn
}

enum ProfileRegisterStatus {
    case Loading, NotRegistered, Registered
}

struct Callback {
    var run: () -> Void
}

class RootStore: ObservableObject {
    var keychain = KeychainSwift()
    var token: String?
    var profile: User?
    var rootViewController: HostingController?

    var updateFeed = false

    var errorMessage: String? {
        didSet {
            if errorMessage != nil {
                showAlert = true
            }
        }
    }

    @Published var postList: [Post] = [] {
        didSet {
            self.updateFeed = true
        }
    }

    @Published var showAlert = false

    @Published var signInStatus = SignInStatus.Loading {
        didSet {
            if (signInStatus == .Loading) {
                getOrFetchToken()
            } else if (signInStatus == .SignedIn) {
                if let token = token {
                    TutorApi.fetchProfile(token: token, callback: ResponseCallback(
                        onSuccess: { user in
                            print(user)

                            self.fetchPostList(callback: Callback(run: {
                                self.profile = user
                                self.profileRegisterStatus = .Registered
                            }))
                        },
                        onFailure: { statusCode in
                            if statusCode == 401 {
                                self.keychain.clear()
                                self.signInStatus = .Loading
                            } else if statusCode == 400 {
                                self.profileRegisterStatus = .NotRegistered
                            } else {
                                self.errorMessage = "[fetchProfile] \(statusCode)"
                            }
                        },
                        onError: { errorMessage in
                            self.errorMessage = "[fetchProfile] \(errorMessage)"
                        }))
                } else {
                    getOrFetchToken()
                }
            }
        }
    }

    @Published var profileRegisterStatus = ProfileRegisterStatus.Loading

    func fetchPostList(callback: Callback) {
        print("fetchPostList")
        TutorApi.fetchPostList(token: token!, callback: ResponseCallback(
            onSuccess: { postList in
                print("Success fetchPostList")

                var postList = postList

                for (index, _) in postList.enumerated() {
                    postList[index].last = index + 1 == postList.count
                }

                self.postList = postList
                callback.run()
            },
            onFailure: { statusCode in
                self.errorMessage = "[fetchPostList] \(statusCode)"
            },
            onError: { errorMessage in
                self.errorMessage = "[fetchPostList] \(errorMessage)"
            }))
    }

    func printServerStatus() {
        TutorApi.fetchServerStatus(callback: ResponseCallback(
            onSuccess: { serverStatus in
                print("-- KU Tutor API Success: \(serverStatus.status) --")
            },
            onFailure: { statusCode in
                print("-- KU Tutor API Failure: \(statusCode) --")
            },
            onError: { errorMessage in
                print("-- KU Tutor API Error: \(errorMessage) --")
            }))
    }

    private func getOrFetchToken() {
        if let token = keychain.get("token") {
            self.token = token
            print("My Token from Keychain: \(token)")
            self.signInStatus = .SignedIn

        } else {
            let idToken = GIDSignIn.sharedInstance()?.currentUser.authentication.idToken
            print(idToken!)
            TutorApi.auth(idToken: idToken!, callback: ResponseCallback(
                onSuccess: { tokenResponse in
                    let token = tokenResponse.token
                    print("My Token from server: \(token)")
                    self.token = token
                    self.keychain.set(token, forKey: "token")
                    self.signInStatus = .SignedIn
                },
                onFailure: { statusCode in
                    self.errorMessage = "[auth] \(statusCode)"
                },
                onError: { errorMessage in
                    self.errorMessage = "[auth] \(errorMessage)"
                }))
        }
    }
}
