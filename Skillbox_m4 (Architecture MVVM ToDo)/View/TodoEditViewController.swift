//
//  TodoEditViewController.swift
//  Skillbox_m4 (Architecture MVVM ToDo)
//
//  Created by Kravchuk Sergey on 18.01.2020.
//  Copyright © 2020 Kravchuk Sergey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TodoEditViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var onDoneEditing: ((ToDo) -> Void)?
    
    private let todoText = BehaviorSubject<String?>(value: "New item")
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        (textField.rx.text <-> todoText).disposed(by: bag)
        
        textField
            .rx
            .controlEvent(.editingDidEnd)
            .withLatestFrom(textField.rx.text)
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .subscribe(onNext: {[unowned self] text in
                
                let newItem = ToDo(text: text)
                self.onDoneEditing?(newItem)
                self.navigationController?.popViewController(animated: true)
                
            }).disposed(by: bag)
    
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    deinit {
        print("edit deallocation")
    }
    
}



