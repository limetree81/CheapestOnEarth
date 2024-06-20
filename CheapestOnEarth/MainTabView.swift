//
//  MainTabView.swift
//  CheapestOnEarth
//
//  Created by Limetree on 2024/06/19.
//

import SwiftUI

struct MainTabView: View {
    private enum Tabs {
        case news, priceComp, topChart, sumCalc
    }
    @State private var selectedTab: Tabs = .news
    var body: some View {
        TabView(selection: $selectedTab) {
            news
            priceComp
            sumCalc
        }
    }
}

fileprivate extension View {
    func tabItem(image: String, text:String) -> some View {
        self.tabItem {
            Image(systemName: image)
                .font(Font.system(size: 17, weight: .light))
            Text(text)
        }
    }
}
private extension MainTabView {
    

    var news: some View {
        News().tag(Tabs.news)
            .tabItem(image: "house", text: "뉴스")
    }
    var priceComp: some View {
        PriceComp().tag(Tabs.priceComp)
            .tabItem(image: "dollarsign.circle", text: "가격 비교")
    }
    var sumCalc: some View {
        SumCalc().tag(Tabs.sumCalc)
            .tabItem(image: "list.bullet.clipboard", text: "요금 관리")
    }
    
}
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
