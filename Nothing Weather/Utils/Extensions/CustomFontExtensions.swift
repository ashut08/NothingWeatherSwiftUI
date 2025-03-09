//
//  CustomFontExtensions.swift
//  Nothing Weather
//
//  Created by mac on 09/03/25.
//

import SwiftUI

enum FontWeight {
    case light
    case regular
    case medium
    case semiBold
    case bold
    case black
}

extension Font {
    static let customFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .light:
            Font.custom("RobotoMono-Light", size: size)
        case .regular:
            Font.custom("RobotoMono-Regular", size: size)
        case .medium:
            Font.custom("RobotoMono-Medium", size: size)
        case .semiBold:
            Font.custom("RobotoMono-SemiBold", size: size)
        case .bold:
            Font.custom("RobotoMono-Bold", size: size)
        case .black:
            Font.custom("RobotoMono-Regular", size: size)
        }
    }
}

extension Text {
    func customFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.customFont(fontWeight ?? .regular, size ?? 16))
    }
}
