//
//  ContentView.swift
//  WXYZr App
//
//  Created by Derek Cox II on 4/8/21.
//

import SwiftUI
import CoreNFC

struct ContentView: View {
    @State private var isShowing = false
    
    var body: some View {
        let drag = DragGesture().onEnded { event in
              // starts at left-hand side and is horizontal with a min length
              if event.location.x < 400 && abs(event.translation.height) < 150 && abs(event.translation.width) > 150 {
                withAnimation(.spring()) {
                  // Open if the drag was left-to-right, close if it was right-to-left
                    isShowing = event.translation.width > 0
                }
              }
            }
        
        NavigationView {
            ZStack {
                if isShowing{
                    SideMenuView()
                }
                HomeView().preferredColorScheme(.dark)
                    .disabled(self.isShowing ? true : false)
                    .offset(x: isShowing ? 175 : 0, y: 0)
                    .navigationBarItems(leading: Button(action: {
                        withAnimation(.spring()){
                            isShowing.toggle()
                        }
                    }, label: {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20.0, height:20)
                            .foregroundColor(.red)

                    }))
                    .navigationTitle("Tap-In")
                    .navigationBarTitleDisplayMode(.inline)
            }.gesture(drag)
//            .onTapGesture(perform: {
//                if isShowing == true{
//                    withAnimation(.spring()){
//                        isShowing.toggle()
//                    }
//                }
//            })

        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .padding()
    }
}

struct nfcButton : UIViewRepresentable {
    @Binding var data : String
    typealias UIViewType = UIButton
    
    func makeUIView(context: UIViewRepresentableContext<nfcButton>) -> UIButton {
        //let button:UIButton = UIButton(type: UIButton.ButtonType.custom)
        let button = UIButton()
            //button.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        //button.setTitle("Please work", for: .normal)
        button.setImage(UIImage(named: "scan"), for: UIControl.State.normal)
        //button.backgroundColor = UIColor.gray
        
        
        button.addTarget(context.coordinator, action: #selector(context.coordinator.beginScanning(_:)), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<nfcButton>) {
        // Do nothing
    }
    
    func makeCoordinator() -> nfcButton.Cordinator {
        return Cordinator(data: $data)
    }
    
    class Cordinator: UITableViewController, NFCNDEFReaderSessionDelegate{
        var session: NFCNDEFReaderSession?
        @Binding var data : String
        
        init(data: Binding<String>){
            _data = data
            super.init(nibName: nil, bundle: nil)
        }
        required init?(coder: NSCoder) {
                   fatalError("init(coder:) has not been implemented")
        }

        
        @IBAction func beginScanning(_ sender: Any) {
            guard NFCNDEFReaderSession.readingAvailable else {
                let alertController = UIAlertController(
                    title: "Scanning Not Supported",
                    message: "This device doesn't support tag scanning.",
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }

            session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
            session?.alertMessage = "Scanning..."
            session?.begin()
        }
        
        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            // Check the invalidation reason from the returned error.
            if let readerError = error as? NFCReaderError {
                // Show an alert when the invalidation reason is not because of a
                // successful read during a single-tag read session, or because the
                // user canceled a multiple-tag read session from the UI or
                // programmatically using the invalidate method call.
                if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                    && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                    print("Error NFC read: \(readerError.localizedDescription)")
                }
            }
        }
        
        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
            guard
                let nfcMess = messages.first,
                let record = nfcMess.records.first,
                record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
                let payload = String(data: record.payload, encoding: .utf8)
            else {
                session.alertMessage = "failure!"
                return
            }
            session.alertMessage = "Sucess!"
            //print(payload)
            self.data = payload
        }
        
        
    }
    
    
}
struct code {    
    // Read/Get Array of Strings
    static var links: [String] = UserDefaults.standard.stringArray(forKey: "myKey") ?? []
    
func convertLink(data: String) -> String {
    let header = "https://"
    var escapedString = data.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    
    //let trash = "%"
    //print(escapedString!)
    escapedString!.removeSubrange(escapedString!.startIndex..<escapedString!.index(escapedString!.startIndex, offsetBy: 3))
    
    //print(escapedString!)
    if escapedString!.contains("%"){
        escapedString! = escapedString!.replacingOccurrences(of: "%2F", with: "/")
    }

    let new = header.appending(escapedString!)
    //print(escapedString!)
    
    if let url = URL(string: new) {
            UIApplication.shared.open(url)
            //print(url)
    }
    // Append String to Array of Strings
    code.links.insert(new, at: 0)

    // Write/Set Array of Strings
    UserDefaults.standard.set(code.links, forKey: "myKey")

    
    return new
}
}

struct HomeView: View {
    @State public var data = ""
    var header = "https://"

    var body: some View {
        ZStack {
            Color(.black)
            VStack {
                Image("Unknown").padding(.top, 30).padding(.bottom, 75)
                Spacer()
                nfcButton(data: $data)
                if data != ""{
                    let i = code().convertLink(data: data)
                    Text("\(i)").foregroundColor(.black)
                }
//                Button(action: {
//                   // print("\(code().links[1])")
////                    if let url = URL(string: data) {
////                            UIApplication.shared.open(url)
////                            print(url)
//                   // }
//
//                }, label: {
//                    Text("\(data)").foregroundColor(.green)
//                })
                //Spacer()
                Text("Tap Button to scan a tag")
                    .padding(.top, 115).padding(.bottom, 5).foregroundColor(Color.red).font(.title)
            }

        }

    }
}
