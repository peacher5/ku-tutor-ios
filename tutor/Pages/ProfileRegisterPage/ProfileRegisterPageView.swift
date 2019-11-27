//
//  ProfileRegisterPage.swift
//  tutor
//
//  Created by Peranut W. on 24/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI

struct FormTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(hex: "#e1e9eb"))
            .cornerRadius(5)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 40)
            .padding(.vertical, 12)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color(hex: "#35a136") : Color.green)
            .cornerRadius(100)
    }
}

struct ProfileRegisterPageView: View {
    @EnvironmentObject var store: ProfileRegisterStore

    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                Text("Register Your Profile").font(.title).bold().padding().padding(.vertical, 20)

                VStack (alignment: .leading, spacing: 6) {
                    Group {
                        Text("First name").font(.headline)
                        TextField("", text: $store.firstName).textFieldStyle(FormTextFieldStyle())

                        Text("Last name").font(.headline).padding(.top, 10)
                        TextField("", text: $store.lastName).textFieldStyle(FormTextFieldStyle())

                        Text("Nickname").font(.headline).padding(.top, 10)
                        TextField("", text: $store.nickname).textFieldStyle(FormTextFieldStyle())
                    }

                    Text("KU Info")
                        .font(.title)
                        .padding(.vertical)

                    Group {
                        Text("Student ID").font(.headline)
                        TextField("", text: $store.studentId).textFieldStyle(FormTextFieldStyle())

                        Text("Campus").font(.headline).padding(.top, 10)

                        Picker(selection: $store.campus, label:
                                Text("Campus")
                            , content: {
                                Text("BKN").tag("BKN")
                                Text("KPS").tag("KPS")
                                Text("SRC").tag("SRC")
                                Text("CSC").tag("CSC")
                            }).pickerStyle(SegmentedPickerStyle()).frame(width: 378, height: 54, alignment: .center)

                        Text("Faculty").font(.headline).padding(.top, 10)
                        TextField("", text: $store.faculty).textFieldStyle(FormTextFieldStyle())

                        Text("Department").font(.headline).padding(.top, 10)
                        TextField("", text: $store.department).textFieldStyle(FormTextFieldStyle())
                    }

                    Text("Your Info")
                        .font(.title)
                        .padding(.vertical)

                    Text("About Me").font(.headline)
                    TextField("", text: $store.aboutMe).textFieldStyle(FormTextFieldStyle())

                    VStack {
                        Button(action: store.onRegisterButtonClick, label: { Text("Register").bold() }).buttonStyle(PrimaryButtonStyle())
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center).padding(.vertical, 30)

                }.padding(.horizontal, 18)

                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).alert(isPresented: $store.showAlert) {
                Alert(title: Text(store.errorMessage!), dismissButton: Alert.Button.default(Text("OK")))
            }
        }
    }
}

struct ProfileRegisterPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRegisterPageView()
    }
}
