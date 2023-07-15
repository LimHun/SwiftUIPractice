//
//  StockView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/28.
//

import SwiftUI

struct StockView: View {
    
    @ObservedObject private var stockListVM = StockListViewModel()

    init() {

        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor(displayP3Red: 47 / 255, green: 54 / 255, blue: 64 / 255, alpha: 1.0)
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        } else {
            UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 47 / 255, green: 54 / 255, blue: 64 / 255, alpha: 1.0)
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }

        stockListVM.load()
    }

    var body: some View {

        let filteredStocks = self.stockListVM.searchTerm.isEmpty ? self.stockListVM.stocks : self.stockListVM.stocks.filter { $0.symbol.starts(with: self.stockListVM.searchTerm)}

        return
            ZStack(alignment: .leading) {
                Color.black
                Text("January 5 2022")
                    .font(.custom("Arial", size: 32))
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    .offset(y: -350)
                SearchView(searchTerm: self.$stockListVM.searchTerm)
                    .offset(y: -300)
                StockListView(stocks: filteredStocks)
                    .offset(y: 140)
            }
            .navigationTitle("Stocks")
            .edgesIgnoringSafeArea(Edge.Set(.bottom))
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView()
        StockView()
            .background(Color(UIColor.systemBackground))
            .environment(\.colorScheme, .dark)
    }
}
