//
//  ExtensionUITextField.swift
//  Remote
//
//  Created by Akapo Damilola Francis on 30/01/2017.
//  Copyright © 2017 CottaCush. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    class var tint: UIColor {
        return UIColor(red: 0.0, green: 56.0 / 255.0, blue: 131.0 / 255.0, alpha: 1.0)
    }
    
    class var abgAccessOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 130.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
