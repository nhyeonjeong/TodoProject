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
    let listRepository = ListTableRepository()
    
    var list: Results<ListTable>!
    
    let mainView = AddTodoView()
    // classifyVC으로 넘겨줄 memo갯수
    var memoCount: ((Int) -> Void)?
    
    var todoCases = TodoList.allCases
    var memoTitle: String = ""
    var memo: String = ""
    // 마감일을 Date타입으로 받아온 것
    var deadlineDate = Date()
    // tag 따로 저장
    var tagString: String?
    // Priority를 Int타입으로 저장한 것
    var priorityInt = 0
    /// 선택된 이미지
    var selectedImage = UIImage()
    // 선택된 목록
    var selectedListIdx = 0
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
        list = listRepository.fetch()
        todoSubTItles[5] = list[selectedListIdx].listTitle
        
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
        // 이게 맞나...ㅋㄹㅋㅎ 값을 다른 변수처럼 빼줄 수 없었우무
        // cellForRowAt 밖에서 cell을 가져오면 좋지 않음
//        guard let cell = mainView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddTodoMemoTableViewCell else {
//            return
//        }
        
        
        // 만약 제목이 비어있으면 토스트
        if memoTitle == "" {
            view.makeToast("제목을 입력해주세요", duration: 1.0, position: .top)
        } else {
            // 만약 tagString이 비어있다면 nil로 저장되도록
            if tagString == "" {
                tagString = nil
            }
            // record에 들어갈 내용 구성
            let data = TodoTable(memoTitle: memoTitle, memo: memo, deadline: deadlineDate, tag: tagString, priority: priorityInt)
            
            // realm에 추가
            listRepository.createdTodo(data, listIdx: selectedListIdx)
            // 이미지 document아래에 저장
            saveImageToDocument(image: selectedImage, filename: "\(data.id)")
            // 할 일 숫자 갱신
            guard let memoCount else { return }
            memoCount(repository.fetch().count)
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
            
            cell.memoTextView.delegate = self
            cell.titleTextField.delegate = self
            
            let titleList = todoCases[indexPath.row].tableViewCellTitle
            cell.configureCell(titleList: titleList)
            return cell
        } else if indexPath.row == 4 { // 이미지
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTodoImageTableViewCell.identifier, for: indexPath) as? AddTodoImageTableViewCell else {
                
                print(#function, "AddTodoImageTableViewCell 타입캐스팅 실패")
                return UITableViewCell()
            }
            let titleList = todoCases[indexPath.row].tableViewCellTitle
            cell.configureCell(titleList: titleList, selectedImage: selectedImage)
            
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
        case .addImage:
            // 갤러리 접근
            let vc = UIImagePickerController()
            vc.delegate = self // 프로토콜 채택한 뒤
            present(vc, animated: true)
        case .list:
            let vc = SelectListViewController()
            vc.selectedListIdx = { value in
                self.selectedListIdx = value
                self.todoSubTItles[indexPath.row] = self.list[value].listTitle
                tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .fade)
            }
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("안넘아가용")
        }
    }
}
extension AddTodoViewController: UITextFieldDelegate, UITextViewDelegate {
    // textView, textfield 실시간으로 string바뀔 떄마다
    func textViewDidChange(_ textView: UITextView) {
        memo = textView.text!
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        memoTitle = textField.text!
    }
}
extension AddTodoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)

        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = pickedImage
            mainView.tableView.reloadRows(at: [IndexPath(item: 4, section: 0)], with: .fade)
        }// 선택한 사진(여러 InfoKey가 있다)
        
        dismiss(animated: true)
    }
}


