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

    case body // 17pt, Regular
    case bodyBold // 17pt, Bold
    case bodyMedium // 17pt, Medium

    case bodySmall // 16pt, Regular
    case bodySmallMedium // 16pt, Medium
    
    case tabSmall // 12pt, Regular
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
        case .body:
            return FontDescription(font: .regular, size: 17)
        case .bodyBold:
            return FontDescription(font: .bold, size: 17)
        case .bodyMedium:
            return FontDescription(font: .medium, size: 17)
        case .bodySmall:
            return FontDescription(font: .regular, size: 16)
        case .bodySmallMedium:
            return FontDescription(font: .medium, size: 16)
        case .tabSmall:
            return FontDescription(font: .regular, size: 12)
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
