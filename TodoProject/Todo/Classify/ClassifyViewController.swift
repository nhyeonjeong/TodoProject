//
//  TodoViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit
import RealmSwift

class ClassifyViewController: BaseViewController {
    
    let todoRepository = TodoTableRepository()
    let listRepository = ListTableRepository()
    
    var classifyList: Results<TodoTable>!
    var list: Results<ListTable>!
    
    let customAddButton = AddTodoButtonView()
    var addTodoButton = UIBarButtonItem()
    
//    lazy var addButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(addTodoButtonClicked))
    var addListButton = UIBarButtonItem()
    
    let mainView = ClassifyView()
    
    let classifyCases = TodoClassify.allCases
    var memoCountList = [0,0,0,0,nil] // 컬렉션뷰에 나올 각 박스에 갯수
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = Constants.Color.backgroundColor

        configureTableView()
//        configureCollectionView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // read
        list = listRepository.fetch()
        classifyList = todoRepository.fetch()
        // 오늘자 메모
        memoCountList[TodoClassify.today.rawValue] = classifyList.filter({ data in
            let start = Calendar.current.startOfDay(for: Date())
            let end = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
            
            if data.regDate >= start && data.regDate < end {
                return true
            } else { return false }
        }).count
        // 예정된 메모
        memoCountList[TodoClassify.expected.rawValue] = classifyList.filter({ data in
            let today = Calendar.current.startOfDay(for: Date())
            let tommorrow = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? Date()
            
            if data.regDate >= tommorrow {
                return true
            } else { return false }
        }).count
        
        memoCountList[TodoClassify.entire.rawValue] = classifyList.count // 전체 리스트 갯수 업데이트
        memoCountList[TodoClassify.completed.rawValue] = classifyList.filter({ data in
            data.isComplete // 완료된 데이터의 수
        }).count
        mainView.tableView.reloadData()
    }
    
    @objc
    func rightBarButtonItemClicked() {
        
    }
    
    @objc
    func addTodoButtonClicked() {
        let vc = AddTodoViewController()
        let nav = UINavigationController(rootViewController: vc)
        // 전체 메모 갯수 갱신
        vc.memoCount = { value in
            
            self.memoCountList[TodoClassify.entire.rawValue] = value
            self.mainView.tableView.reloadData()
            
        }
        present(nav, animated: true)
    }
    
    @objc // 목록 추가 버튼
    func addListButtonClicked() {
        let vc = AddListViewController()
//        vc.modalPresentationStyle = .fullScreen // 왜 fullscreen으로 탭제스쳐도 안먹고 배경색도 이상해지는지?
        vc.tableReload = {
            self.list = self.listRepository.fetch()
            self.mainView.tableView.reloadData()
        }
        present(vc, animated: true)
    }
    
    override func configureView() {
        settingBarButton()
        settingToolBar()

    }
}

extension ClassifyViewController {
    func settingBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Constants.Image.eclipes, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
    }
    
    func settingToolBar() { // 커스텀뷰를 만들어야 이미지,텍스트가 같이 들어갈 수 있을 것이다.
        navigationController?.isToolbarHidden = false
        // 타이틀이나 이미지 둘 중에 하나만 된다.
//        addTodoButton = UIBarButtonItem(title: "새로운 할 일", image: UIImage(systemName: "plus.circle.fill"), target: self, action: #selector(addTodoButtonClicked))
        
        addTodoButton = UIBarButtonItem(customView: customAddButton)
        // event처리
        customAddButton.plusButton.addTarget(self, action: #selector(addTodoButtonClicked), for: .touchUpInside)
        addListButton = UIBarButtonItem(title: "목록 추가", image: nil, target: self, action: #selector(addListButtonClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        var items = [UIBarButtonItem]()

        [addTodoButton,flexibleSpace,addListButton].forEach {
            items.append($0)
        }
        self.toolbarItems = items
    }
}
extension ClassifyViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        mainView.tableView.register(ClassifyTableViewCell.self, forCellReuseIdentifier: ClassifyTableViewCell.identifier)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ClassifyTableViewCell.identifier, for: indexPath) as? ClassifyTableViewCell else {
                return UITableViewCell()
            }
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(ClassifyCollectionViewCell.self, forCellWithReuseIdentifier: ClassifyCollectionViewCell.identifier)
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configureCell(list[indexPath.row])
            return cell
        }
    }
    
    
}

extension ClassifyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classifyCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let entirecase = classifyCases[row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifyCollectionViewCell.identifier, for: indexPath) as? ClassifyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(image: entirecase.systemImage, imageTintColor: entirecase.systmeImageViewTint, titleString: entirecase.titleString, memoCount: memoCountList[row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 전체를 눌렀다면
        if classifyCases[indexPath.item] == TodoClassify.entire {
            let vc = TodoListViewController()
            vc.classifyText = classifyCases[indexPath.item].titleString
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
