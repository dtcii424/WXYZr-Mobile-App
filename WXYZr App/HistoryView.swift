//
//  HistoryView.swift
//  WXYZr App
//
//  Created by Derek Cox II on 4/9/21.
//

import SwiftUI

struct HistoryView: View {
    @Binding var isShow: Bool
    @State private var isShowing = false
    @State var listLinks = code.links
    @State var showGoAlert = false
    @State var showClearAlert = false
    @State var go: String = ""
    var body: some View{
        VStack(){
            HStack {
                Button(action: {
                    isShow.toggle()
                }, label: {
                    Text("X").bold().accentColor(.red).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }).padding()
            Spacer()
                Button(action: {
                    showClearAlert.toggle()
                }, label: {
                    Text("Clear All").bold().accentColor(.blue)
                }).padding(.trailing, 10)
                .alert(isPresented: $showClearAlert) {
                            Alert(
                                title: Text("Clear all History of Taps?"),
                                primaryButton: .destructive(Text("Clear")) {
                                    listLinks.removeAll()
                                    code.links.removeAll()
                                    UserDefaults.standard.set(code.links, forKey: "myKey")
                                    print("Deleting...")
                                },
                                secondaryButton: .cancel()
                            )
                }}
            Text("History").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Spacer()
            Spacer()
            if listLinks.isEmpty {
                Text("No Tap-In History")
            }else{ Text("")}
            NavigationView {
                List{
                ForEach(listLinks, id: \.self){ link in
                    Text(link).bold().gesture(TapGesture()
                    .onEnded({ _ in
                        go = link
                        showGoAlert.toggle()
                    })).alert(isPresented: $showGoAlert){ ()->Alert in
                        let okButton = Alert.Button.default(Text("Go")){
                            if let url = URL(string: go) {
                                UIApplication.shared.open(url)
                            }
                        }
                        let dismissButton = Alert.Button.default(Text("Cancel")){
                            print("dismiss")
                        }
                        return Alert(title: Text("Go to link?"), message: Text(go), primaryButton: dismissButton, secondaryButton: okButton)
                    }

                }.onDelete(perform: self.deleteItem)

                }
            }
        }
            
    }
    private func deleteItem(at indexSet: IndexSet) {
        listLinks.remove( atOffsets: indexSet)
        code.links.remove(atOffsets: indexSet)
        UserDefaults.standard.set(code.links, forKey: "myKey")
    }
}

struct BindingViewExamplePreviewContainer_1 : View {
     @State
     private var value = false

     var body: some View {
          HistoryView(isShow: $value)
     }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BindingViewExamplePreviewContainer_1()
            .preferredColorScheme(.dark)
    }
}
