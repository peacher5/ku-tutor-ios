//
//  CreatePostPageView.swift
//  tutor
//
//  Created by Peranut W. on 26/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import SwiftUI
import UIKit
import FirebaseStorage

struct CreatePostPageView: View {
    var rootStore: RootStore

    @Binding var showCreatePostPage: Bool

    @State var title = ""
    @State var description = ""
    @State var content = ""

    @State var coverPicture: UIImage? = nil

    @State var showAlert = false
    @State var alertMessage: String?
    @State var alertAction: (() -> Void)?

    @State var showAction = false
    @State var showImagePicker = false

    @State var posting = false

    var sheet: ActionSheet {
        ActionSheet(
            title: Text("Cover Picture"),
            buttons: [
                    .default(Text("Change Cover Picture"), action: {
                            self.showAction = false
                            self.showImagePicker = true
                        }),
                    .cancel(Text("Close"), action: {
                            self.showAction = false
                        }),
                    .destructive(Text("Remove Cover Picture"), action: {
                            self.showAction = false
                            self.coverPicture = nil
                        })
            ])

    }

    var body: some View {
        ZStack (alignment: .top) {

            ScrollView {
                Spacer().frame(maxWidth: .infinity, maxHeight: 140)

                VStack (alignment: .leading) {

                    VStack (alignment: .leading, spacing: 6) {
                        Group {
                            Text("Title").font(.headline)
                            TextField("", text: $title).textFieldStyle(FormTextFieldStyle())

                            Text("Description").font(.headline).padding(.top, 10)
                            MultiLineTextField(text: $description)
                                .padding()
                                .background(Color(hex: "#e1e9eb"))
                                .cornerRadius(5)
                                .frame(height: 90)

                            Text("Course Content").font(.headline).padding(.top, 10)
                            MultiLineTextField(text: $content)
                                .padding()
                                .background(Color(hex: "#e1e9eb"))
                                .cornerRadius(5)
                                .frame(height: 180)

                            Text("Cover Picture").font(.headline).padding(.top, 10)

                            VStack {

                                if (coverPicture == nil) {
                                    Image(systemName: "camera.on.rectangle")
                                        .onTapGesture {
                                            self.showImagePicker = true
                                        }
                                        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200, alignment: .center)
                                        .foregroundColor(.white)
                                        .background(Color(hex: "#d8dd7b"))
                                        .cornerRadius(5)
                                } else {
                                    Image(uiImage: coverPicture!)
                                        .resizable()
                                        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200, alignment: .center)
                                        .cornerRadius(5)
                                        .onTapGesture {
                                            self.showAction = true
                                    }
                                }

                            }.sheet(isPresented: $showImagePicker, onDismiss: {
                                self.showImagePicker = false
                            }, content: {
                                    ImagePicker(isShown: self.$showImagePicker, uiImage: self.$coverPicture)
                                }).actionSheet(isPresented: $showAction) {
                                sheet
                            }

                            VStack {
                                Button(
                                    action: self.onPostButtonClick,
                                    label: { Text("Post").bold() }
                                ).buttonStyle(PrimaryButtonStyle())
                            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center).padding(.vertical, 40)

                            Spacer().frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                        }

                    }.padding(.horizontal, 18)

                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(alertMessage!), dismissButton: Alert.Button.default(Text("OK"), action: self.alertAction))
                }
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
                .shadow(radius: 10)

            if posting {
                ZStack {
                    BlurView(style: .extraLight)
                        .frame(maxWidth: .infinity, maxHeight: .infinity).shadow(color: Color.black.opacity(0.3), radius: 12, x: 0, y: 0)

                    Text("Posting...")
                        .font(.title)
                        .bold()

                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }

        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.topLeading)
            .background(Color.white)
            .transition(.move(edge: .trailing))
    }

    func onPostButtonClick() {
        self.posting = true
        uploadMedia { urlString in
            TutorApi.createPost(post: Post(title: self.title, description: self.description, content: self.content, coverPictureUrl: urlString!), token: self.rootStore.token!, callback: ResponseCallback(
                    onSuccess: { _ in
                        self.rootStore.fetchPostList(callback: Callback(run: {
                        }))
                        self.posting = false
                        self.alertMessage = "Posted!"
                        self.alertAction = {
                            self.showCreatePostPage = false
                        }
                        self.showAlert = true
                    },
                    onFailure: { statusCode in
                        self.alertMessage = "Failure: \(statusCode)"
                        self.alertAction = { }
                        self.showAlert = true
                    },
                    onError: { errorMessage in
                        self.alertMessage = "Error: \(errorMessage)"
                        self.alertAction = { }
                        self.showAlert = true
                    }))
        }
    }

    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child("\(UUID().uuidString).png")
        if let uploadData = rotateCameraImageToProperOrientation(imageSource: coverPicture!)!.pngData() {
            print("Uploading...")
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                print("Complete")
                if error != nil {
                    print("Upload cover picture error!")
                    print(error ?? "Error is null!?")
                    completion(nil)
                } else {
                    storageRef.downloadURL(completion: { (url, error) in
                        print(url?.absoluteString ?? "")
                        completion(url?.absoluteString)
                    })
                }
            }
        }
    }

    func rotateCameraImageToProperOrientation(imageSource: UIImage, maxResolution: CGFloat = 320) -> UIImage? {

        guard let imgRef = imageSource.cgImage else {
            return nil
        }

        let width = CGFloat(imgRef.width)
        let height = CGFloat(imgRef.height)

        var bounds = CGRect(x: 0, y: 0, width: width, height: height)

        var scaleRatio: CGFloat = 1
        if (width > maxResolution || height > maxResolution) {

            scaleRatio = min(maxResolution / bounds.size.width, maxResolution / bounds.size.height)
            bounds.size.height = bounds.size.height * scaleRatio
            bounds.size.width = bounds.size.width * scaleRatio
        }

        var transform = CGAffineTransform.identity
        let orient = imageSource.imageOrientation
        let imageSize = CGSize(width: CGFloat(imgRef.width), height: CGFloat(imgRef.height))

        switch(imageSource.imageOrientation) {
        case .up:
            transform = .identity
        case .upMirrored:
            transform = CGAffineTransform
                .init(translationX: imageSize.width, y: 0)
                .scaledBy(x: -1.0, y: 1.0)
        case .down:
            transform = CGAffineTransform
                .init(translationX: imageSize.width, y: imageSize.height)
                .rotated(by: CGFloat.pi)
        case .downMirrored:
            transform = CGAffineTransform
                .init(translationX: 0, y: imageSize.height)
                .scaledBy(x: 1.0, y: -1.0)
        case .left:
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform
                .init(translationX: 0, y: imageSize.width)
                .rotated(by: 3.0 * CGFloat.pi / 2.0)
        case .leftMirrored:
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform
                .init(translationX: imageSize.height, y: imageSize.width)
                .scaledBy(x: -1.0, y: 1.0)
                .rotated(by: 3.0 * CGFloat.pi / 2.0)
        case .right:
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform
                .init(translationX: imageSize.height, y: 0)
                .rotated(by: CGFloat.pi / 2.0)
        case .rightMirrored:
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform
                .init(scaleX: -1.0, y: 1.0)
                .rotated(by: CGFloat.pi / 2.0)
        @unknown default:
            fatalError()
        }

        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            if orient == .right || orient == .left {
                context.scaleBy(x: -scaleRatio, y: scaleRatio)
                context.translateBy(x: -height, y: 0)
            } else {
                context.scaleBy(x: scaleRatio, y: -scaleRatio)
                context.translateBy(x: 0, y: -height)
            }

            context.concatenate(transform)
            context.draw(imgRef, in: CGRect(x: 0, y: 0, width: width, height: height))
        }

        let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageCopy
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
        CreatePostPageView(rootStore: RootStore(), showCreatePostPage: .constant(true))
    }
}
