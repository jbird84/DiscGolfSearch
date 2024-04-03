//
//  StablePagingScrollView.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 4/2/24.
//

import SwiftUI

struct StablePagingScrollView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<15) { index in
                Circle()
                    .frame(width: 400, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Text("\(index)").foregroundStyle(.white)
                    ).frame(maxWidth: .infinity)
                    .scrollTransition(.interactive.threshold(.visible(0.99))) { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1 : 0)
                            .offset(x: phase.isIdentity ? 0 : -100)
                    }
                  // .containerRelativeFrame(.vertical, alignment: .center)
            }
        }
        .ignoresSafeArea()
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    StablePagingScrollView()
}
