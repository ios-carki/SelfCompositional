//
//  MainView.swift
//  SelfCompositional
//
//  Created by Carki on 2022/10/22.
//

import Foundation
import UIKit

import SnapKit

class MainView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    let collectionView: UICollectionView  = {
        func createLayout() -> UICollectionViewLayout {
            let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            let layout = UICollectionViewCompositionalLayout.list(using: config)
            
            return layout
        }
        
        let view = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: createLayout())
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()
    
    override func configureUI() {
        [searchBar, collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
