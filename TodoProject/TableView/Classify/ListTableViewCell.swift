//
//  ClassifyTableViewCell.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/23.
//

import UIKit
import SnapKit

class ListTableViewCell: UITableViewCell {

    let listImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.image = UIImage(systemName: "list.bullet.circle.fill")
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.titleColor
        view.font = Constants.Font.normalTitle
        view.numberOfLines = 0 // 여러줄 입력 가능하도록
        return view
    }()
    
    let numberTodoLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.subtitleColor
        view.font = Constants.Font.normalTitle
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(listImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(numberTodoLabel)
    }
    func configureConstraints() {
        listImageView.snp.makeConstraints { make in
//            make.verticalEdges.greaterThanOrEqualTo(contentView).inset(10)
            make.centerY.equalTo(contentView.snp.centerY) // 이걸 안써주면 레이아웃이 망가졌음
            make.size.equalTo(40)
            make.leading.equalTo(contentView).inset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(listImageView.snp.trailing).offset(10)
            make.verticalEdges.greaterThanOrEqualTo(contentView).inset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            
        }
        
        numberTodoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(22)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
    func configureCell(_ data: ListTable) {
        listImageView.tintColor = ListColor.allCases[data.colorIdx].uicolor
        titleLabel.text = data.listTitle
        numberTodoLabel.text = "\(data.todo.count)" // 목록에 해당하는 todo 갯수
    }
}
