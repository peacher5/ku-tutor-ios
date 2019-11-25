//
//  MainContentView.swift
//  tutor
//
//  Created by Peranut W. on 22/10/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI

struct MainPageView: View {

    var body: some View {
        ZStack {
            FeedTabView().environmentObject(FeedTabStore())

            VStack {
                Spacer()
                BlurView(style: .extraLight)
                    .frame(maxWidth: .infinity, maxHeight: 94).shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 0)
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("TUTOR FEED")
                        .font(.headline)
                        .frame(width: 120)
                        .foregroundColor(Color(hex: "#9aa03a"))
                    Spacer()
                    Text("|").foregroundColor(Color.black.opacity(0.3))
                    Spacer()
                    Text("MY PROFILE")
                        .font(.headline)
                        .frame(width: 120)
                        .foregroundColor(Color.black.opacity(0.4))
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: 94).padding(.bottom, 12)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
