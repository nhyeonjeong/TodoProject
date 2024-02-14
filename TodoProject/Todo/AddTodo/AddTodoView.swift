//
//  AddTodoView.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit
import SnapKit

class AddTodoView: BaseView {
    
    let todoListCases = TodoList.allCases
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
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


extension AddTodoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 제목,메모 있는 셀만 다른 셀 사용
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTodoMemoTableViewCell.identifier, for: indexPath) as? AddTodoMemoTableViewCell else {
                
                print(#function, "AddTodoMemoTableViewCell 타입캐스팅 실패")
                return UITableViewCell()
            }
            let titleList = todoListCases[indexPath.row].tableViewCellTitle
            cell.configureCell(titleList: titleList)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTodoTableViewCell.identifier, for: indexPath) as? AddTodoTableViewCell else {
                
                print(#function, "AddTodoTableViewCell 타입캐스팅 실패")
                return UITableViewCell()
            }
            let titleList = todoListCases[indexPath.row].tableViewCellTitle
            cell.configureCell(titleList: titleList)
            
            return cell
        }
        
    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}
