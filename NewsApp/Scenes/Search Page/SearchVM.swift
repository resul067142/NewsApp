//
//  SearchViewModel.swift
//  NewsApp
//
//  Created by Aleyna Aktaş on 19.09.2023.
//

import Foundation

final class SearchVM {
    
    var newsData: [Article] = []
    
    var onSucces: (()->())?
    var onError: ((_ errorStr: String)->())?
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("work1")
            self.fetchNewsData(searchText: "")
        }
    }
    
    func fetchNewsData(searchText: String) {

        newsData = []
        
        NetworkManager.shared.getAllNews(query: searchText, category: "") { [weak self] result in
            print("work2")
            DispatchQueue.main.async {
                switch result {
                case .success(let newsResponse):
                    if let articles = newsResponse.articles {
                        self?.newsData = articles
                        self?.onSucces?()
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self?.onError?("An error occurred")
                }
            }
        }
    }


    func cellForRow(at indexPath: IndexPath) -> Article? {
        return newsData[indexPath.row]
    }
    
    func numberOfItems(in section: Int) -> Int {
        return newsData.count
    }
    
    
}
