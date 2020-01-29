//
//  TodoListViewModel.swift
//  Skillbox_m4 (Architecture MVVM ToDo)
//
//  Created by Kravchuk Sergey on 18.01.2020.
//  Copyright © 2020 Kravchuk Sergey. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

class TodoListViewModel {
    
    private var realm = try! Realm()
    private var results: Results<ToDoRealm>!
    
    let todoItems = BehaviorRelay(value: Array<ToDo>())
    
    private let bag = DisposeBag()
    
    init() {
        
        results = realm.objects(ToDoRealm.self)
        Observable.collection(from: results).subscribe(onNext: { [unowned self] newResults in
            self.todoItems.accept(newResults.toArray().map{ $0.presentation })
        }).disposed(by: bag)
    
    }
    
    func append(_ item: ToDo) {
        try! realm.write {
            let newObj = ToDoRealm()
            newObj.text = item.text
            realm.add(newObj)
        }
    }
    
    func delete(at index: Int) {
        try! realm.write {
            realm.delete(results[index])
        }
    }
    
}


