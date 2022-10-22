//
//  BaseView.swift
//  SelfCompositional
//
//  Created by Carki on 2022/10/22.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI() {
        
    }
    
    func setConstraints() {
        
    }
}
