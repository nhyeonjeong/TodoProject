//
//  AddTodoViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit
import RealmSwift
import Toast

class AddTodoViewController: BaseViewController {
    let repository = TodoTableRepository()
    
    let mainView = AddTodoView()
    
    let todoCases = TodoList.allCases
    // 마감일을 Date타입으로 받아온 것
    var deadlineDate = Date()
    // tag 따로 저장
    var tagString = ""
    // Priority를 Int타입으로 저장한 것
    var priorityInt = 0
    
    // subtitle을 모아놓은 리스트
    lazy var todoSubTItles: [String] = {
        var array: [String] = []
        todoCases.forEach { _ in
            array.append("")
        }
        return array
    }()
    
    let format: DateFormatter = {
        let format = DateFormatter()
        //        format.dateFormat = "yyyy년 MM월 dd일"
        format.dateFormat = "yyyy.M.d"
        return format
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
            tagString = value
            todoSubTItles[2] = value
        }
        if let value = notification.userInfo?[TodoList.priority.todoListString] as? Int {
            priorityInt = value
            todoSubTItles[3] = "\(value)순위"
        }
        
        mainView.tableView.reloadRows(at: [IndexPath(row: 2, section: 0), IndexPath(row: 3, section: 0)], with: .fade)
    }
    
    @objc
    func addButtonClicked() { // 추가 버튼
        guard let cell = mainView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddTodoMemoTableViewCell else {
            return
        }
        
        // 만약 제목이 비어있으면 토스트
        if cell.titleTextField.text == "" {
            view.makeToast("제목을 입력해주세요", duration: 1.0, position: .top)
        } else {
            
            // record에 들어갈 내용 구성
            let data = TodoTable(memoTitle: cell.titleTextField.text!, memo: cell.memoTextView.text!, deadline: deadlineDate, tag: tagString, priority: priorityInt)
            
            // realm에 추가
            repository.createItem(data)
            
            dismiss(animated: true)
        }
    }
    
    @objc
    func cancelButtonClicked() { // 취소 버튼
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
            vc.date = { date in
                self.deadlineDate = date
                let result = self.format.string(from: date)

                self.todoSubTItles[row] = result
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


