//
//  AddView.swift
//  Friends
//
//  Created by Davron on 2/18/20.
//  Copyright © 2020 Davron. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var image: Image?
    @State private var uiImage: UIImage?
    @State private var inputImage: Data?
    @State private var showImagePicker = false
    @State private var name = ""
    @State private var about = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if image != nil {
                    Button(action: {
                        self.showImagePicker = true
                    }, label: {
                        image?
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(100)
                    })
                } else {
                    Button(action: {
                        self.showImagePicker = true
                    }, label: {
                        Image(systemName: "person.circle")
                            .font(.system(size: 100))
                            
                    })
                    .padding()
                }
                VStack {
                    TextField("Name", text: self.$name)
                        .padding()
                        .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                        .cornerRadius(20)
                    
                    TextField("About", text: self.$about)
                        .padding()
                        .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                        .cornerRadius(20)
                }.padding()
                
                Button(action: {
                    let friend = Friend(context: self.moc)
                    friend.name = self.name
                    friend.about = self.about
                    friend.image = self.inputImage
                    
                    try? self.moc.save()
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Add")
                        .frame(width: 150, height: 40)
                        .foregroundColor(self.name.count > 0 && self.about.count > 0 ? Color.white : Color.black)
                        .background(self.name.count > 0 && self.about.count > 0 ? Color.green : Color.secondary)
                        .cornerRadius(20)
                })
            }
            .navigationBarTitle("Add A Friend", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel"){
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        .sheet(isPresented: self.$showImagePicker, onDismiss: loadData, content: {
            ImagePicker(image: self.$inputImage, showImagePicker: self.$showImagePicker)
        })
    }
    
    func loadData() {
        guard let inputImage = inputImage else {
            return
        }
        
        self.uiImage = UIImage(data: inputImage)
        self.image = Image(uiImage: uiImage!)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
