//
//  ContentView.swift
//  Friends
//
//  Created by Davron on 2/18/20.
//  Copyright © 2020 Davron. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Friend.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Friend.name, ascending: true)]) var friends: FetchedResults<Friend>
    
    @State private var image: Data?
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(friends, id: \.self) { friend in
                    NavigationLink(destination: DetailView(friend: friend)) {
                        HStack {
                            Image(uiImage: UIImage(data: friend.image ?? self.image!)!)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(50)

                            VStack(alignment: .leading, spacing: 3) {
                                Text("\(friend.name ?? "No name")")
                                    .font(.headline)
                                Text("\(friend.about ?? "No about")")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }.onDelete(perform: deleteFriend)
            }
            .navigationBarTitle("Friends", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showingAddScreen = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
        .sheet(isPresented: self.$showingAddScreen, content: {
            AddView().environment(\.managedObjectContext, self.moc)
        })
    }
    
    func deleteFriend(at offsets: IndexSet) {
        for index in offsets {
            let friend = friends[index]
            moc.delete(friend)
        }
        
        try? self.moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
