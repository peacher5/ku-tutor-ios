//
//  User.swift
//  tutor
//
//  Created by Peranut W. on 24/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import Foundation

struct User: Codable {
    var email: String
    var firstName: String
    var lastName: String
    var nickname: String
    var studentId: String
    var campus: String
    var faculty: String
    var department: String
    var pictureUrl: String
    var aboutMe: String
}
