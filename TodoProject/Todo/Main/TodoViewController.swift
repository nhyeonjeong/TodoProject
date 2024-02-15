//
//  TodoViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit

class TodoViewController: BaseViewController {
    let customAddButton = AddTodoButtonView()
    var addTodoButton = UIBarButtonItem()
    
//    lazy var addButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(addTodoButtonClicked))
    var addListButton = UIBarButtonItem()
    
    let mainView = TodoView()
    
    let entireCases = EntireList.allCases
    var memoCountList = [0,1,0,0,nil] // 컬렉션뷰에 나올 각 박스에 갯수
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = Constants.Color.backgroundColor

        configureCollectionView()

    }
    
    @objc
    func rightBarButtonItemClicked() {
        
    }
    
    @objc
    func addTodoButtonClicked() {
        let vc = UINavigationController(rootViewController: AddTodoViewController())
        present(vc, animated: true)
        print(#function)
    }
    
    @objc
    func addListButtonClicked() {
        
    }
    
    override func configureView() {
        settingBarButton()
        settingToolBar()
        
//        customAddButton.addGestureRecognizer(addButtonTapGesture)
    }
}

extension TodoViewController {
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

extension TodoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entireCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let entirecase = entireCases[row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EntireBoxCollectionViewCell.identifier, for: indexPath) as? EntireBoxCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(image: entirecase.systemImage, imageTintColor: entirecase.systmeImageViewTint, titleString: entirecase.titleString, memoCount: memoCountList[row])
        return cell
    }
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(EntireBoxCollectionViewCell.self, forCellWithReuseIdentifier: EntireBoxCollectionViewCell.identifier)
    }
}
