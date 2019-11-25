//
//  FeedTabView.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI

struct FeedTabView: View {
    @EnvironmentObject var store: FeedTabStore

    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        ZStack (alignment: .top) {

            VStack {
                Spacer().frame(maxWidth: .infinity, maxHeight: 160)

                List(store.postList) { post in
                    FeedItemView(title: post.title, description: post.description)
                }

            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            VStack (spacing: 0) {
                Text("Tutor Feed")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(.leading)
                    .padding(.bottom, 20)
            }.frame(maxWidth: .infinity, minHeight: 160, maxHeight: 160, alignment: .bottomLeading)
                .background(Color(hex: "#066664"))
                .edgesIgnoringSafeArea(.all)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)

        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.topLeading)
    }
}

struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTabView()
    }
}
