//
//  RxBinding.swift
//  Skillbox_m4 (Architecture MVVM ToDo)
//
//  Created by Kravchuk Sergey on 18.01.2020.
//  Copyright © 2020 Kravchuk Sergey. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

infix operator <->

func <-><T>(property: ControlProperty<T>, variable: BehaviorSubject<T>) -> Disposable {
    let variableToProperty = variable.asObservable()
        .bind(to: property)

    let propertyToVariable = property
        .subscribe(
            onNext: { variable.onNext($0) },
            onCompleted: { variableToProperty.dispose() }
    )

    return Disposables.create(variableToProperty, propertyToVariable)
}
