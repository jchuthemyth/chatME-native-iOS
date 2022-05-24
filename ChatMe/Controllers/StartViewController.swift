//
//  StartViewController.swift
//  ChatMe
//
//  Created by Coding on 5/23/22.
//

import UIKit

class StartViewController: UIViewController {
    
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.backgroundColor = UIColor(hexString: themeColor)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        startButton.addTarget(self,
                              action: #selector(startButtonTapped),
                              for: .touchUpInside)
        
        //add subview
        view.addSubview(logoImage)
        view.addSubview(startButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let logoSize = view.width / 2
        let buttonWidth = view.width - 60
        logoImage.frame = CGRect(x: (view.width - logoSize) / 2,
                                 y: view.height / 5,
                                 width: logoSize,
                                 height: logoSize)
        startButton.frame = CGRect(x: (view.width - buttonWidth) / 2,
                                   y: logoImage.bottom + 90,
                                   width: buttonWidth,
                                   height: 50)
    }
    
    @objc private func startButtonTapped() {
        let vc = LoginViewController()
        present(vc, animated: true, completion: nil)
    }

}
