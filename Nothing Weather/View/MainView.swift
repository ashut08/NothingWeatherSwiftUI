//
//  MainView.swift
//  Nothing Weather
//
//  Created by mac on 09/03/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack{
            Text("Hello, SwiftUI!").customFont(.regular,12)
            Text("Hello, SwiftUI!").customFont(.bold,20)
            CustomImageView(imageName: "error",width: 100,height: 100)
        }
    }
}
