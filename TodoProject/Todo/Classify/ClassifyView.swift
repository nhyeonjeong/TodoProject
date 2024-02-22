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
    
    // 전체를 감싸는 Table
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.backgroundColor = .clear
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
        addSubview(tableView)
    }
    override func configureConstraints() {
        bigLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(bigLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

