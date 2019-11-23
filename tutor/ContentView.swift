//
//  ContentView.swift
//  tutor
//
//  Created by Peranut W. on 23/10/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var store: AuthStore

    var body: some View {
        VStack {
            getPageView()
        }
    }

    private func getPageView() -> AnyView {
        if self.store.user != nil {
            return AnyView(MainPageView())
        } else {
            return AnyView(LoginPageView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthStore())
    }
}
