//
//   OnboardingViewModel.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//


import Foundation
import Combine

final class OnboardingViewModel: ObservableObject {
   
    @Published var  slides = OnboardingData.slides
}

