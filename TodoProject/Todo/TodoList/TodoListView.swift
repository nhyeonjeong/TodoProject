//
//  ClassifyView.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import UIKit
import SnapKit

class TodoListView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        return view
    }()

    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }

}
