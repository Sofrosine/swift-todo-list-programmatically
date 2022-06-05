//
//  UIButton+Extension.swift
//  todo-app-swift-programmatically
//
//  Created by Soultan Muhammad Albar on 05/06/22.
//

import UIKit

extension UIButton {
    class func filledButton(_ btnTitle: String) -> UIButton {
        var btnConfiguration = UIButton.Configuration.filled()
        
        btnConfiguration.title = btnTitle
        btnConfiguration.attributedTitle?.font = UIFont(name: "CircularStd-Bold", size: 12)
        btnConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 32, bottom: 12, trailing: 32)
        btnConfiguration.baseForegroundColor = .white
        btnConfiguration.baseBackgroundColor = .orange
        
        let btn = UIButton(configuration: btnConfiguration, primaryAction: nil)
        btn.layer.cornerRadius = 8
        
        return btn
    }
    
    class func outlineButton(_ btnTitle: String) -> UIButton {
        var btnConfiguration = UIButton.Configuration.bordered()
        
        btnConfiguration.title = btnTitle
        btnConfiguration.attributedTitle?.font = UIFont(name: "CircularStd-Bold", size: 12)
        btnConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 32, bottom: 12, trailing: 32)
        btnConfiguration.baseForegroundColor = .orange
        btnConfiguration.baseBackgroundColor = .white
        
        let btn = UIButton(configuration: btnConfiguration, primaryAction: nil)
        btn.layer.borderColor = UIColor.orange.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        
        return btn
    }
}
