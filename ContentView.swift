import SwiftUI

struct ContentView: View {
    @State private var progress: Double = 0.0
    @State private var isLoading: Bool = true
    @State private var showLoadingOverlay: Bool = true

    private let targetUrl = URL(string: "https://rdmns.hesn.xyz")!

    var body: some View {
        ZStack {
            // Fullscreen Edge-to-Edge WebView
            WebView(url: targetUrl, progress: $progress, isLoading: $isLoading)
                .ignoresSafeArea()

            // Sleek Animated Loading Overlay with Percentage Counter
            if showLoadingOverlay {
                VStack(spacing: 24) {
                    Spacer()

                    // App Logo Icon
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.blue)

                    // Animated Progress Ring & Percentage Counter
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 8)
                            .frame(width: 130, height: 130)

                        Circle()
                            .trim(from: 0.0, to: CGFloat(progress))
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                            .frame(width: 130, height: 130)
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 0.2), value: progress)

                        Text("\(Int(progress * 100))%")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundColor(Color.blue)
                    }

                    Text("Loading Rdmns...")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(UIColor.systemBackground))
                .ignoresSafeArea()
                .transition(.opacity)
                .onChange(of: progress) { newProgress in
                    if newProgress >= 1.0 {
                        withAnimation(.easeOut(duration: 0.4)) {
                            showLoadingOverlay = false
                        }
                    }
                }
            }
        }
        .onAppear {
            AutoUpdater.shared.checkForUpdates()
        }
    }
}
