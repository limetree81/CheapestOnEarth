import SwiftUI
import Combine

struct ExchangeRatesResponse: Decodable {
    let conversion_rates: [String: CGFloat]
}

struct SubscriptionPrice: Identifiable {
    let id = UUID()
    let country: String
    let price: CGFloat
    let currency: String
    var convertedPrice: CGFloat = 0.0
}

class PriceCompViewModel: ObservableObject {
    @Published var subscriptionPrices: [SubscriptionPrice] = [
        SubscriptionPrice(country: "나이지리아", price: 1100.0, currency: "NGN"),
        SubscriptionPrice(country: "아르헨티나", price: 389.0, currency: "ARS"),
        SubscriptionPrice(country: "인도", price: 129.0, currency: "INR"),
        SubscriptionPrice(country: "튀르키예", price: 57.99, currency: "TRY"),
        SubscriptionPrice(country: "우크라이나", price: 99.0, currency: "UAH"),
        SubscriptionPrice(country: "브라질", price: 24.9, currency: "BRL")
    ]
    @Published var exchangeRates: [String: CGFloat] = [:]

    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchExchangeRates()
    }

    func fetchExchangeRates() {
        let url = URL(string: "https://v6.exchangerate-api.com/v6/aa8a51cae41df0938ec1b709/latest/KRW")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ExchangeRatesResponse.self, decoder: JSONDecoder())
            .map { $0.conversion_rates }
            .replaceError(with: [:])
            .receive(on: DispatchQueue.main)
            .assign(to: \.exchangeRates, on: self)
            .store(in: &cancellables)
    }

    func convertPrices(to currency: String) {
        guard let baseRate = exchangeRates[currency] else { return }
        
        for index in subscriptionPrices.indices {
            let localRate = exchangeRates[subscriptionPrices[index].currency] ?? 1.0
            subscriptionPrices[index].convertedPrice = subscriptionPrices[index].price / localRate * baseRate
        }
    }

    func updateConvertedPrices(baseCurrency: String = "KRW") {
        convertPrices(to: baseCurrency)
        subscriptionPrices.sort { $0.convertedPrice < $1.convertedPrice }
    }
}
