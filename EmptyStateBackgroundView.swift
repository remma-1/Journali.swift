import SwiftUI

struct EmptyStateBackgroundView: View {
    var imageName: String = "book"
    var title: String = "Begin your Journal"
    var subtitle: String = "Craft your personal diary , Tap the plus icon to begin "

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 28/255, green: 28/255, blue: 30/255))
                        .frame(width: 350, height: 227)
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                }
                Text(title)
                    .font(.title2)
                    .foregroundColor(.white)
                Text(subtitle)
                    .foregroundColor(.white.opacity(0.75))
            }
        }
    }
}
