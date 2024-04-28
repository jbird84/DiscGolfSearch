//
//  UnderStableCarouselView.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 4/7/24.
//

import SwiftUI

struct UnderStableCarouselView: View {
        
        var xDistance: Int = 150
        
        @State private var snappedItem = 0.0
        @State private var draggingItem = 1.0
        @State private var activeIndex: Int = 0
        
        var views: [CarouselViewChild] = placeholderUnderstableCarouselChildView
        
        var body: some View {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Text("Understable Discs")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.bottom, 80)
            
                    ZStack {
                        ForEach(views) { view in
                            view
                                .scaleEffect(1.0 - abs(distance(view.id)) * 0.2)
                               // .opacity(1.0 - abs(distance(view.id)) * 0.3)
                                .offset(x: getOffset(view.id), y: 0)
                                .zIndex(1.0 - abs(distance(view.id)) * 0.1)
                                .blur(radius: addBlur(distance: abs(distance(view.id))))
                                .shadow(color: .white, radius: addShadow(distance: abs(distance(view.id))))
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
            }
        }
            func distance(_ item: Int) -> Double {
                return (draggingItem - Double(item).remainder(dividingBy: Double(views.count)))
            }
        
        func addBlur(distance: Double) -> Double {
            let blurRadius: Double = distance == 0 ? 0 : 2.8
            return blurRadius
        }
        
        func addShadow(distance: Double) -> Double {
            let shadowRadius: Double = distance == 0 ? 1 : 0
            return shadowRadius
        }
            
            func getOffset(_ item: Int) -> Double {
                let angle = Double.pi * 2 / Double(views.count) * distance(item)
                return sin(angle) * Double(xDistance)
                
            }
            
        }
        
        struct UnderStableCarouselView_Previews: PreviewProvider {
            static var previews: some View {
                UnderStableCarouselView()
            }
        }
        
        var placeholderUnderstableCarouselChildView: [CarouselViewChild] = [
            
            CarouselViewChild(id: 1, content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                        Text("An understable disc is characterized by its tendency to veer significantly to the right right after it's thrown. A highly understable disc usually exhibits minimal fade at the end of its flight. These discs are particularly well-suited for novice players who may not possess the arm strength required to throw more overstable discs effectively. When a player can't generate enough velocity, most discs tend to behave in an overstable manner for beginners.")
                            .multilineTextAlignment(.center)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .padding()
                }
                .frame(width: 335, height: 565)
            }),
            
            CarouselViewChild(id: 9, content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                    VStack {
                        Text("This is a typical flight path for an overstable disc.")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                        Image("understablePath")
                            .padding(.bottom, 10)
                }
            }
                .frame(width: 320, height: 500)
            }),
            
            CarouselViewChild(id: 4, content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                    VStack {
                        Text("Smooth Curves")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .underline()
                            .multilineTextAlignment(.center)
                        Text("Understable discs in disc golf veer right (for right-handed throwers) before curving back left at the end of their flight.")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
                .frame(width: 320, height: 500)
            }),
            
            CarouselViewChild(id: 5, content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                    VStack {
                        Text("Low Fade")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .underline()
                            .multilineTextAlignment(.center)
                        Text("They exhibit minimal leftward curve (fade), making them ideal for long, straight shots.")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                .frame(width: 320, height: 500)
            }),
            
            CarouselViewChild(id: 6, content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                    VStack {
                        Text("Beginner-Friendly")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .underline()
                        Text("Understable discs are great for beginners as they require less power to achieve distance and control.")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                .frame(width: 320, height: 500)
            }),
            
            CarouselViewChild(id: 7, content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                    VStack {
                        Text("Tailwind Advantage")
                            .font(.largeTitle)
                            .underline()
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                        Text("They perform well with a tailwind, gaining extra distance.")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                .frame(width: 320, height: 500)
            }),
            
            CarouselViewChild(id: 3, content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                    VStack {
                        Text("Hyzer Flip")
                            .font(.largeTitle)
                            .underline()
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                        Text("Understable discs can be used for the hyzer flip technique, creating graceful S-curve shots.This is a throw where you release the disc with an anhyzer angle, causing it to flip up to flat and glide right. It's a great choice for long, controlled drives.")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                .frame(width: 320, height: 550)
            }),
            
            CarouselViewChild(id: 8, content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                    VStack {
                        Text("Versatile Choices")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .underline()
                            .multilineTextAlignment(.center)
                        Text("These discs are versatile and can suit various shot types, making them a valuable part of a disc golfer's toolkit.")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                .frame(width: 320, height: 550)
            }),
            CarouselViewChild(id: 2, content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(UIColor(named: "textBackgroundBox") ?? .blue))
                    VStack {
                        Text("Turnover Shot")
                            .multilineTextAlignment(.center)
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .underline()
                        Text("This throw involves releasing the disc with an anhyzer angle, causing it to turn to the right (for right-handed backhand throwers) throughout its flight. It's useful for navigating tight fairways or shaping shots.")
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
                .frame(width: 320, height: 500)
            })
            
        ]

