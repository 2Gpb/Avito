//
//  UIColor+.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

enum Color: String, CaseIterable {
    // Base Colors
    case base0 = "D2D2D2"
    case base5 = "C1C1C1"
    case base10 = "606060"
    case base20 = "545454"
    case base30 = "373737"
    case base40 = "262624"
    case base50 = "222222"
    case base60 = "1D1D1D"
    case base70 = "141414"
    case base80 = "0A0A0A"
    
    case description = "7F7F7F"
    // Accent colours
    case lightBlue = "01A9FF"
    case blue = "4A40FF"
}

extension UIColor {
    convenience init(hex: String) {
        let chars = Array(hex)
        
        let red = Self.charToInt(chars[0]) * 16 + Self.charToInt(chars[1])
        let green = Self.charToInt(chars[2]) * 16 + Self.charToInt(chars[3])
        let blue = Self.charToInt(chars[4]) * 16 + Self.charToInt(chars[5])
        
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    private static func charToInt(_ char: Character) -> Double {
        switch char.uppercased() {
        case "A":
            return 10
        case "B":
            return 11
        case "C":
            return 12
        case "D":
            return 13
        case "E":
            return 14
        case "F":
            return 15
        default:
            guard let result = Double(String(char)) else {
                assertionFailure("could not turn hex")
                return 0
            }
            return result
        }
    }
}


extension UIColor {
    convenience init(color: Color) {
        self.init(hex: color.rawValue)
    }
}
