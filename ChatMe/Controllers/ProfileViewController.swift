//
//  ProfileViewController.swift
//  ChatMe
//
//  Created by Coding on 5/26/22.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navItemConfig()
    }
    
    private func navItemConfig() {
        let button = UIButton(type: .custom)
        button.layer.frame = CGRect(x: 0.0, y: 0, width: 80, height: 20)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemRed
        button.setTitle("Logout", for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func logoutButtonTapped() {
        
        let alertBox = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertBox.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            do {
                try FirebaseAuth.Auth.auth().signOut()
                let vc = StartViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true, completion: nil)
            }
            catch {
                strongSelf.alertPopUp(title: "Alert", message: "Failed to logout")
            }
        }))
        alertBox.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertBox, animated: true, completion: nil)
    }
}
