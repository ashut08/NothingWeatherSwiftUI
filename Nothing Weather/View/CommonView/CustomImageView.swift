//
//  CustomImageView.swift
//  Nothing Weather
//
//  Created by mac on 08/03/25.
//

import SwiftUI
struct CustomImageView: View    {
    let imageName: String
      let width: CGFloat
      let height: CGFloat
    
    
    
    var body: some View {
        Image(imageName)
                   .resizable()
                   .frame(width: width, height: height)
                   .symbolRenderingMode(.palette)
                   .foregroundColor(.white)
    }
}
