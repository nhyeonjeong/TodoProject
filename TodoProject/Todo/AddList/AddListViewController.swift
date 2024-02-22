//
//  AddListViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/21.
//

import UIKit

class AddListViewController: BaseViewController {

    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewClicked))
    
    let listColor = ListColor.allCases
    // 선택된 버튼의 인덱스
    lazy var selectedButtonIdx = listColor.endIndex // 마지막 다크그레이
    
    let backView = UIView()
    let label: UILabel = {
        let view = UILabel()
        view.text = "새로운 목록"
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()

    let titleTextField: UITextField = {
        let view = UITextField()
        view.font = Constants.Font.subtitle
        view.placeholder = "목록 제목 입력"
        return view
    }()
    
    let colorTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Font.subtitle
        view.text = "색상 선택"
        return view
    }()
    
    let okButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.setTitle("확인", for: .normal)
        view.setTitleColor(.white, for: .normal)
        return view
    }()

    lazy var colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        backView.backgroundColor = .darkGray
        //뷰에 탭제스쳐
        view.addGestureRecognizer(tapGesture)
        configureCollectionView()
    }
    // 화면 누르면 뷰 내려감
    @objc
    func viewClicked() {
        dismiss(animated: true)
    }
    
    // realm create (realm list)
    @objc
    func okButtonClicked() {
        if titleTextField.text == "" {
            
        }
        
        dismiss(animated: true)
    }
    
    // 색 버튼을 눌러서 색 설정
    @objc
    func selectColorButton(_ sender: UIButton) {
        // sender.tag
        selectedButtonIdx = sender.tag
        colorCollectionView.reloadData()
    }
    override func configureHierarchy() {
        view.addSubview(backView)
        backView.addSubview(label)
        backView.addSubview(titleTextField)
        backView.addSubview(colorTitleLabel)
        backView.addSubview(colorCollectionView)
        backView.addSubview(okButton)

    }
    
    override func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            // 높이 안해도 된다
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        label.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.height.equalTo(22)
            
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        colorTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(label.snp.leading)
            make.height.equalTo(20)
            make.top.equalTo(titleTextField.snp.bottom).offset(8)

        }
        colorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(colorTitleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(105)
//            make.bottom.equalToSuperview().inset(10)
        }
        okButton.snp.makeConstraints { make in
            make.top.equalTo(colorCollectionView.snp.bottom).offset(8)
            make.height.equalTo(40)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    override func configureView() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        
        settingLabel(label)
        settingLabel(colorTitleLabel)
        
        okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        colorCollectionView.backgroundColor = .darkGray
    }
    
    func settingLabel(_ label: UILabel) {
        label.textColor = Constants.Color.titleColor
        
    }
}
extension AddListViewController {
    func collectionViewLayout() -> UICollectionViewLayout {
        let insideInset: CGFloat = 4
        let inset: CGFloat = 10
//        let itemWidth = ((UIScreen.main.bounds.width - 80) - 20) / 6
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 48, height: 48) // 없으면 안됨
        layout.minimumLineSpacing = insideInset
        layout.minimumInteritemSpacing = insideInset
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        layout.scrollDirection = .vertical
        return layout
    }
}

extension AddListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView () {
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        colorCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.identifier)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath) as? ColorCollectionViewCell else {
            return UICollectionViewCell()
        }
        if selectedButtonIdx == indexPath.row {
            // 선택됐다면 알파
            cell.configureCell(uiColor: listColor[indexPath.row].uicolor.withAlphaComponent(0.5), isSelected: true)
            
        } else {
            cell.configureCell(uiColor: listColor[indexPath.row].uicolor, isSelected: false) // 아니라면 원래 색
        }
        cell.colorButton.tag = indexPath.row
        cell.colorButton.addTarget(self, action: #selector(selectColorButton), for: .touchUpInside)
        return cell
    }
    
    
}
