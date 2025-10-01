import SwiftUI

struct Arc: Animatable, Shape {
    var startAngle: Angle
    var endAngle: Angle

    var animatableData: CGFloat {
        get { endAngle.degrees }
        set { endAngle = .degrees(newValue) }
    }

    func path(in rect: CGRect) -> Path {
        let angleAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - angleAdjustment
        let modifiedEnd = endAngle - angleAdjustment

        var path = Path()

        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2,
            startAngle: modifiedStart,
            endAngle: modifiedEnd,
            clockwise: false
        )

        return path
    }
}
