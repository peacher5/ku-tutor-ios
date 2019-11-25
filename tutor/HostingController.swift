//
//  HostingController.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI

class HostingController: UIHostingController<AnyView> {
    @Published var isDarkAppBar = false

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDarkAppBar ? .lightContent : .darkContent
    }
}
