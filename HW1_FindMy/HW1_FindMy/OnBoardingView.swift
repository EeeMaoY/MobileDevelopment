//
//  ContentView.swift
//  HW1_FindMy
//
//  Created by zjucvglab509 on 2025/3/9.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("What's New in Find My")
                    .font(.system(size: 42))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding()

                VStack(spacing: 12) {
                    FeatureRow(icon: "slider.horizontal.below.rectangle", title: "Match", description: "Match the gradients by moving the Red, Green and Blue sliders for the left and right colors.")
                    FeatureRow(icon: "plus.forwardslash.minus", title: "Precise", description: "More precision with the steppers to get that 100 score.")
                    FeatureRow(icon: "checkmark.square", title: "Score", description: "A detailed score and comparison of your gradient and the target gradient.")
                }
            }
            .frame(maxHeight: .infinity)

            VStack {
                Spacer()
                Button(action: {
                    print("Continue Button Tapped")
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.49, green: 0.446, blue: 0.969))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
        }
        .frame(maxHeight: .infinity)
    }
}


struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(Color(red: 0.49, green: 0.446, blue: 0.969))
                .font(.system(size: 36))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.bold)
                Text(description)
                    .font(.system(size: 16))
                    .foregroundColor(Color.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
    }
}


#Preview {
    OnBoardingView()
}
