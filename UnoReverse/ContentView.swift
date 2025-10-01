import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .yellow, .green, .blue]

    @State private var clockwise = true
    @State private var iconOpacity = 1.0
    @State private var showingGameSheet = false
    @State private var game: Game?

    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .contentShape(Rectangle())
                    .transition(.opacity)

                HStack {
                    Spacer()
                    Button("", systemImage: "list.bullet.clipboard", action: openGameSheet)
                        .font(.title)
                        .foregroundStyle(.white)
                }
                .padding(50)
            }

            Group {
                // conditionally showing the arrows allows the animation to update when the state changes
                if clockwise {
                    SpinningArrows(clockwise: true)
                } else {
                    SpinningArrows(clockwise: false)
                }
            }
            .padding(69)
            .opacity(iconOpacity)
            .onTapGesture(perform: reverse)
        }
        .ignoresSafeArea()
        .statusBarHidden()
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .sheet(isPresented: $showingGameSheet) {
            if let game {
                ScoreboardView(game: game)
            } else {
                NewGameView(onCreate: { game = $0 })
            }
        }
    }

    func reverse() {
        withAnimation(.easeOut(duration: 0.5)) {
            iconOpacity = 0
        } completion: {
            clockwise.toggle()
            withAnimation(.easeIn(duration: 0.5)) {
                iconOpacity = 1
            }
        }
    }

    func openGameSheet() {
        showingGameSheet = true
    }
}

#Preview {
    ContentView()
}
