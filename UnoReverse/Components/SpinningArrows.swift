import SwiftUI

struct SpinningArrows: View {
    let rotationAngle = Angle.degrees(360)
    let rotationDuration = 8.0

    var clockwise: Bool

    var icon: String {
        clockwise
        ? "arrow.trianglehead.2.clockwise"
        : "arrow.trianglehead.2.counterclockwise"
    }

    @State private var rotationEffect = Angle.zero

    var body: some View {
        Image(systemName: icon)
            .resizable()
            .scaledToFit()
            .rotationEffect(rotationEffect)
            .foregroundStyle(.white)
            .shadow(color: .black, radius: 5)
            .animation(
                .linear(duration: rotationDuration).repeatForever(autoreverses: false),
                value: rotationEffect
            )
            .onAppear {
                rotationEffect = clockwise ? rotationAngle : -rotationAngle
            }
    }
}

#Preview {
    VStack {
        SpinningArrows(clockwise: true)
        SpinningArrows(clockwise: false)
    }
    .padding(69)
}
