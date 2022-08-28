//
//  StockViewModel.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/28.
//

import Foundation

class StockListViewModel : ObservableObject {

    @Published var stocks : [StockViewModel] = [StockViewModel]()
    @Published var searchTerm: String = ""

    func load() {
        fetchStocks()
    }

    private func fetchStocks() {
        Webservice().getStocks { stocks in
            if let stocks = stocks {
                DispatchQueue.main.async {
                    self.stocks = stocks.map(StockViewModel.init)
                }
            }
        }
    }

}

