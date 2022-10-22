//
//  DiffableViewModel.swift
//  SelfCompositional
//
//  Created by Carki on 2022/10/22.
//

import Foundation

class DiffableViewModel {
    
    var photoList: CustomObservable<SearchPhoto> = CustomObservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    
    func requestSearchPhoto(query: String) {
        APIService.searchPhoto(query: query) { photo, statusCode, error in
            guard let photo = photo else { return }
            self.photoList.value = photo
        }
    }
}
