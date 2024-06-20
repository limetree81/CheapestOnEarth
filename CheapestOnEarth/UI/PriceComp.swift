import SwiftUI

struct PriceComp: View {
    @StateObject private var viewModel = PriceCompViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.subscriptionPrices) { price in
                HStack {
                    Text(price.country)
                        .font(.headline)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(price.convertedPrice, specifier: "%.2f") KRW")
                            .font(.subheadline)
                        Text("\(price.price, specifier: "%.2f") \(price.currency)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("가격 비교")
            .onAppear {
                viewModel.updateConvertedPrices()
            }
        }
    }
}

struct PriceComp_Previews: PreviewProvider {
    static var previews: some View {
        PriceComp()
    }
}
