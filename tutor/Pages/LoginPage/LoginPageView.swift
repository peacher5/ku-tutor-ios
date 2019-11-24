//
//  ContentView.swift
//  tutor
//
//  Created by Peranut W. on 15/10/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct LoginPageView: View {

    struct LoginButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .frame(width: 340)
                .padding(.vertical, 16)
                .foregroundColor(.white)
                .background(configuration.isPressed ? Color.red : Color.green)
                .cornerRadius(100)
        }
    }

    var body: some View {
        VStack {
            Spacer()
            Button(action: signIn, label: { Text("เข้าสู่ระบบด้วยบัญชี KU Google").bold() }).buttonStyle(LoginButtonStyle())
        }.padding(.bottom, 30)
    }

    private func signIn() {
        guard let googleSignIn = GIDSignIn.sharedInstance() else { return }
        googleSignIn.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        googleSignIn.hostedDomain = "ku.th"
        googleSignIn.signIn()
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
