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
    @EnvironmentObject var store: RootStore

    var body: some View {
        VStack {
            getPageView().alert(isPresented: $store.showAlert) {
                Alert(title: Text(store.errorMessage!), dismissButton: Alert.Button.default(
                        Text("Retry"), action: { self.store.signInStatus = .Loading }))
            }
        }
    }

    private func getPageView() -> AnyView {

        switch self.store.signInStatus {
        case .Loading:
            return AnyView(Text("Loading..."))
        case .NotSignedIn:
            return AnyView(LoginPageView())
        case .SignedIn:
            switch self.store.profileRegisterStatus {
            case .Loading:
                return AnyView(Text("Loading..."))
            case .NotRegistered:
                return AnyView(ProfileRegisterPageView().environmentObject(ProfileRegisterStore(rootStore: self.store)))
            case .Registered:
                self.store.rootViewController?.isDarkAppBar = true
                return AnyView(MainPageView().environmentObject(self.store))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RootStore())
    }
}
