//
//  AddTodoViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit

class AddTodoViewController: BaseViewController {
    
    let mainView = AddTodoView()
    
    let todoCases = TodoList.allCases
    // subtitle을 모아놓은 리스트
    lazy var todoSubTItles: [String] = {
        var array: [String] = []
        todoCases.forEach { _ in
            array.append("")
        }
        return array
    }()
    
    override func loadView() {
        view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "새로운 할 일"
        
        // notificationCenter로 값 전달
        NotificationCenter.default.addObserver(self, selector: #selector(addTodoNotification), name: Notification.Name("AddTodo"), object: nil)

        mainView.backgroundColor = Constants.Color.addViewBackgroundColor // 검은색보다 좀 더 연한 색
        configureTableVeiw()
    }

    override func configureView() {
        
        settingBarButton()
     
    }
    
    // 값이 들어오면?
    @objc
    func addTodoNotification(notification: NSNotification) {
        if let value = notification.userInfo?[TodoList.tag.todoListString] as? String {
            print(#function, "value")
            todoSubTItles[2] = value
        }
        if let value = notification.userInfo?[TodoList.priority.todoListString] as? String {
            todoSubTItles[3] = value
        }
        
        mainView.tableView.reloadRows(at: [IndexPath(row: 2, section: 0), IndexPath(row: 3, section: 0)], with: .fade)
    }
    
    @objc
    func addButtonClicked() {
        dismiss(animated: true)

    }
    
    @objc
    func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
}

extension AddTodoViewController {
    func settingBarButton() {
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        
        navigationItem.rightBarButtonItem = addButton
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = cancelButton
    }
}

extension AddTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableVeiw() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 제목,메모 있는 셀만 다른 셀 사용
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTodoMemoTableViewCell.identifier, for: indexPath) as? AddTodoMemoTableViewCell else {
                
                print(#function, "AddTodoMemoTableViewCell 타입캐스팅 실패")
                return UITableViewCell()
            }
            let titleList = todoCases[indexPath.row].tableViewCellTitle
            cell.configureCell(titleList: titleList)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTodoTableViewCell.identifier, for: indexPath) as? AddTodoTableViewCell else {
                
                print(#function, "AddTodoTableViewCell 타입캐스팅 실패")
                return UITableViewCell()
            }
            let titleList = todoCases[indexPath.row].tableViewCellTitle
            cell.configureCell(titleList: titleList, subtitle: todoSubTItles[indexPath.row])
            
            return cell
        }
        
    }
//
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
//        let viewCon = todoCases[row].pushViewCon
//        let vc = viewCon()
//        vc.data = {
//            
//        }
        
        switch todoCases[row] {
        case .deadline:
            let vc = DateViewController()
            vc.date = { value in
                self.todoSubTItles[row] = value
                tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .fade)
            }
            navigationController?.pushViewController(vc, animated: true)

        case .tag:
            let vc = TagViewController()

            navigationController?.pushViewController(vc, animated: true)

        case .priority:
            let vc = PriorityViewController()

            navigationController?.pushViewController(vc, animated: true)

        default:
            print("안넘어가요!")
        }
        
    }
    
}
