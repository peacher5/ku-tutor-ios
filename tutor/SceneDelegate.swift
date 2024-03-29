//
//  SceneDelegate.swift
//  tutor
//
//  Created by Peranut W. on 15/10/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate, GIDSignInDelegate {
    var window: UIWindow?
    var rootStore = RootStore()

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Google SignIn Error: ", error)
            return
        }

//        print("+++++++++++++++")
//        print(credential)
//        print(user.authentication.idToken!)
//        print(user.profile.name!)
        print(user.profile.email!)
//        print("+++++++++++++++")

        rootStore.signInStatus = .SignedIn
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        guard let googleSignIn = GIDSignIn.sharedInstance() else { return }

        googleSignIn.clientID = FirebaseApp.app()?.options.clientID
        googleSignIn.delegate = self

        if (googleSignIn.hasPreviousSignIn()) {
            googleSignIn.restorePreviousSignIn()
        } else {
            rootStore.signInStatus = .NotSignedIn
        }

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let hostingController = HostingController(rootView: AnyView(ContentView().environmentObject(rootStore)))
            window.rootViewController = hostingController
            self.rootStore.rootViewController = hostingController
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

