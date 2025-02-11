//
//  as.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

enum Font: String {
    case regular = "SFProRounded-Regular"
    case medium = "SFProRounded-Medium"
    case bold = "SFProRounded-Bold"
    
    var name: String {
        return self.rawValue
    }
}

struct FontDescription {
    let font: Font
    let size: CGFloat
}

enum TextStyle {
    case priceLarge // 28pt, Bold
    case titleLarge // 22pt, Bold
    case productTitle // 20pt, Bold

    case bodySmall // 17pt, Regular
    case bodySmallBold // 17pt, Bold
    case bodySmallMedium // 17pt, Medium

    case body // 16pt, Regular
    case bodyMedium // 16pt, Medium
}

extension TextStyle {
    private var fontDescription: FontDescription {
        switch self {
        case .priceLarge:
            return FontDescription(font: .bold, size: 28)
        case .titleLarge:
            return FontDescription(font: .bold, size: 22)
        case .productTitle:
            return FontDescription(font: .bold, size: 20)
        case .bodySmall:
            return FontDescription(font: .regular, size: 17)
        case .bodySmallBold:
            return FontDescription(font: .bold, size: 17)
        case .bodySmallMedium:
            return FontDescription(font: .medium, size: 17)
        case .body:
            return FontDescription(font: .regular, size: 16)
        case .bodyMedium:
            return FontDescription(font: .medium, size: 16)
        }
    }
}

extension TextStyle {
    var font: UIFont {
        guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else {
            return UIFont()
        }
        
        return font
    }
}
