//
//  ColorCollectionViewCell.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/22.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    let colorButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.tintColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureConstraints()
    }
    
    
    // 스토리보드로 할 때 실행되는 구문
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
}

extension ColorCollectionViewCell {
    func configureHierarchy() {
        contentView.addSubview(colorButton)
    }
    
    func configureConstraints() {
        colorButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureCell(uiColor: UIColor, isSelected: Bool) {
        colorButton.backgroundColor = uiColor
        // 체크이미지
        if isSelected {
            colorButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            colorButton.setImage(nil, for: .normal)
        }
    }
}
