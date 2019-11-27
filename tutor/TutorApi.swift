//
//  TutorApi.swift
//  tutor
//
//  Created by Peranut W. on 23/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import Foundation

struct ServerStatusResponse: Codable {
    var status: String
}

struct AuthResponse: Decodable {
    var token: String
}

class TutorApi {
    private static var baseUrl = "http://localhost:5000"

    private init() { }

    static func fetchServerStatus(callback: ResponseCallback<ServerStatusResponse>) {
        ApiUtil.fetchJSON(url: baseUrl, type: ServerStatusResponse.self, callback: callback)
    }

    static func auth(idToken: String, callback: ResponseCallback<AuthResponse>) {
        ApiUtil.fetchJSON(url: baseUrl + "/auth", headers: ["X-IdToken": idToken], type: AuthResponse.self, callback: callback)
    }

    static func checkValidToken(token: String, callback: ResponseCallback<Bool>) {
        ApiUtil.fetchJSON(url: baseUrl + "/auth/token", headers: ["X-Token": token], type: Bool.self, callback: callback)
    }

    static func fetchProfile(token: String, callback: ResponseCallback<User>) {
        ApiUtil.fetchJSON(url: baseUrl + "/user", headers: ["X-Token": token], type: User.self, callback: callback)
    }

    static func createProfile(profile: [String: Any], token: String, callback: ResponseCallback<Void>) {
        ApiUtil.postJSON(url: baseUrl + "/user/create", headers: ["X-Token": token], jsonBody: profile, callback: callback)
    }
}
