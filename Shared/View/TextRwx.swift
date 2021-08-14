//
//  TextRwx.swift
//  chmodutil
//
//  Created by Mattia Righetti on 14/08/21.
//

import SwiftUI

struct TextRwx: View {
    @Binding var rwx: [Character?]
    
    var body: some View {
        HStack {
            Spacer()
            Text("\(String(rwx[0] ?? "-"))")
                .padding(.vertical, 15)
                .font(.system(size: 20.0, weight: .bold, design: .monospaced))
                .onTapGesture(perform: {
                    if rwx[0] == nil {
                        rwx[0] = "r"
                    } else {
                        rwx[0] = nil
                    }
                })
            Spacer()
            Text("\(String(rwx[1] ?? "-"))")
                .padding(.vertical, 15)
                .font(.system(size: 20.0, weight: .bold, design: .monospaced))
                .onTapGesture(perform: {
                    if rwx[1] == nil {
                        rwx[1] = "w"
                    } else {
                        rwx[1] = nil
                    }
                })
            Spacer()
            Text("\(String(rwx[2] ?? "-"))")
                .padding(.vertical, 15)
                .font(.system(size: 20.0, weight: .bold, design: .monospaced))
                .onTapGesture(perform: {
                    if rwx[2] == nil {
                        rwx[2] = "x"
                    } else {
                        rwx[2] = nil
                    }
                })
            Spacer()
        }
    }
    
    private func updateLetter(char: Character) {
        
    }
}

struct TextRwx_Previews: PreviewProvider {
    static var previews: some View {
        TextRwx(rwx: .constant([nil, nil, nil]))
    }
}
