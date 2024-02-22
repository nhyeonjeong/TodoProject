//
//  TodoRealmModel.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import Foundation
import RealmSwift

// 상위 테이블
class ListTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var listTitle: String
    @Persisted var regDate: Date
    @Persisted var colorIdx: Int
    // to many relationship
    @Persisted var todo: List<TodoTable>
    
    convenience init(listTitle: String, colorIdx: Int) {
        
        self.init()
        self.listTitle = listTitle
        self.regDate = Date()
        self.colorIdx = colorIdx
    }
}


// 하위 테이블
class TodoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var regDate: Date
    @Persisted var memoTitle: String
    @Persisted var memo: String
    @Persisted var deadline: Date
    @Persisted var tag: String?
    @Persisted var priority: Int // 우선순위는 Int타입으로
    @Persisted var isComplete: Bool // 완료했는지?
    
    // 역관계
    @Persisted(originProperty: "todo") var main: LinkingObjects<ListTable>
    
    // convenience써주지 않으면 런타임 오류
    convenience init(memoTitle: String, memo: String, deadline: Date, tag: String? = nil, priority: Int) {
        
        self.init()
        self.regDate = Date()
        self.memoTitle = memoTitle
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
        self.isComplete = false
    }
    
    var deadlinstFormatString: String {
        let deadlineString = DateFormatter.Format.string(from: deadline)
        return "\(deadlineString)"
    }
}
