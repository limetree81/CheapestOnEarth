//
//  News.swift
//  CheapestOnEarth
//
//  Created by Limetree on 2024/06/19.
//

import SwiftUI

struct News: View {
    // Sample news data
    private let newsItems = [
        NewsItem(title: "러시아 사용 불가", content: "유튜브 정책으로 인해 현재 러시아에서 유튜브 프리미엄 서비스가 일시적으로 중단되었습니다."),
        NewsItem(title: "앱이 출시되었습니다.", content: "현재 유튜브 프리미엄 가격에 대해서만 정보를 제공하고 있습니다.\n 버그 및 건의사항 제보: limetree81@knu.ac.kr")
    ]
    
    var body: some View {
        NavigationView {
            List(newsItems) { item in
                NewsCard(newsItem: item)
                    .padding(.vertical, 8)
            }
            .navigationBarTitle("뉴스")
        }
    }
}

struct NewsCard: View {
    let newsItem: NewsItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(newsItem.title)
                .font(.headline)
                .padding(.bottom, 2)
            Text(newsItem.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}

struct News_Previews: PreviewProvider {
    static var previews: some View {
        News()
    }
}
