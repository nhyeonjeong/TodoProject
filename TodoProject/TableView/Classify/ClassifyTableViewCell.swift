//
//  ClassifyTableViewCell.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/23.
//

import UIKit
import SnapKit

class ClassifyTableViewCell: UITableViewCell {
    
    // tableview 0번째 인덱스에 들어가는 컬렉션 뷰
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(380)
        }
    }
}

extension ClassifyTableViewCell {
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
