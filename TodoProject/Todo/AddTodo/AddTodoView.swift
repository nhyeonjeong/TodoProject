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
    
//    override func configureView() {
//        <#code#>
//    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }
//    
//    // 스토리보드로 할 때 실행되는 구문
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        //        configureView() // 스토리보드로 한다면 여기도 configureView호출
//        print("textfield required init")
//    }
}

