//
//  EntireBoxCollectionViewCell.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import UIKit
import SnapKit

class EntireBoxCollectionViewCell: UICollectionViewCell {
    // 나중에 backView customView로 만들기
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.addViewTableColor
        view.layer.cornerRadius = 10
        return view
    }()
    let systemImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.subtitleColor
        view.font = Constants.Font.normalTitle
        return view
    }()
    
    let memoCountLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.titleColor
        view.font = Constants.Font.boldTitle
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    
    // 스토리보드로 할 때 실행되는 구문
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //        configureView() // 스토리보드로 한다면 여기도 configureView호출
        print("textfield required init")
    }
    
    func configureCell(image: UIImage, imageTintColor: UIColor, titleString: String, memoCount: Int?) {
        systemImageView.image = image
        systemImageView.tintColor = imageTintColor
        titleLabel.text = titleString
        
        // memoCount가 Int?일 때는 ""
        var count = ""
        if let memoCount {
            count = "\(memoCount)"
            memoCountLabel.text = "\(count)"
        }
    }
    
    func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(systemImageView)
        backView.addSubview(titleLabel)
        backView.addSubview(memoCountLabel)
    }
    func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        systemImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
            make.size.equalTo(50)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(systemImageView.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
            make.leading.equalTo(systemImageView.snp.leading)
    
        }
        
        memoCountLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
            
        }
    }
    func configureView() {
        
    }
}
