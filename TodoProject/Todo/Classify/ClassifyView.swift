//
//  TodoView.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import UIKit
import SnapKit

class ClassifyView: BaseView {
    
    let bigLabel: UILabel = {
        let view = UILabel()
        view.text = "전체"
        view.textColor = Constants.Color.titleColor
        view.font = Constants.Font.boldBigTitle
        return view
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    
    // 스토리보드로 할 때 실행되는 구문
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //        configureView() // 스토리보드로 한다면 여기도 configureView호출
        print("textfield required init")
    }
    
    override func configureHierarchy() {
        addSubview(bigLabel)
        addSubview(collectionView)
    }
    override func configureConstraints() {
        bigLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(bigLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension ClassifyView {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let inset: CGFloat = 15
        let screenwidth = UIScreen.main.bounds.width
        let cellWidth = (screenwidth - inset*3) / 2
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: 100) // 없으면 안됨
        layout.minimumLineSpacing = inset
        layout.minimumInteritemSpacing = inset
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        layout.scrollDirection = .vertical // 스크롤 방향도 FlowLayout에 속한다 -> contentMode때문에 Fill로
        return layout
    }
}
