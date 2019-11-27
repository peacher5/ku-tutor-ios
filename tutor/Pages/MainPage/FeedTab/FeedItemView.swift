//
//  FeedITemView.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI
import Kingfisher

struct FeedItemView: SwiftUI.View {
    @Binding var selectedPost: Post?
    var post: Post

    var body: some SwiftUI.View {
        VStack (alignment: .leading) {

            KFImage(URL(string: post.coverPictureUrl) ?? URL(string: ""))
                .resizable()
                .background(Color.black.opacity(0.05))
                .frame(maxWidth: .infinity, minHeight: 120.0, maxHeight: 120)

            Text(post.title)
                .padding(.horizontal)
                .padding(.top, 4)
                .font(.headline)
                .lineLimit(2)

            Text(post.description)
                .padding([.bottom, .horizontal])
                .padding(.top, 10)
                .font(.subheadline)
                .foregroundColor(Color.black.opacity(0.64))
                .lineLimit(2)
        }
            .background(Color.white)
            .cornerRadius(6)
            .padding([.top, .horizontal])
            .shadow(color: Color.black.opacity(0.3), radius: 3, y: 2)
            .onTapGesture {
                print("Tap")
                withAnimation {
                    self.selectedPost = self.post
                }
            }
            .padding(.bottom, post.last! ? 140 : 0)
    }
}

struct FeedItemView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        FeedItemView(selectedPost: .constant(Post(id: "", title: "", description: "", content: "", coverPictureUrl: "", user: User(email: "", firstName: "", lastName: "", nickname: "", studentId: "", campus: "", faculty: "", department: "", pictureUrl: "", aboutMe: ""), last: false)), post: Post(id: "", title: "", description: "", content: "", coverPictureUrl: "", user: User(email: "", firstName: "", lastName: "", nickname: "", studentId: "", campus: "", faculty: "", department: "", pictureUrl: "", aboutMe: ""), last: false))

    }
}
