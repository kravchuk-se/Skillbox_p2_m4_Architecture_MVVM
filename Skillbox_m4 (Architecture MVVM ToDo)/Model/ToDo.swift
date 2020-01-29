//
//  ToDo.swift
//  Skillbox_m4 (Architecture MVC ToDo)
//
//  Created by Kravchuk Sergey on 17.01.2020.
//  Copyright © 2020 Kravchuk Sergey. All rights reserved.
//

import Foundation

struct ToDo {
    let text: String
}

extension ToDoRealm {
    var presentation: ToDo {
        return ToDo(text: self.text)
    }
}
