//
//  PartnersView.swift
//  WXYZr App
//
//  Created by Derek Cox II on 4/9/21.
//

import SwiftUI

struct PartnersView: View {
    @Binding var isShow: Bool
    var body: some View{
        VStack(){
            HStack {
                Button(action: {
                    isShow.toggle()
                }, label: {
                    Text("X").bold().accentColor(.red).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }).padding()
            Spacer()
            }
            Text("Partners").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(.bottom, 150)
            Text("Bunz Hand Crafted Burgers").bold()
            Image("bunz")
            Spacer()
            Spacer()
            Text("More coming soon!").bold()
            Text("Click \"About Us\" for more information").bold()
                }
    }
}

struct BindingViewExamplePreviewContainer_3 : View {
     @State
     private var value = false

     var body: some View {
          PartnersView(isShow: $value)
     }
}

struct PartnersView_Previews: PreviewProvider {
    static var previews: some View {
        BindingViewExamplePreviewContainer_3()
            .preferredColorScheme(.dark)
    }
}
