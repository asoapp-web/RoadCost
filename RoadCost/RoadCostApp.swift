import SwiftUI

@main
struct RoadCostApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView()
                        .transition(.opacity)
                        .zIndex(2)
                } else if !hasCompletedOnboarding {
                    OnboardingView()
                        .transition(.opacity)
                        .zIndex(1)
                } else {
                    MainTabView()
                        .transition(.opacity)
                        .zIndex(0)
                }
            }
            .onAppear {
                // Always show splash for 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showSplash = false
                    }
                }
            }
        }
    }
}
