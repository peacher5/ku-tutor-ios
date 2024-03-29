//
//  ProfileRegisterStore.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import Foundation
import GoogleSignIn

class ProfileRegisterStore: ObservableObject {
    var rootStore: RootStore

    var errorMessage: String? {
        didSet {
            if errorMessage != nil {
                showAlert = true
            }
        }
    }

    @Published var showAlert = false

    @Published var firstName: String
    @Published var lastName: String
    @Published var nickname = ""
    @Published var studentId = ""
    @Published var campus = "BKN"
    @Published var faculty = ""
    @Published var department = ""
    @Published var aboutMe = ""

    var pictureUrl: String

    init(rootStore: RootStore) {
        let googleProfile = GIDSignIn.sharedInstance().currentUser.profile
        firstName = googleProfile?.givenName ?? ""
        lastName = googleProfile?.familyName ?? ""
        pictureUrl = (googleProfile?.imageURL(withDimension: 500)!.absoluteString)!
        self.rootStore = rootStore
    }

    func onRegisterButtonClick() {
        let profile = [
            "firstName": firstName,
            "lastName": lastName,
            "nickname": nickname,
            "studentId": studentId,
            "campus": campus,
            "faculty": faculty,
            "department": department,
            "aboutMe": aboutMe,
            "pictureUrl": pictureUrl
        ]

        TutorApi.createProfile(profile: profile, token: rootStore.token!, callback: ResponseCallback(
            onSuccess: { _ in
                TutorApi.fetchProfile(token: self.rootStore.token!, callback: ResponseCallback(
                    onSuccess: { user in
                        print(user)
                        self.rootStore.fetchPostList(callback: Callback(run: {
                            self.rootStore.profile = user
                            self.rootStore.profileRegisterStatus = .Registered
                        }))
                    },
                    onFailure: { statusCode in
                        if statusCode == 401 {
                            self.rootStore.keychain.clear()
                            self.rootStore.signInStatus = .Loading
                        } else if statusCode == 400 {
                            self.rootStore.profileRegisterStatus = .NotRegistered
                        } else {
                            self.rootStore.errorMessage = "[fetchProfile] \(statusCode)"
                        }
                    },
                    onError: { errorMessage in
                        self.rootStore.errorMessage = "[fetchProfile] \(errorMessage)"
                    }))

            },
            onFailure: { statusCode in
                self.errorMessage = "[createProfile] \(statusCode)"
//                if statusCode == 401 {
//                    // refresh token
//                }
            },
            onError: { errorMessage in
                self.errorMessage = "[createProfile] \(errorMessage)"
            }))
    }
}
