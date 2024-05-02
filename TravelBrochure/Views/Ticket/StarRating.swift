//
//  StarRating.swift
//  TravelBrochure
//
//  Created by Kakeru Fukuda on 2024/05/02.
//

import SwiftUI

struct StarRating: View {
    @Binding var rate: Int
    var body: some View {
        
        HStack {
            star(1)
            star(2)
            star(3)
            star(4)
            star(5)
        }
    }
    
    private func star(_ value: Int) -> some View {
        Image(systemName: rate >= value ? "star.fill" : "star")
            .onTapGesture {
                rate = value
            }
    }
}

#Preview {
    @State var rate = 2
    return StarRating(rate: $rate)
}
