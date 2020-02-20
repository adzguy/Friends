//
//  DetailView.swift
//  Friends
//
//  Created by Davron on 2/20/20.
//  Copyright © 2020 Davron. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let friend: Friend
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: self.friend.image!)!)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 300, height: 300)
                
            
            Text(self.friend.name!)
                .font(.headline)
            Text(self.friend.about!)
                .font(.footnote)
            Spacer()
        }
       
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
