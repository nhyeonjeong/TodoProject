//
//  ListTableRepository.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/23.
//

import Foundation
import RealmSwift

final class ListTableRepository {
    
    private let realm = try! Realm()
    
    // create
    func createItem(_ item: ListTable) {
        print(realm.configuration.fileURL)
        do {
            try realm.write {
                realm.add(item)
                print("Realm Create")
            }
            
        } catch {
            
            print(error)
        }
        
    }
    
    // read All
    func fetch() -> Results<ListTable> {

        return realm.objects(ListTable.self)

    }
    /*
    // read(filter)
    func fetchCategoryFilter(_ category: String) -> Results<AccountBookTable> {
        realm.objects(AccountBookTable.self).where {
            // 매개변수로 받아온 카테고리 정보
            $0.category == category
        }.sorted(byKeyPath: "money", ascending: true)
    }
    
    /// update record
    func updateItem(id: ObjectId, money: Int, category: String) {
        // 하나의 레코드에서 money를 바꾸겠다.!
        do {
            try realm.write {
                // 3. update version 3
                // 한 레코드에서 여러 컬럼 정보를 변경하고 싶을 때
                
                // list기준으로 작성하지는 않고..
                // Realm을 기준으로 작업
                // 어떤 레코드인지 찾아주는 작업도 필요하기 때문에 id도 같이 넣어야 한다.
                realm.create(AccountBookTable.self, value: ["id": id, "money": money, "category": category], update: .modified) // 기존의 레코드 정보들을 수정
                // 1이나 3은 사실상 동일하니까 둘 중 선택해서 사용하면 된다.
            }
        } catch {
            print(error)
        }
    }
    
    /// update MoneyAll : 한번에 전체 칼럼 수정
    func updateMoneyAll(money: Int) {
        do {
            // 2.update version2
            // 테이블에서 전체 컬럼 정보를 변경하고 싶을 때? -> realm에서 반복문 사용하지 않고도 한 번에 적용 가능하도록 함
            // 한 번에 추가/변경/삭제등등
            try realm.write {
                // 결국은 realm.objects(AccountBookTable.self)가 list이다.
                realm.objects(AccountBookTable.self).setValue(money, forKey: "money")
//                list.setValue(100000, forKey: "money") // setValue 는 realm에서 제공 / 그냥 반복문을 사용하는 것보다 훨씬 속도가 빠르다
            }
        } catch {
            print(error)
        }
    }
    
    // update : 한 레코드에 카테고리를 수정
    func updateCategory(_ item: AccountBookTable) {
        print(realm.configuration.fileURL)
        do {
            try realm.write({
                // 밖에서 category안 불러도 되게끔 숨겨두는 것
                item.category = "커피" // list를 건드리면 싱크가 되어있어서 테이블도 변경될 것!! 와우 대박
    //            list[indexPath.row].favorite.toggle() // false->true , true->false
    //            list[indexPath.row].favorite = !list[indexPath.row].favorite // 이렇게 역으로 저장도 가능
//                list[indexPath.row].money = Int.random(in: 100...3000)
            }) // 커피로 바뀌면 지금 viewDidLoad에 공부만 나오게 필터링 되어있으니까 사라질 것이다.
        } catch {
            print(error)
        }
    }
     */
    // delete
    func deleteData(_ item: ListTable) {
        do {
            try realm.write{
                // 레코드는 유지된 채로 컬럼삭제는 삭제가 아니고 수정이다!!!!(삭제는 레코드 전체를 삭제)
                realm.delete(item) // 이 데이터를 제거하겠다.
            }
        } catch {
            print("deleteData", error)
        }
    }
                     
    // update isComplete
    func updateIsComplete(_ item: ListTable) {
//        print(realm.configuration.fileURL)
//        do {
//            try realm.write({
//                item.isComplete.toggle() // list를 건드리면 싱크가 되어있어서 테이블도 변경될 것!! 와우 대박
//            })
//        } catch {
//            print(error)
//        }
    }
}
