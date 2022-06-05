//
//  CellTodosTableViewCell.swift
//  todo-app-swift-programmatically
//
//  Created by Soultan Muhammad Albar on 01/06/22.
//

import UIKit

class CellTodosTableViewCell: UITableViewCell {
    
    var checked: Bool = false
    var onChecked: ((_ isChecked: Bool, _ todoParam: Todo) -> Void)?
    
    var todo: Todo? {
        didSet{
            titleLabel.text = todo?.name
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabelView = UILabel.myFont("", fontFamily: fontFamilyList.medium, fontSize: 16)
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        titleLabelView.numberOfLines = 0
        
        return titleLabelView
    }()
    
    private lazy var btnSelect: UIButton = {
        let btnSelectView = UIButton()
        btnSelectView.translatesAutoresizingMaskIntoConstraints = false
        btnSelectView.addTarget(self, action: #selector(handleTodoSelect), for: .touchUpInside)
        btnSelectView.setImage(UIImage(systemName: "circle"), for: .normal)

        
        return btnSelectView
    }()
    
    private lazy var cellStack: UIStackView = {
        let cellStackView = UIStackView(arrangedSubviews: [titleLabel])
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        cellStackView.axis = .horizontal
        cellStackView.spacing = 20
        cellStackView.isUserInteractionEnabled = true
        
        return cellStackView
    }()
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            cellStack.addArrangedSubview(btnSelect)
        } else {
            cellStack.removeFully(view: btnSelect)
            checked = false
            btnSelect.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    @objc private func handleTodoSelect() {
        DispatchQueue.main.async {
            self.btnSelect.setImage(UIImage(systemName: self.checked ? "circle": "checkmark.circle"), for: .normal)
            self.checked = !self.checked
            if self.onChecked != nil {
                self.onChecked!(self.checked, self.todo!)
            }
        }
       
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(btnSelect)
        btnSelect.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addSubview(cellStack)
        
        NSLayoutConstraint.activate([
            cellStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            cellStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            cellStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cellStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
