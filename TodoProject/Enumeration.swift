//
//  Enumeration.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit

enum Constants {

    
    enum Color {
        static let backgroundColor = UIColor.black
        static let addViewBackgroundColor = UIColor.systemGray6
        static let addViewTableColor = UIColor.systemGray5
        
        static let titleColor = UIColor.white
        static let subtitleColor = UIColor.systemGray2
        
        static let pointColor = UIColor.systemPink
        static let pointColor2 = UIColor.red
        static let pointColor3 = UIColor.green
    }
    enum Font {
        static let subtitle: UIFont = .systemFont(ofSize: 14)
        static let talbeViewTitle: UIFont = .systemFont(ofSize: 15)
    }
    enum Image {
        
    }
}

// 힐 일 추가할 때 리스트들
enum TodoList: String, CaseIterable {
    case memoBox = "메모"
    case deadline = "마감일"
    case tag = "태그"
    case priority = "우선 순위"
    case addImage = "이미지 추가"
    
    var tableViewCellTitle: [String] {
        switch self {
        case .memoBox:
            return ["제목", "메모"]
        default:
            return [self.rawValue] // 그대로 출력
        }
    }
}
