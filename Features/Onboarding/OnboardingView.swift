//
//  OnboardingView.swift
//  upToDo
//
//  Created by Maxut Consulting on 26/05/2026.
//

import SwiftUI

// MARK: - OnboardingView

/// Displays the onboarding experience shown to
/// first-time users of the application.
///
/// Users can navigate through introductory slides,
/// learn about key application features, skip the
/// onboarding process, or proceed to the welcome
/// screen upon completion.
struct OnboardingView: View {

    // MARK: Properties

    /// Called when the user completes onboarding.
    let onCompleted: () -> Void

    @StateObject
    private var viewModel = OnboardingViewModel()

    // MARK: Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: Skip Button

                HStack {

                    Button {

                        withAnimation {

                            viewModel.currentSlideIndex =
                                viewModel.slides.count - 1
                        }

                    } label: {

                        Text("SKIP")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)

                // MARK: Onboarding Pages

                TabView(
                    selection: $viewModel.currentSlideIndex
                ) {

                    ForEach(
                        Array(viewModel.slides.enumerated()),
                        id: \.offset
                    ) { index, slide in

                        VStack(spacing: 0) {

                            Spacer()
                                .frame(height: 20)

                            // MARK: Slide Illustration

                            Image(slide.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)

                            Spacer()
                                .frame(height: 40)

                            // MARK: Page Indicator

                            OnboardingDots(
                                currentPage: viewModel.currentSlideIndex,
                                totalPages: viewModel.slides.count
                            )

                            Spacer()
                                .frame(height: 60)

                            // MARK: Slide Title

                            Text(slide.title)
                                .font(
                                    .system(
                                        size: 32,
                                        weight: .bold
                                    )
                                )
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)

                            Spacer()
                                .frame(height: 28)

                            // MARK: Slide Description

                            Text(slide.subtitle)
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .padding(.horizontal, 36)

                            Spacer()
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(
                    .page(indexDisplayMode: .never)
                )

                // MARK: Navigation Controls

                HStack {

                    Button {

                        if viewModel.currentSlideIndex > 0 {

                            viewModel.currentSlideIndex -= 1
                        }

                    } label: {

                        Text("BACK")
                            .font(.system(size: 16))
                            .foregroundColor(
                                viewModel.currentSlideIndex == 0
                                ? .clear
                                : .gray
                            )
                    }

                    Spacer()

                    Button {

                        if viewModel.currentSlideIndex <
                            viewModel.slides.count - 1 {

                            withAnimation {

                                viewModel.currentSlideIndex += 1
                            }

                        } else {

                            onCompleted()
                        }

                    } label: {

                        Text(
                            viewModel.currentSlideIndex ==
                            viewModel.slides.count - 1
                            ? "GET STARTED"
                            : "NEXT"
                        )
                        .font(
                            .system(
                                size: 16,
                                weight: .medium
                            )
                        )
                        .foregroundColor(.white)
                        .frame(
                            width:
                                viewModel.currentSlideIndex ==
                                viewModel.slides.count - 1
                                ? 160
                                : 90,
                            height: 48
                        )
                        .background(
                            Color("MildPurple")
                        )
                        .cornerRadius(4)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 34)
            }
        }
    }
}

// MARK: - Preview

#Preview {

    OnboardingView {

        print("Completed")
    }
    .preferredColorScheme(.dark)
}
