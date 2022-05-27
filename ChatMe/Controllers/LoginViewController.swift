//
//  LoginViewController.swift
//  ChatMe
//
//  Created by Coding on 5/23/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let countries = ["USA", "UK", "Canada", "Japan", "Korea"]
    
    var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = UIColor(hexString: themeColor)
        pv.setValue(UIColor.white, forKey: "textColor")
        return pv
    }()
    
    private let threeBar: UIImageView = {
        let threeBar = UIImageView()
        threeBar.image = UIImage(systemName: "mount.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        
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
    
    private let profileImage: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(systemName: "person.circle.fill")?.withTintColor(UIColor(hexString: themeColor), renderingMode: .alwaysOriginal)
        profile.layer.masksToBounds = true
        profile.contentMode = .scaleAspectFit
        return profile
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.clipsToBounds = true
        return sv
    }()
    
    private let emailTextField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        return field
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Confirm your password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        field.isHidden = true
        return field
    }()
    
    private let countryTextField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .done
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Select your country"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        field.isHidden = true
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(hexString: themeColor)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(hexString: themeColor)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.isHidden = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.frame.size.height = 150
        
        pickerView.dataSource = self
        pickerView.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        countryTextField.delegate = self
        
        view.addSubview(threeBar)
        view.addSubview(segmentedControl)
        view.addSubview(scrollView)
        scrollView.addSubview(profileImage)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(confirmPasswordTextField)
        scrollView.addSubview(countryTextField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(signupButton)
        countryTextField.inputView = pickerView
        
        let profileImageGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImage.addGestureRecognizer(profileImageGesture)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlSlides(_:)), for: .valueChanged)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        let threeBarSize = view.width / 25
        let segmentedControlSize = view.width / 3
        let textfieldSize = scrollView.width - 60
        let profileImageSize = scrollView.width / 3
        threeBar.frame = CGRect(x: (view.width - threeBarSize) / 2,
                                 y: 5,
                                 width: threeBarSize,
                                 height: threeBarSize)
        
        segmentedControl.frame = CGRect(x: (view.width - segmentedControlSize) / 2,
                                        y: threeBar.bottom + 50,
                                        width: segmentedControlSize,
                                        height: 40)
        scrollView.frame = CGRect(x: 0,
                                  y: segmentedControl.bottom + 20,
                                  width: view.width,
                                  height: view.height - (segmentedControl.bottom + 20))
        profileImage.frame = CGRect(x: (scrollView.width - profileImageSize) / 2,
                                      y: scrollView.height / 20,
                                      width: profileImageSize,
                                      height: profileImageSize)
        profileImage.layer.cornerRadius = profileImage.width / 2
        emailTextField.frame = CGRect(x: (scrollView.width - textfieldSize) / 2,
                                      y: profileImage.bottom + 40,
                                        width: textfieldSize,
                                        height: 50)
        passwordTextField.frame = CGRect(x: (scrollView.width - textfieldSize) / 2,
                                      y: emailTextField.bottom + 15,
                                        width: textfieldSize,
                                        height: 50)
        confirmPasswordTextField.frame = CGRect(x: (scrollView.width - textfieldSize) / 2,
                                      y: passwordTextField.bottom + 15,
                                        width: textfieldSize,
                                        height: 50)
        countryTextField.frame = CGRect(x: (scrollView.width - textfieldSize) / 2,
                                      y: confirmPasswordTextField.bottom + 15,
                                        width: textfieldSize,
                                        height: 50)
        loginButton.frame = CGRect(x: (scrollView.width - textfieldSize) / 2,
                                      y: passwordTextField.bottom + 100,
                                        width: textfieldSize,
                                        height: 50)
        signupButton.frame = CGRect(x: (scrollView.width - textfieldSize) / 2,
                                      y: countryTextField.bottom + 50,
                                        width: textfieldSize,
                                        height: 50)
        pickerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: 300)
        
    }
    
    @objc private func profileImageTapped() {
        presentPhotoActionSheet()
    }
    
    @objc private func loginButtonTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, let password = passwordTextField.text,
              !email.isEmpty, !password.isEmpty else {
                  alertPopUp(title: "Alert",
                             message: "Please enter email/password")
                  return
              }
        //Firebase Login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            guard authResult != nil, error == nil else {
                strongSelf.alertPopUp(title: "Alert", message: "Unable to login")
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.dismiss(animated: true, completion: nil)
                strongSelf.presentingViewController?.dismiss(animated: false)
            }

        })
    }
    
    @objc private func signupButtonTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, let country = countryTextField.text, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, !country.isEmpty else {
            alertPopUp(title: "Alert",
                       message: "Please fill up all the information")
            return
        }
        
        guard let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, password == confirmPassword else {
            alertPopUp(title: "Alert",
                       message: "Please match your passwords")
            return
        }
        
        // Firebase SignUp
        DatabaseManager.userInfo.isUserExist(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else {
                return
            }
            
            guard !exists else {
                strongSelf.alertPopUp(title: "Alert", message: "User Exist")
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in

                guard authResult != nil, error == nil else {
                    strongSelf.alertPopUp(title: "Alert", message: "Can't SignUp")
                    return
                }
                
                DatabaseManager.userInfo.createUserInDatabase(with: ChatMeUser(emailAddress: email, country: country))
                
                DispatchQueue.main.async {
                    strongSelf.dismiss(animated: true, completion: nil)
                    strongSelf.presentingViewController?.dismiss(animated: false)
                }
            })
        })
    }
    
    @objc private func segmentedControlSlides(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {
        case 1:
            profileImage.isUserInteractionEnabled = true
            profileImage.image = UIImage(systemName: "person.crop.circle.badge.plus")?.withTintColor(UIColor(hexString: themeColor), renderingMode: .alwaysOriginal)
            setAnimationForView(view: profileImage, hidden: false, option: .transitionFlipFromLeft)
            setAnimationForView(view: emailTextField, hidden: false, option: .transitionFlipFromBottom)
            setAnimationForView(view: passwordTextField, hidden: false, option: .transitionFlipFromBottom)
            setAnimationForView(view: confirmPasswordTextField, hidden: false, option: .transitionFlipFromBottom)
            setAnimationForView(view: countryTextField, hidden: false, option: .transitionFlipFromBottom)
            setAnimationForView(view: signupButton, hidden: false, option: .transitionFlipFromBottom)
            loginButton.isHidden = true
            emailTextField.text = ""
            passwordTextField.text = ""
            confirmPasswordTextField.text = ""
            countryTextField.text = ""
        default:
            profileImage.isUserInteractionEnabled = false
            profileImage.image = UIImage(systemName: "person.circle.fill")?.withTintColor(UIColor(hexString: themeColor), renderingMode: .alwaysOriginal)
            confirmPasswordTextField.isHidden = true
            countryTextField.isHidden = true
            signupButton.isHidden = true
            setAnimationForView(view: profileImage, hidden: false, option: .transitionFlipFromRight)
            setAnimationForView(view: emailTextField, hidden: false, option: .transitionFlipFromBottom)
            setAnimationForView(view: passwordTextField, hidden: false, option: .transitionFlipFromBottom)
            setAnimationForView(view: loginButton, hidden: false, option: .transitionFlipFromBottom)
            emailTextField.text = ""
            passwordTextField.text = ""

        }
    }
}

extension LoginViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextField.text = countries[row]
        countryTextField.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func loginReturn(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            loginButtonTapped()
        default:
            alertPopUp(title: "Alert", message: "Unexpected")
        }
    }
    
    func signupReturn(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        case confirmPasswordTextField:
            countryTextField.becomeFirstResponder()
        case countryTextField:
            signupButtonTapped()
        default:
            alertPopUp(title: "Alert", message: "Unexpected")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            loginReturn(textField)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            signupReturn(textField)
        }
        return true
    }
}

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionBox = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionBox.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionBox.addAction(UIAlertAction(title: "Camera", style: .default, handler: {[weak self]_ in
            self?.presentCamera()
        }))
        actionBox.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {[weak self]_ in
            self?.presentPhotoAlbum()
        }))
        present(actionBox, animated: true, completion: nil)
    }
    
    func presentCamera() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func presentPhotoAlbum() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let selectedImage = info[UIImagePickerController.InfoKey.editedImage]
        guard let castedImage = selectedImage as? UIImage else{
            return
        }
        self.profileImage.image = castedImage
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
