import SwiftUI

struct ScoreProgressRing: View {
    var score: Int
    var scoreLimit: Int

    var endAngle: Angle {
        .degrees(360.0 * Double(score) / Double(scoreLimit))
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(.secondary, lineWidth: 2)
            Arc(startAngle: .zero, endAngle: endAngle)
                .stroke(.blue, style: .init(lineWidth: 4, lineCap: .round))
            Text("\(score)")
                .contentTransition(.numericText())
        }
    }
}

#Preview {
    ScoreProgressRing(score: 250, scoreLimit: 500)
        .font(.largeTitle)
}
