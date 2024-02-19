//
//  AddTodoView.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit
import SnapKit

class AddTodoView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        
        view.register(AddTodoMemoTableViewCell.self, forCellReuseIdentifier: AddTodoMemoTableViewCell.identifier)
        view.register(AddTodoTableViewCell.self, forCellReuseIdentifier: AddTodoTableViewCell.identifier)
        view.backgroundColor = Constants.Color.addViewBackgroundColor
        return view
    }()

    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

