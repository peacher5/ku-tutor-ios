//
//  FeedITemView.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI
import URLImage
import Kingfisher

struct FeedItemView: SwiftUI.View {
    var title: String
    var description: String

    var body: some SwiftUI.View {
        VStack (alignment: .leading) {

            KFImage(URL(string: "https://picsum.photos/440/200")!)
                .resizable()
                .background(Color.black.opacity(0.05))
                .frame(maxWidth: .infinity, minHeight: 120.0, maxHeight: 120)
            
            Text(title)
                .padding(.horizontal)
                .padding(.top, 4)
                .font(.headline)
                .lineLimit(2)

            Text(description)
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
        }
    }
}

struct FeedItemView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        FeedItemView(title: "ติว Python By P'Tui", description: "ไม่มีคำอธิบาย")
    
    }
}
