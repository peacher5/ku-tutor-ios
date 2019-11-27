//
//  Post.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import Foundation

struct Post: Codable, Identifiable {
    var id: String?
    var title: String
    var description: String
    var content: String
    var coverPictureUrl: String
    var user: User?
    var last: Bool?
}
