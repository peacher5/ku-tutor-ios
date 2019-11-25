//
//  FeedTabStore.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import Foundation

class FeedTabStore: ObservableObject {
    @Published var postList: [Post]

    init() {
        postList = [
            Post(id: "1", title: "ติว Python By P'Tui", description: "ไม่มีคำอธิบาย"),
            Post(id: "2", title: "ทดสอบ 2", description: "1234")
        ]
    }
}
