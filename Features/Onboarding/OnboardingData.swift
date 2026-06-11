//
//  OnboardingData.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//

import Foundation

import Foundation

struct OnboardingData {
    
    static let slides: [OnboardingSlide] = [
        OnboardingSlide(
            imageName: "onboard1",
            title: "Manage your tasks",
            description: "You can easily manage all your daily tasks in UpTodo for free"
        ),
        
        OnboardingSlide(
            imageName: "onboard2",
            title: "Create daily routine",
            description: "In UpTodo you can create your personalized routine to stay productive"
        ),
        
        OnboardingSlide(
            imageName: "onboard3",
            title: "Organize your tasks",
            description: "Keep track of your tasks in one place easily"
        )
    ]
}
