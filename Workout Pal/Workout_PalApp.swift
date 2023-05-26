import SwiftUI

struct ContentView: View {
    @State private var showSplashScreen = true
    
    var body: some View {
        ZStack {
            if showSplashScreen {
                SplashScreen()
                    .opacity(showSplashScreen ? 1 : 0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeInOut(duration: 1.5)) {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                HomeScreen()
                    .opacity(showSplashScreen ? 0 : 1)
                    .transition(.opacity)
            }
        }
        .environmentObject(ExerciseStore()) // Store ExerciseStore at the ContentView level
    }
}

@main
struct Workout_PalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
