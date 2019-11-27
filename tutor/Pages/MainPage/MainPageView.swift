//
//  MainContentView.swift
//  tutor
//
//  Created by Peranut W. on 22/10/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI

enum Tab {
    case Feed, Profile
}

struct MainPageView: View {

    @EnvironmentObject var rootStore: RootStore
    @State var tab = Tab.Feed
    @State var showCreatePostPage = false
    @State var selectedPost: Post?

    var body: some View {
        ZStack {
            ZStack (alignment: .top) {
                Spacer()
                    .frame(maxWidth: .infinity, minHeight: 160, maxHeight: 160)
                    .background(Color(hex: "#066664"))
                    .edgesIgnoringSafeArea(.all)
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.topLeading)

            if tab == .Feed {
                FeedTabView(showCreatePostPage: $showCreatePostPage, selectedPost: $selectedPost)
                    .environmentObject(FeedTabStore(rootStore: rootStore))
                    .transition(.opacity)
            } else {
                ProfileTabView(profile: rootStore.profile!)
                    .transition(.opacity)
            }

            VStack {
                Spacer()
                BlurView(style: .extraLight)
                    .frame(maxWidth: .infinity, maxHeight: 94).shadow(color: Color.black.opacity(0.3), radius: 12, x: 0, y: 0)
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()

                    Text("TUTOR FEED")
                        .font(.headline)
                        .frame(width: 120, height: 80)
                        .foregroundColor(tab == .Feed ? Color(hex: "#9aa03a") : Color.black.opacity(0.4))
                        .onTapGesture {
                            withAnimation {
                                self.tab = .Feed
                            }
                    }

                    Spacer()
                    Text("|").foregroundColor(Color.black.opacity(0.3))
                    Spacer()

                    Text("MY PROFILE")
                        .font(.headline)
                        .frame(width: 120, height: 80)
                        .foregroundColor(tab == .Profile ? Color(hex: "#9aa03a") : Color.black.opacity(0.4))
                        .onTapGesture {
                            withAnimation {
                                self.tab = .Profile
                            }
                    }

                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: 94).padding(.bottom, 12)
            }

            if showCreatePostPage {
                CreatePostPageView(rootStore: rootStore, showCreatePostPage: $showCreatePostPage)
            }

            if selectedPost != nil {
                ViewPostPageView(post: $selectedPost)
            }

        }.edgesIgnoringSafeArea(.all)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView().environmentObject(RootStore())
    }
}
