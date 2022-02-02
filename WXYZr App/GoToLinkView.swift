//
//  GoToLinkView.swift
//  WXYZr App
//
//  Created by Derek Cox II on 4/14/21.
//

import SwiftUI

struct GoToLinkView: View {
    let link: String
    var body: some View {
        VStack(alignment: .leading){
            Text("Go to:").font(.title)
            Spacer()
            Button(action: {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url)
                }
            }, label: {
                Text(link).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).font(.title)
            })
            Spacer()
        }
    }
}

struct GoToLinkView_Previews: PreviewProvider {
    static var previews: some View {
        GoToLinkView(link: code.links[0])
    }
}
