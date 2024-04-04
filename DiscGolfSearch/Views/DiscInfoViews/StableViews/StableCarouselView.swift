//
//  StableCarouselView.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 4/3/24.
//


import SwiftUI

struct CarouselView: View {
    
    var xDistance: Int = 150
    
    @State private var snappedItem = 0.0
    @State private var draggingItem = 1.0
    @State private var activeIndex: Int = 0
    
    var views: [CarouselViewChild] = placeholderCarouselChildView
    
    var body: some View {
        VStack {
            Text("Stable Discs") // Text added here
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 20)
            ZStack {
                Color.black
                    .ignoresSafeArea()
                ForEach(views) { view in
                    view
                        .scaleEffect(1.0 - abs(distance(view.id)) * 0.2)
                        .opacity(1.0 - abs(distance(view.id)) * 0.3)
                        .offset(x: getOffset(view.id), y: 0)
                        .zIndex(1.0 - abs(distance(view.id)) * 0.1)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        draggingItem = snappedItem + value.translation.width / 100
                    }
                    .onEnded { value in
                        withAnimation {
                            draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                            draggingItem = round(draggingItem).remainder(dividingBy: Double(views.count))
                            snappedItem = draggingItem
                            self.activeIndex = views.count + Int(draggingItem)
                            if self.activeIndex > views.count || Int(draggingItem) >= 0 {
                                self.activeIndex = Int(draggingItem)
                            }
                        }
                    }
            )
            
        }
        
        func distance(_ item: Int) -> Double {
            return (draggingItem - Double(item).remainder(dividingBy: Double(views.count)))
        }
        
        func getOffset(_ item: Int) -> Double {
            let angle = Double.pi * 2 / Double(views.count) * distance(item)
            return sin(angle) * Double(xDistance)
            
        }
        
    }
    
    struct CarouselView_Previews: PreviewProvider {
        static var previews: some View {
            CarouselView()
        }
    }
    
    var placeholderCarouselChildView: [CarouselViewChild] = [
        
        CarouselViewChild(id: 1, content: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                VStack {
                    Text("Stable discs will spin similarly to an overstable disc but will not turn much, if at all. This means the flight path should be fairly straight.")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding()
                    Image("finalStabPath")
                }
            }
            .frame(width: 250, height: 350)
        }),
        
        CarouselViewChild(id: 2, content: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                Text("Straight Flight: Stable discs in disc golf maintain a relatively straight flight path without significant veering to the left or right.")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(width: 250, height: 250)
        }),
        
        CarouselViewChild(id: 3, content: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                Text("Consistent Fade: They have a moderate and predictable fade, smoothly curving at the end of their flight.")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(width: 250, height: 250)
        }),
        
        CarouselViewChild(id: 4, content: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                Text("Control and Accuracy: Stable discs offer excellent control and accuracy, making them a popular choice for both beginners and experienced players.")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(width: 250, height: 250)
        }),
        
        CarouselViewChild(id: 5, content: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                Text("Versatility: They are versatile and can handle various throwing techniques, making them suitable for a wide range of shots.")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(width: 250, height: 250)
        }),
        
        CarouselViewChild(id: 6, content: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                Text("Reliable in Wind: Stable discs are dependable even in mild wind conditions, offering consistent performance.")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(width: 250, height: 250)
        }),
        
        CarouselViewChild(id: 7, content: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                Text("Foundation Disc: Many disc golfers start with stable discs to build fundamental throwing skills before experimenting with overstable and understable discs.")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(width: 250, height: 250)
        }),
        
        CarouselViewChild(id: 8, content: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                VStack {
                    Text("SHOTS BASED ON STABILITY")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text("Straight Shot: Stable discs are ideal for throwing straight shots, where you release the disc flat, and it maintains a relatively straight path throughout its flight.")
                        .font(.callout)
                        .foregroundStyle(.white)
                        .padding()
                }
            }
            .frame(width: 250, height: 250)
        }),
        
        CarouselViewChild(id: 9, content: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                VStack {
                    Text("SHOTS BASED ON STABILITY")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text("Tunnel Shot: Stable discs are great for navigating tight tunnel-like fairways, where you need precision and control to stay on the desired path. These shots require accuracy and minimal lateral movement.")
                        .font(.callout)
                        .foregroundStyle(.white)
                        .padding()
                }
            }
            .frame(width: 250, height: 250)
        })
        
    ]
