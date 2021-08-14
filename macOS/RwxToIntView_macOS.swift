//
//  RwxToIntView_macOS.swift
//  chmodutil (macOS)
//
//  Created by Mattia Righetti on 14/08/21.
//

import SwiftUI

struct RwxToIntView_macOS: View {
    @State var rwx: [[Character?]] = [
        ["r", "w", "x"],
        ["r", nil, "x"],
        ["r", nil, "x"]
    ]
    @State var presentAlert: Bool = false
    var int: Int? { totalRwxToInt(chars: rwx) }
    
    var body: some View {
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
                Text("User")
                Spacer()
                Text("Group")
                Spacer()
                Text("Others")
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
            .padding(.top, 5)
            .padding([.leading, .trailing, .bottom], 15)
        }
        .frame(minWidth: 100, minHeight: 150)
        .navigationTitle("Permissions")
    }
}

struct RwxToIntView_macOS_Previews: PreviewProvider {
    static var previews: some View {
        RwxToIntView_macOS()
    }
}
