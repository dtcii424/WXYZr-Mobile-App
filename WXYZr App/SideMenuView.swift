//
//  SideMenuView.swift
//  WXYZr App
//
//  Created by Derek Cox II on 4/8/21.
//

import SwiftUI

struct SideMenuView: View {
    //@State private var isShowing = false
    //@State private var isAb = false
    @State private var isShowing: [Bool] = [false, false, false, false]
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            HStack {
                VStack{
                    Spacer()
                    Button(action: {
                            isShowing[0].toggle()
                    }, label: {
                        Text("History")
                            .foregroundColor(.white).bold()
                    })
                    .fullScreenCover(isPresented: $isShowing[0], content: {
                        HistoryView(isShow: $isShowing[0])
                            .preferredColorScheme(.dark)
                    }).padding(40)

                    Button(action: {
                            isShowing[1].toggle()
                    }, label: {
                        Text("Troubleshoot")
                            .foregroundColor(.white).bold()
                    })
                    .fullScreenCover(isPresented: $isShowing[1], content: {
                        TroubleshootView(isShow: $isShowing[1])
                            .preferredColorScheme(.dark)
                    }).padding(40)
                     //Partners Button
                    Button(action: {
                        isShowing[2].toggle()
                    }, label: {
                        Text("Partners")
                            .foregroundColor(.white).bold()
                    })
                    .fullScreenCover(isPresented: $isShowing[2], content: {
                        PartnersView(isShow: $isShowing[2])
                            .preferredColorScheme(.dark)
                    }).padding(40)
                    // About Us Button
                    Button(action: {
                        isShowing[3].toggle()
                    }, label: {
                        Text("About Us")
                            .foregroundColor(.white).bold()
                    })
                    .fullScreenCover(isPresented: $isShowing[3], content: {
                        AboutUsView(isShow: $isShowing[3])
                            .preferredColorScheme(.dark)
                    }).padding(40)
                    Spacer()
                    //.frame(height: 240)
                    // Cell item
    //                ForEach(SideMenuViewModel.allCases, id: \.self) { option in
    //                    NavigationLink(
    //
    //                        destination: Text(option.title),
    //                        label: {
    //                            SideMenuOptionsView(viewModel: option)
    //                        })
    //                        .navigationTitle("Menu")
    //                }
                    //                .sheet(isPresented: $isShowing, content: {
                    //                    PartnersView(isShow: $isShowing)
                    //                })
                    
                    Spacer()
                        .navigationTitle("Menu")
                        .navigationBarTitleDisplayMode(.inline)
                }
                Spacer()
            }
        }//.navigationBarHidden(true)
    }
}

//struct PartnersView: View{
//    @Binding var isShow: Bool
//    var body: some View{
//        VStack{
//            Text("Partners View")
//            Button(action: {
//                isShow.toggle()
//            }, label: {
//                Text("X")
//            })
//        }
//    }
//}

//struct HistoryView: View {
//    @Binding var isShow: Bool
//    var body: some View{
//        VStack(){
//            HStack {
//                Button(action: {
//                    isShow.toggle()
//                }, label: {
//                    Text("X").bold().accentColor(.red).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//            }).padding()
//            Spacer()
//            }
//            Text("History").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//            Text("History of taps goes here").padding(100)
//            Spacer()
//                }
//    }
//}

//struct TroubleshootView: View {
//    @Binding var isShow: Bool
//    var body: some View{
//        VStack(){
//            HStack {
//                Button(action: {
//                    isShow.toggle()
//                }, label: {
//                    Text("X").bold().accentColor(.red).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//            }).padding()
//            Spacer()
//            }
//            Text("Troubleshoot").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//            Text("Troubleshooting documentation goes here").padding(100)
//            Spacer()
//                }
//    }
//}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
            .preferredColorScheme(.dark)
    }
}
