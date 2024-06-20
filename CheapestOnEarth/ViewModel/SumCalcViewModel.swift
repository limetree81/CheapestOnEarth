import SwiftUI
import Combine
import Foundation

struct Subscription: Identifiable, Codable {
    let id: UUID
    var name: String
    var price: Double
    
    init(id: UUID = UUID(), name: String, price: Double) {
        self.id = id
        self.name = name
        self.price = price
    }
}


class SumCalcViewModel: ObservableObject {
    @Published var subscriptions: [Subscription] = []
    @Published var total: Double = 0.0
    
    private var cancellables: Set<AnyCancellable> = []
    private let subscriptionsKey = "subscriptions"
    
    init() {
        loadSubscriptions()
        $subscriptions
            .map { $0.reduce(0) { $0 + $1.price } }
            .assign(to: \.total, on: self)
            .store(in: &cancellables)
    }
    
    func addSubscription(name: String, price: Double) {
        let newSubscription = Subscription(name: name, price: price)
        subscriptions.append(newSubscription)
        saveSubscriptions()
    }
    
    func removeSubscription(at offsets: IndexSet) {
        subscriptions.remove(atOffsets: offsets)
        saveSubscriptions()
    }
    
    private func saveSubscriptions() {
        UserDefaults.standard.setObject(subscriptions, forKey: subscriptionsKey)
    }
    
    private func loadSubscriptions() {
        if let loadedSubscriptions = UserDefaults.standard.getObject(forKey: subscriptionsKey, type: [Subscription].self) {
            subscriptions = loadedSubscriptions
        }
    }
}
