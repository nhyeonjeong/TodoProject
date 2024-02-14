//
//  BaseViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit
// 공통적으로 UIVIewCon에서 사용해주는 게 있다면 여기에 적어두기
// 여기서는 final을 붙일 수 없음. 다른 곳에서 상속해줘야 하니까
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function) // self는 컨트롤러 인스턴스
        view.backgroundColor  = Constants.Color.backgroundColor
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    // 보통 함수 내부는 비워두는 편
    func configureHierarchy() {
        print(self, #function)
    }
    
    func configureConstraints() {
        print(self, #function)
    }
    
    func configureView() {
        print(self, #function)
        view.backgroundColor = .blue
    }
    
}
