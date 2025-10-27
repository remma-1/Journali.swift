import SwiftUI

struct BookmarkedJournalCardView: View {
    @Environment(\.dismiss) var dismiss
    private let titleColor = Color(red: 212/255, green: 200/255, blue: 255/255)

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color(red: 5/255, green: 5/255, blue: 5/255).ignoresSafeArea()

            Text("Bookmarked View Placeholder")
                .foregroundColor(titleColor)
                .padding()
                .frame(width: 350, height: 227)
                .background(Color(red: 28/255, green: 28/255, blue: 30/255))
                .cornerRadius(20)

            Button(action: { dismiss() }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            .padding(10)
        }
        .presentationDetents([.height(250)])
    }
}
