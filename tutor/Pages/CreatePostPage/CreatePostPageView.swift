//
//  CreatePostPageView.swift
//  tutor
//
//  Created by Peranut W. on 26/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI

struct CreatePostPageView: View {
    @Binding var showCreatePostPage: Bool

    var body: some View {
        ZStack (alignment: .top) {

            ScrollView {
                Spacer().frame(maxWidth: .infinity, maxHeight: 140)

                VStack (alignment: .leading) {

                    VStack (alignment: .leading, spacing: 6) {
                        Group {
                            Text("Title").font(.headline)
                            TextField("", text: .constant("")).textFieldStyle(FormTextFieldStyle())

                            Text("Description").font(.headline).padding(.top, 10)
                            MultiLineTextField(text: .constant(""))
                                .padding()
                                .background(Color(hex: "#e1e9eb"))
                                .cornerRadius(5)
                                .frame(height: 90)

                            Text("Course Content").font(.headline).padding(.top, 10)
                            MultiLineTextField(text: .constant(""))
                                .padding()
                                .background(Color(hex: "#e1e9eb"))
                                .cornerRadius(5)
                                .frame(height: 180)
                        }

                        Spacer().frame(maxWidth: .infinity, minHeight: 20)

                    }.padding(.horizontal, 18)

                    VStack {
                        Button(action: { }, label: { Text("Post").bold() }).buttonStyle(PrimaryButtonStyle())
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center).padding(.vertical, 30)


                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//                    .alert(isPresented: $store.showAlert) {
//                        Alert(title: Text(store.errorMessage!), dismissButton: Alert.Button.default(Text("OK")))
//                }
            }

            HStack (spacing: 0) {

                Button(action: {
                    withAnimation {
                        self.showCreatePostPage = false
                    }
                }) {
                    Image("baseline_arrow_back_ios_black_36pt")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.white)
                        .padding(.leading, 16)
                        .padding(.bottom, 20)
                }

                Text("New Post")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(.leading)
                    .padding(.bottom, 20)
            }.frame(maxWidth: .infinity, minHeight: 160, maxHeight: 160, alignment: .bottomLeading)
                .background(Color(hex: "#066664"))
                .edgesIgnoringSafeArea(.all)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)

        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.topLeading)
            .background(Color.white)
            .transition(.move(edge: .trailing))
    }
}

struct MultiLineTextField: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.delegate = context.coordinator

        myTextView.font = UIFont(name: "HelveticaNeue", size: 18)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = Color(hex: "#e1e9eb").uiColor()

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator: NSObject, UITextViewDelegate {

        var parent: MultiLineTextField

        init(_ uiTextView: MultiLineTextField) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
//            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
}

struct CreatePostPageView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostPageView(showCreatePostPage: .constant(true))
    }
}
