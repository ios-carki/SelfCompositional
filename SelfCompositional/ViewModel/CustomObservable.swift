//
//  CustomObservable.swift
//  SelfCompositional
//
//  Created by Carki on 2022/10/22.
//

import Foundation

class CustomObservable<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
