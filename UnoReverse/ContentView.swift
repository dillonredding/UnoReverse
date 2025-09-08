import SwiftUI

struct ContentView: View {
    let darkPallette: [Color] = [.orange, .teal, .purple, .pink]
    let lightPallette: [Color] = [.red, .yellow, .green, .blue]

    var isDark: Bool { colorScheme == .dark }
    var colors: [Color] { isDark ? darkPallette : lightPallette }
    var primary: Color { isDark ? .black : .white }
    var shadow: Color { isDark ? .white : .black }

    var icon: String {
        clockwise
        ? "arrow.trianglehead.2.clockwise"
        : "arrow.trianglehead.2.counterclockwise"
    }

    @State private var colorScheme: ColorScheme
    @State private var color: Color
    @State private var clockwise = true
    @State private var angle = 0.0

    var body: some View {
        ZStack {
            ZStack(alignment: .bottomTrailing) {
                color.contentShape(Rectangle())
                    .clipShape(.rect(cornerRadius: 50))
                    .padding(20)
                    .background(primary)
                    .transition(.opacity)

                Button("", systemImage: "lightbulb.fill", action: toggleColorScheme)
                    .offset(x: -50, y: -50)
                    .font(.title)
                    .foregroundStyle(primary)
            }

            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 69)
                .foregroundStyle(primary)
                .shadow(color: shadow, radius: 5)
                .rotationEffect(.degrees(angle))
                .transition(.opacity)
        }
        .ignoresSafeArea()
        .statusBarHidden()
        .onTapGesture(perform: reverse)
        .onAppear {
            rotate()
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }

    init(initialColorScheme: ColorScheme) {
        colorScheme = initialColorScheme
        color = initialColorScheme == .dark
              ? darkPallette.randomElement()!
              : lightPallette.randomElement()!
    }

    func reverse() {
        withAnimation(.linear) {
            clockwise.toggle()
            color = nextColor()
            rotate()
        }
    }

    func rotate() {
        angle = 0
        withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
            angle = clockwise ? 360 : -360
        }
    }

    func nextColor() -> Color {
        if let index = colors.firstIndex(of: color) {
            return colors[(index + 1) % colors.count]
        } else {
            return color
        }
    }

    func toggleColorScheme() {
        let index = colors.firstIndex(of: color)!
        withAnimation {
            colorScheme = isDark ? .light : .dark
            color = colors[index]
        }
    }
}

#Preview {
    ContentView(initialColorScheme: .light)
}
