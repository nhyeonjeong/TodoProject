//
//  UIView+Extension.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit

// uicollectionviewcell와 UItableviewcell은 uiview를 상속하고 있음
// uiviewcon을 상속하지 않는다.
extension UIView: ReusableProtocol {
    // ViewController의 identifier도 여기서 묶고 싶을 때
    static var identifier: String {
        return String(describing: self) // 스트링인터폴레이션(문자열보간법)사용하면 옵셔널이 풀릴 수도 있다-->??
    }
}

