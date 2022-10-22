//
//  MainViewController.swift
//  SelfCompositional
//
//  Created by Carki on 2022/10/22.
//

import Foundation
import UIKit

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    var viewModel = DiffableViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        
        mainView.searchBar.delegate = self
        
        viewModel.photoList.bind { photo in
            var snapShot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
            snapShot.appendSections([0])
            snapShot.appendItems(photo.results)
            self.dataSource.apply(snapShot)
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestSearchPhoto(query: searchBar.text!)
        print(searchBar.text!)
    }
}

extension MainViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
    private func configureDataSource() {
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            //String -> URL -> Data -> Image
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
            
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 2
            background.strokeColor = .brown
            cell.backgroundConfiguration = background
        })
        
        // collectionView.dataSource = self 의 ㄱ코드를 대신함
        //CellForRowAt, numberOfItemsInSection 의 코드를 대신함
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
}
