//
//  ProfileRegisterPage.swift
//  tutor
//
//  Created by Peranut W. on 24/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI

struct ProfileRegisterPageView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var nickname = ""
    @State var studentId = ""
    @State var campus = ""
    @State var faculty = ""
    @State var department = ""
    @State var aboutMe = ""

    struct FormTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding()
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(5)
        }
    }

    struct RegisterButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .foregroundColor(.white)
                .background(configuration.isPressed ? Color.red : Color.green)
                .cornerRadius(100)
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("Register Profile").font(.largeTitle).bold().padding(30)

                VStack (alignment: .leading, spacing: 6) {
                    Group {
                        Text("First name").font(.headline)
                        TextField("", text: $firstName).textFieldStyle(FormTextFieldStyle())

                        Text("Last name").font(.headline).padding(.top, 10)
                        TextField("", text: $lastName).textFieldStyle(FormTextFieldStyle())

                        Text("Nickname").font(.headline).padding(.top, 10)
                        TextField("", text: $nickname).textFieldStyle(FormTextFieldStyle())
                    }

                    Text("KU Info")
                        .font(.title)
                        .bold()
                        .padding(.vertical)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)

                    Group {
                        Text("Student ID").font(.headline)
                        TextField("", text: $studentId).textFieldStyle(FormTextFieldStyle())

                        Text("Campus").font(.headline).padding(.top, 10)
                        TextField("", text: $campus).textFieldStyle(FormTextFieldStyle())

                        Text("Faculty").font(.headline).padding(.top, 10)
                        TextField("", text: $faculty).textFieldStyle(FormTextFieldStyle())

                        Text("Department").font(.headline).padding(.top, 10)
                        TextField("", text: $department).textFieldStyle(FormTextFieldStyle())

                        Text("About Me").font(.headline).padding(.top, 10)
                        TextField("", text: $aboutMe).textFieldStyle(FormTextFieldStyle())
                    }

                    VStack {
                        Button(action: { }, label: { Text("Register").bold() }).buttonStyle(RegisterButtonStyle())
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center).padding(.vertical, 20)

                }.padding(.horizontal, 18)

                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct ProfileRegisterPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRegisterPageView()
    }
}
