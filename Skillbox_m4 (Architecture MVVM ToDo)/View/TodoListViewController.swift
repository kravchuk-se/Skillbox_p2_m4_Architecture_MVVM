//
//  ViewController.swift
//  Skillbox_m4 (Architecture MVVM ToDo)
//
//  Created by Kravchuk Sergey on 17.01.2020.
//  Copyright © 2020 Kravchuk Sergey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TodoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = TodoListViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        viewModel.todoItems.bind(to: tableView.rx.items(cellIdentifier: "TodoCell")) { row, element, cell in
            cell.textLabel?.text = element.text
        }
        .disposed(by: bag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edit segue" {
            let vc = segue.destination as! TodoEditViewController
            vc.onDoneEditing = viewModel.append
        }
    }
    
    deinit {
        print("list deallocation")
    }
}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.delete(at: indexPath.row)
    }
}
