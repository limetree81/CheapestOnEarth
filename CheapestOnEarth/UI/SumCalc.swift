//
//  SumCalc.swift
//  CheapestOnEarth
//
//  Created by Limetree on 2024/06/19.
//

import SwiftUI

struct SumCalc: View {
    @StateObject private var viewModel = SumCalcViewModel()
    @State private var subscriptionName: String = ""
    @State private var subscriptionPrice: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.subscriptions) { subscription in
                        HStack {
                            Text(subscription.name)
                                .font(.headline)
                            Spacer()
                            Text("\(subscription.price, specifier: "%.2f") KRW")
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: viewModel.removeSubscription)
                }
                
                HStack {
                    TextField("서비스 이름", text: $subscriptionName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("가격", text: $subscriptionPrice)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    Button(action: {
                        guard let price = Double(subscriptionPrice) else { return }
                        viewModel.addSubscription(name: subscriptionName, price: price)
                        subscriptionName = ""
                        subscriptionPrice = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .disabled(subscriptionName.isEmpty || subscriptionPrice.isEmpty)
                }
                .padding()
                
                HStack {
                    Text("총 요금:")
                        .font(.headline)
                    Spacer()
                    Text("\(viewModel.total, specifier: "%.2f") KRW")
                        .font(.title2)
                }
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("요금 관리")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct SumCalc_Previews: PreviewProvider {
    static var previews: some View {
        SumCalc()
    }
}
