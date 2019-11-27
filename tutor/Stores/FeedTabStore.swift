//
//  FeedTabStore.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import Foundation

class FeedTabStore: ObservableObject {
    var rootStore: RootStore

    init(rootStore: RootStore) {
        self.rootStore = rootStore
    }
}
