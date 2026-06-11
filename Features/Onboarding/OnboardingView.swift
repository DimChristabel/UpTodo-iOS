//
//  OnboardingView.swift
//  upToDo
//
//  Created by Maxut Consulting on 26/05/2026.
//

import SwiftUI

struct OnboardingView: View {
   
    @AppStorage("hasOnboarded") var hasOnboarded = false
    @StateObject private var viewModel = OnboardingViewModel()
    
    private var slides: [OnboardingSlide] {
        viewModel.slides
    }
    
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // SKIP
                HStack {
                    TextButton(
                        title: "SKIP",
                        fontSize: 16,
                        fontWeight: .regular
                    ) {
                        hasOnboarded = true
                    }
                }
                
                Spacer()
                
                // IMAGE (FIXED)
                Image(slides[currentPage].imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 260, height: 260)
                    .id(currentPage)
                    .transition(.slide)
                
                Spacer()
                
                // INDICATORS
                OnboardingDots(
                    currentPage: currentPage,
                    totalPages: 3
                )
                
                Spacer()
                
                // TITLE
                Text(slides[currentPage].title)
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                // DESCRIPTION (FIXED: was .body → must be .description)
                Text(slides[currentPage].description)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)
                
                Spacer()
                
                // BUTTONS
                HStack {
                    
                    TextButton(title: "BACK") {
                        withAnimation { currentPage -= 1 }
                    }
                   
                    Spacer()
                    
                    PrimaryButton(
                        title: currentPage == 2 ? "GET STARTED" : "NEXT",
                        cornerRadius: 6, vertPadding: 14
                    ) {
                        withAnimation {
                            if currentPage == 2 {
                                hasOnboarded = true
                            } else {
                                currentPage += 1
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 14)
                    .background(Color("PurpleColor"))
                    .cornerRadius(6)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    OnboardingView()
}











