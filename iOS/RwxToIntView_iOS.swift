//
//  RwxToIntView.swift
//  chmodutil (iOS)
//
//  Created by Mattia Righetti on 14/08/21.
//

import SwiftUI
import PopupView

struct RwxToIntView_iOS: View {
    @State var rwx: [[Character?]] = [
        ["r", "w", "x"],
        ["r", nil, "x"],
        ["r", nil, "x"]
    ]
    @State var presentAlert: Bool = false
    @State var presentInfoModal: Bool = false
    var int: Int? { totalRwxToInt(chars: rwx) }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        if let int = int {
                            Text("\(int)")
                                .padding(.vertical, 15)
                                .padding(.horizontal, 15)
                                .font(.system(size: 50.0, weight: .bold, design: .monospaced))
                        } else {
                            Text("not valid")
                                .padding(.vertical, 15)
                                .padding(.horizontal, 15)
                                .font(.system(size: 20.0, weight: .bold, design: .monospaced))
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Text("user")
                        Spacer()
                        Text("group")
                        Spacer()
                        Text("others")
                        Spacer()
                    }
                    .font(.system(size: 15.0, weight: .semibold, design: .monospaced))
                    
                    HStack {
                        TextRwx(rwx: $rwx[0])
                        Divider().frame(height: 30)
                        TextRwx(rwx: $rwx[1])
                        Divider().frame(height: 30)
                        TextRwx(rwx: $rwx[2])
                    }
                    .background(
                        Color.gray.opacity(0.2)
                    )
                    .cornerRadius(5)
                    .padding()
                }
            }
            .popup(isPresented: $presentInfoModal) {
                InfoPopupView()
            }
            .navigationBarTitle("Permissions", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentInfoModal.toggle()
                }, label: {
                    Image(systemName: "info.circle")
                })
            )
        }
        .alert(isPresented: $presentAlert, content: {
            Alert(
                title: Text("Info"),
                message: Text("Tap on letters to change permissions"),
                dismissButton: .default(
                    Text("Dismiss"),
                    action: { self.presentAlert.toggle() }
                )
            )
        })
    }
}

struct RwxToIntView_Previews: PreviewProvider {
    static var previews: some View {
        RwxToIntView_iOS()
    }
}
