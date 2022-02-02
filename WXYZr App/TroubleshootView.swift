//
//  TroubleshootView.swift
//  WXYZr App
//
//  Created by Derek Cox II on 4/9/21.
//

import SwiftUI

struct TroubleshootView: View {
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
            Text("Troubleshoot").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            ScrollView{
                Text("In order to properly use the  WXYZr App, please ensure NFC is enabled on your device. When Tapping your phone against a “Tap-In”, please ensure you tap the area of your phone close to where the NFC chip is.\n\nFor an iPhone, it is typically near the top\n\nFor Android, it is typically in the middle.\n\nBring your device to the Tap In tag and make contact where your nfc chip is located on your device to scan a tag.\n***More troubleshooting info once we finish testing this is an example*** ").frame(width: 300).padding(100).font(.system(size: 22))
                Spacer()
            }
            Spacer()
                }
    }
}

struct BindingViewExamplePreviewContainer_2 : View {
     @State
     private var value = false

     var body: some View {
          TroubleshootView(isShow: $value)
     }
}

struct TroubleshootView_Previews: PreviewProvider {
    static var previews: some View {
        BindingViewExamplePreviewContainer_2()
            .preferredColorScheme(.dark)
    }
}
