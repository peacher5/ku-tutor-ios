//
//  FeedITemView.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI

struct FeedItemView: View {
    var title: String
    var description: String

    var body: some View {
        VStack (alignment: .leading) {
            Spacer().frame(maxWidth: .infinity, minHeight: 120, maxHeight: 120)
                .background(Color.black.opacity(0.1))

            Text(title)
                .padding([.top, .horizontal])
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
            .shadow(color: Color.black.opacity(0.1), radius: 4, y: 2)
    }
}

struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemView(title: "ติว Python By P'Tui", description: "ไม่มีคำอธิบาย")
    }
}
