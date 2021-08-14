//
//  InfoPopupView.swift
//  chmodutil (iOS)
//
//  Created by Mattia Righetti on 14/08/21.
//

import SwiftUI

struct InfoPopupView: View {
    var body: some View {
        VStack {
            Image("tap")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130)
                .padding(.top, 70)
                .padding(.bottom, 20)
            
            Text("Info")
                .font(.system(size: 30.0, weight: .semibold, design: .rounded))
                .padding(.bottom, 5)
            
            Text("Tap on letters to change permissions")
                .font(.system(size: 15.0, weight: .regular, design: .rounded))
            
            Spacer()
        }
        .frame(
            width: UIScreen.main.bounds.size.width - 30,
            height: UIScreen.main.bounds.size.width,
            alignment: .center
        )
        .background(
            Color("InfoPopupBackground")
        )
        .cornerRadius(15)
    }
}

struct InfoPopupView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPopupView()
    }
}
