//
//  UILabel+Extension.swift
//  todo-app-swift-programmatically
//
//  Created by Soultan Muhammad Albar on 05/06/22.
//

import UIKit

extension UILabel {
    private static func getMyFont(fontFamily: fontFamilyList) -> String {
        switch fontFamily {
        case .normal:
            return "CircularStd-Book"
        case .medium:
            return "CircularStd-Medium"
        case .bold:
            return "CircularStd-Bold"
        }
    }
    
    class func myFont(_ text: String, fontFamily: fontFamilyList?, fontSize: CGFloat?) -> UILabel {
        let myLabel = UILabel()
        myLabel.text = text
        myLabel.font = UIFont(name: getMyFont(fontFamily: fontFamily ?? .normal), size: fontSize ?? 12)
        myLabel.textColor = UIColor(named: "labelColor")
        
        return myLabel
    }
    
}
