import SwiftUI

struct NeumorphicCircleButtonStyle: ButtonStyle {
    var gradientEndColor: Color
    var topShadowColor: Color
    var bottomShadowColor: Color

    let innerShadowLight = Color(red: 77/255, green: 77/255, blue: 77/255)
    let innerShadowDark = Color(red: 38/255, green: 38/255, blue: 38/255)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 44, height: 44)
            .background(
                LinearGradient(colors: [Color.black.opacity(0.4), gradientEndColor], startPoint: .top, endPoint: .bottom)
            )
            .clipShape(Circle())
            .shadow(color: innerShadowDark, radius: 1, x: 1, y: 1)
            .shadow(color: innerShadowLight, radius: 1, x: -1, y: -1)
            .overlay(Circle().stroke(Color.black.opacity(0.1), lineWidth: 1))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
