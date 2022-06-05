//
//  AddTodoViewController.swift
//  todo-app-swift-programmatically
//
//  Created by Soultan Muhammad Albar on 03/06/22.
//

import UIKit

class AddTodoViewController: UIViewController, UITextFieldDelegate {
    
    private var viewModel = TodoViewModel()
    
    private lazy var addTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(string: "Enter your todo title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 4
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.rightViewMode = .always
        textField.textColor = .black
        
        return textField
    }()
    
    private lazy var submitBtn: UIButton = {
        let submitBtnView = UIButton.filledButton("Submit")
        submitBtnView.translatesAutoresizingMaskIntoConstraints = false
        submitBtnView.addTarget(self, action: #selector(onSubmit), for: .touchUpInside)
        
        return submitBtnView
    }()
    
    private func setupView() {
        view.addSubview(addTextField)
        view.addSubview(submitBtn)
        
        NSLayoutConstraint.activate([
            addTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            addTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            addTextField.heightAnchor.constraint(equalToConstant: 40),
            submitBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            submitBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            submitBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    @objc private func onSubmit() {
        if addTextField.text != "" {
            self.viewModel.addTodo(title: addTextField.text! , date: Date.now)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            dismiss(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        addTextField.delegate = self
        setupView()
    }

}
