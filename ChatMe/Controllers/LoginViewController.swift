//
//  LoginViewController.swift
//  ChatMe
//
//  Created by Coding on 5/23/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let threeBar: UIImageView = {
        let threeBar = UIImageView()
        threeBar.image = UIImage(systemName: "mount.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        
        return threeBar
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "SignUp"])
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = UIColor(hexString: themeColor)
        sc.backgroundColor = .white
        sc.setTitleTextAttributes(titleTextAttributes, for: .selected)
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        view.addSubview(threeBar)
        view.addSubview(segmentedControl)
    }
    
    override func viewDidLayoutSubviews() {
        let threeBarSize = view.width / 25
        let segmentedControlSize = view.width / 3
        threeBar.frame = CGRect(x: (view.width - threeBarSize) / 2,
                                 y: 5,
                                 width: threeBarSize,
                                 height: threeBarSize)
        
        segmentedControl.frame = CGRect(x: (view.width - segmentedControlSize) / 2,
                                        y: threeBar.bottom + 50,
                                        width: segmentedControlSize,
                                        height: 40)
    }
    

}
