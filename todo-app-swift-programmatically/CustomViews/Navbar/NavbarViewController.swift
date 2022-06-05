//
//  NavbarViewController.swift
//  todo-app-swift-programmatically
//
//  Created by Soultan Muhammad Albar on 01/06/22.
//

import UIKit

class NavbarViewController: UIViewController {
    
    static var shared = NavbarViewController()
    
    lazy var rightBar: UILabel = {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayString = dateFormatter.string(from: date).uppercased()
        return UILabel.myFont("\(dayString)", fontFamily: fontFamilyList.medium, fontSize: 16)
    }()
    
    lazy var leftBar: UIStackView = {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: date).prefix(3).uppercased()
        dateFormatter.dateFormat = "YYYY"
        let yearString = dateFormatter.string(from: date)
        
        
        let monthLabel = UILabel.myFont("\(monthString)", fontFamily: fontFamilyList.bold, fontSize: 12)
        let yearLabel = UILabel.myFont("\(yearString)", fontFamily: fontFamilyList.normal, fontSize: 12)
        let leftBarRightView = UIStackView(arrangedSubviews: [UILabel.myFont(" ", fontFamily: fontFamilyList.normal, fontSize: 2), monthLabel, yearLabel])
        leftBarRightView.axis = .vertical
        leftBarRightView.distribution = .equalSpacing

        dateFormatter.dateFormat = "d"
        let dateString = dateFormatter.string(from: date)
        
        let dateLabel = UILabel.myFont("\(dateString)", fontFamily: .bold, fontSize: 36)
        let leftBarContainerView = UIStackView(arrangedSubviews: [dateLabel, leftBarRightView])
        leftBarContainerView.alignment = .center
        leftBarContainerView.axis = .horizontal
        leftBarContainerView.spacing = 8
        
        return leftBarContainerView
    }()
    
    public func getNavigationBar() -> UINavigationBar {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        navBar.translatesAutoresizingMaskIntoConstraints = false
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().shadowImage = UIImage()
        
        let navItem = UINavigationItem()
        let rightBarView = UIBarButtonItem(customView: rightBar)
        let leftBarView = UIBarButtonItem(customView: leftBar)
        
        navItem.rightBarButtonItem = rightBarView
        navItem.leftBarButtonItem = leftBarView
        navBar.setItems([navItem], animated: false)
        
        return navBar
//        customView.addSubview(navBar)
//
//        NSLayoutConstraint.activate([
//            navBar.topAnchor.constraint(equalTo: customView.safeAreaLayoutGuide.topAnchor, constant: 0),
//            navBar.leftAnchor.constraint(equalTo: customView.leftAnchor, constant: 0),
//            navBar.rightAnchor.constraint(equalTo: customView.rightAnchor, constant: 0)
//        ])
    }
    
}
