//
//  ViewController.swift
//  todo-app-swift-programmatically
//
//  Created by Soultan Muhammad Albar on 01/06/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var myArray: [Todo] = []
    private var selectedTodos: [Todo] = [] {
        didSet {
            if selectedTodos.count > 0 {
               btnStack.insertArrangedSubview(btnDone, at: 0)
            } else {
               btnStack.removeFully(view: btnDone)
            }
        }
    }
    private let viewModel = TodoViewModel()
    private var tableView: UITableView!
    
    private lazy var btnAdd: UIButton = {
        var btnAddView = UIButton.filledButton("Add")
        btnAddView.translatesAutoresizingMaskIntoConstraints = false
        btnAddView.addTarget(self, action: #selector(addTodo), for: .touchUpInside)
        
        return btnAddView
    }()
    
    private lazy var btnEdit: UIButton = {
        var btnEditView = UIButton.outlineButton("Edit")
        btnEditView.translatesAutoresizingMaskIntoConstraints = false
        btnEditView.addTarget(self, action: #selector(editTodo), for: .touchUpInside)
        
        return btnEditView
    }()
    
    private lazy var btnDone: UIButton = {
        var btnDoneView = UIButton.filledButton("DONE!!")
        btnDoneView.translatesAutoresizingMaskIntoConstraints = false
        btnDoneView.addTarget(self, action: #selector(doneTodo), for: .touchUpInside)
        
        return btnDoneView
    }()
    
    lazy var btnStack: UIStackView = {
        
        let btnStackView = UIStackView(arrangedSubviews: [btnAdd, btnEdit])
        btnStackView.translatesAutoresizingMaskIntoConstraints = false
        btnStackView.axis = .horizontal
        btnStackView.spacing = 8
        let allBtnStackView = UIStackView(arrangedSubviews: [btnStackView])
        allBtnStackView.translatesAutoresizingMaskIntoConstraints = false
        allBtnStackView.axis = .vertical
        allBtnStackView.spacing = 8
        
        return allBtnStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupBinders()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "load"), object: nil)
        _ = viewModel.getTodos()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func reloadTable() {
        let newTodos = viewModel.getTodos()
        myArray = newTodos
        tableView.reloadData()
    }
    
    @objc private func addTodo() {
        let myVc = AddTodoViewController()
        if let sheet = myVc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(myVc, animated: true)
    }
    
    @objc private func editTodo() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if !tableView.isEditing {
            selectedTodos = []
        }
        UIView.animate(withDuration: 0.5) {
            self.tableView.layoutIfNeeded()
        }
    }
    
    @objc private func doneTodo() {
        DispatchQueue.main.async {
            let arr: [Todo] = self.myArray.filter { todoParam in
                !self.selectedTodos.contains { selectedTodo in
                    selectedTodo.date == todoParam.date
                }
            }
            self.viewModel.updateTodo(todosParam: arr)
            self.selectedTodos = []
            self.tableView.setEditing(false, animated: true)
            self.reloadTable()
            UIView.animate(withDuration: 0.5) {
                self.tableView.layoutIfNeeded()
            }

        }
    }
    
    private func setupBinders() {
        viewModel.todos.bind{[weak self] results in
            self?.myArray = results!
            self?.tableView.reloadData()
        }
    }
    
    func setupView() {   let navbar = NavbarViewController.shared.getNavigationBar()
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CellTodosTableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        
        view.addSubview(navbar)
        view.addSubview(tableView)
        view.addSubview(btnAdd)
        view.addSubview(btnStack)
        
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navbar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            navbar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: navbar.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: btnStack.topAnchor, constant: -16),
            btnStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            btnStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            btnStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
    
    func onSelect(isSelected: Bool, todo: Todo) {
        if isSelected {
            selectedTodos.append(todo)
        } else {
            selectedTodos = selectedTodos.filter({ todoParams in
                todoParams.name != todo.name
            })
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.backgroundColor = .white
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! CellTodosTableViewCell
        cell.selectionStyle = .none
        let currentItem = myArray[indexPath.row]
        cell.todo = currentItem
        cell.onChecked = onSelect
        cell.backgroundColor = .white
        
        return cell
    }
    
}


