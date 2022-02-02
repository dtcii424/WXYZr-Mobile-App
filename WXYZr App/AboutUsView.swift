//
//  AboutUsView.swift
//  WXYZr App
//
//  Created by Derek Cox II on 4/9/21.
//

import SwiftUI

struct AboutUsView: View {
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
            Text("About Us").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            ScrollView{
                Text("WXYZr is a San Antonio based company making strides in the Social Technology Field. Founder and CEO, Terry French, wanted to create something that expanded the world of Social Technology while offering a useful service to the public. In such a technological diverse world, WXYZr’s goal is to safely bring people together through the power of social tech harnessed by  its multiple products such as wTag and wMark.").frame(width: 300).padding(65).font(.system(size: 22))
                Text("To learn more or to partner with us visit:").bold().font(.system(size: 18))
                Button(action: {
                    if let url = URL(string: "https://www.gowxyzr.com/") {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    Text("https://www.gowxyzr.com/").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).font(.system(size: 22))
                })
                Spacer()
            }
        }
    }
}

struct BindingViewExamplePreviewContainer_4 : View {
     @State
     private var value = false

     var body: some View {
          AboutUsView(isShow: $value)
     }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        BindingViewExamplePreviewContainer_4()
            .preferredColorScheme(.dark)
    }
}
