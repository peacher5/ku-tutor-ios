//
//  FeedTabView.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI

struct FeedTabView: View {
    @Binding var showCreatePostPage: Bool
    @Binding var selectedPost: Post?
    @EnvironmentObject var store: FeedTabStore

    var body: some View {
        ZStack (alignment: .top) {

            VStack {
                Spacer().frame(maxWidth: .infinity, maxHeight: 160)

                List(store.rootStore.postList) { post in
                    FeedItemView(selectedPost: self.$selectedPost, post: post)
                }.edgesIgnoringSafeArea(.all)

            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            HStack (spacing: 0) {
                Text("Tutor Feed")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(.leading)
                    .padding(.bottom, 20)

                Spacer()

                Button(action: {
                    withAnimation {
                        self.showCreatePostPage = true
                    }
                }) {
                    HStack {

                        Image("baseline_create_white_36pt")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.white)

                        Text("Post")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 2)
                            .padding(.trailing, 20)

                    }.padding(.bottom, 20)
                }

            }.frame(maxWidth: .infinity, minHeight: 160, maxHeight: 160, alignment: .bottomLeading)
                .background(Color(hex: "#066664"))
                .shadow(color: Color.black.opacity(0.5), radius: 8)
                .edgesIgnoringSafeArea(.all)

        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.topLeading)
            .onAppear {
                UITableView.appearance().tableFooterView = UIView()
                UITableView.appearance().separatorStyle = .none

//                self.store.rootStore.fetchPostList()
        }
    }
}

struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTabView(showCreatePostPage: .constant(false), selectedPost: .constant(Post(id: "", title: "", description: "", content: "", coverPictureUrl: "", user: User(email: "", firstName: "", lastName: "", nickname: "", studentId: "", campus: "", faculty: "", department: "", pictureUrl: "", aboutMe: ""), last: false))).environmentObject(FeedTabStore(rootStore: RootStore()))
    }
}
