//
//  ProfileTabView.swift
//  tutor
//
//  Created by Peranut W. on 25/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ProfileTabView: SwiftUI.View {
    var profile: User

    var body: some SwiftUI.View {
        ZStack (alignment: .top) {

            VStack (spacing: 0) {
                Spacer().frame(maxWidth: .infinity, maxHeight: 160)

                ScrollView {

                    VStack (spacing: 0) {
                        Spacer().frame(maxWidth: .infinity, minHeight: 30, maxHeight: 30)

                        ZStack (alignment: .bottom) {

                            KFImage(URL(string: profile.pictureUrl)!)
                                .resizable()
                                .clipShape(Circle())
                                .frame(minWidth: 150, maxWidth: 150, minHeight: 150, maxHeight: 150)
                                .shadow(color: Color.black.opacity(0.2), radius: 10)

                            VStack {
                                Text("KU 77")
                                    .font(.headline)
                                    .frame(width: 50, height: 20)
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                            }
                                .background(Color.white)
                                .cornerRadius(6)
                                .padding([.top, .horizontal])
                                .shadow(color: Color.black.opacity(0.1), radius: 4, y: 2)
                                .offset(y: 8)

                        }

                        Text("\(profile.firstName) \(profile.lastName)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.black.opacity(0.72))
                            .padding([.top, .horizontal], 22)

                        Text("(\(profile.nickname))")
                            .font(.system(size: 22))
                            .foregroundColor(Color.black.opacity(0.72))
                            .padding(.vertical, 4)

                        VStack (alignment: .leading) {
                            Text("About Me")
                                .font(.headline)
                                .padding([.top, .horizontal])

                            Text(profile.aboutMe)
                                .padding()
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(6)
                            .padding([.top, .horizontal])
                            .shadow(color: Color.black.opacity(0.1), radius: 4, y: 2)

                        VStack (alignment: .leading) {
                            Text("EDUCATION @ KU")
                                .font(.headline)
                                .padding([.top, .horizontal])

                            HStack (alignment: .top) {
                                VStack (alignment: .trailing, spacing: 6) {
                                    Text("Campus:")
                                        .foregroundColor(Color.black.opacity(0.7))
                                    Text("Faculty:")
                                        .foregroundColor(Color.black.opacity(0.7))
                                    Text("Department:")
                                        .foregroundColor(Color.black.opacity(0.7))
                                }

                                VStack (alignment: .leading, spacing: 6) {
                                    Text(profile.campus)
                                    Text(profile.faculty)
                                    Text(profile.department)
                                }
                            }.padding()
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(6)
                            .padding([.top, .horizontal])
                            .shadow(color: Color.black.opacity(0.1), radius: 4, y: 2)

                        VStack (alignment: .leading) {
                            Text("Contact")
                                .font(.headline)
                                .padding([.top, .horizontal])

                            HStack (alignment: .top) {
                                VStack (alignment: .trailing, spacing: 6) {
                                    Text("Mobile:")
                                        .foregroundColor(Color.black.opacity(0.7))
                                    Text("Email:")
                                        .foregroundColor(Color.black.opacity(0.7))
                                    Text("Facebook:")
                                        .foregroundColor(Color.black.opacity(0.7))
                                    Text("LINE:")
                                        .foregroundColor(Color.black.opacity(0.7))
                                }

                                VStack (alignment: .leading, spacing: 6) {
                                    Text("-")
                                    Text(profile.email)
                                    Text("-")
                                    Text("-")
                                }
                            }.padding()
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(6)
                            .padding([.top, .horizontal])
                            .shadow(color: Color.black.opacity(0.1), radius: 4, y: 2)

                        Spacer().frame(maxWidth: .infinity, minHeight: 140, maxHeight: 140)

                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .edgesIgnoringSafeArea(.all)

                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color(hex: "#d8dd7b"))
                .edgesIgnoringSafeArea(.all)

            VStack (spacing: 0) {
                Text("My Profile")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(.leading)
                    .padding(.bottom, 20)
            }.frame(maxWidth: .infinity, minHeight: 160, maxHeight: 160, alignment: .bottomLeading)
                .background(Color(hex: "#066664"))
                .shadow(color: Color.black.opacity(0.4), radius: 8)
                .edgesIgnoringSafeArea(.all)

        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.topLeading)
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ProfileTabView(profile: User(email: "test@ku.th", firstName: "Fn", lastName: "Ln", nickname: "Nn", studentId: "6010405360", campus: "BKN", faculty: "SC", department: "CS", pictureUrl: "https://i.pravatar.cc/500", aboutMe: "Hi"))
    }
}
