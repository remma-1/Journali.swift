import SwiftUI

struct JournalEntryCardView: View {
    let entry: JournalEntry
    var onToggleBookmark: () -> Void

    private let titleColor = Color(red: 212/255, green: 200/255, blue: 255/255)
    private let dateColor = Color(red: 159/255, green: 159/255, blue: 159/255)
    private let bodyColor = Color.white
    private let cardBackgroundColor = Color(red: 28/255, green: 28/255, blue: 30/255)

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(titleColor)
                        .frame(width: 132, height: 29, alignment: .leading)

                    Text(entry.date)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(dateColor)
                        .frame(width: 77, height: 16, alignment: .leading)
                }

                Spacer()

                Button(action: onToggleBookmark) {
                    Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(titleColor)
                        .frame(width: 25, height: 29)
                }
            }

            Text(entry.bodyText)
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(bodyColor)
                .frame(width: 295, height: 105, alignment: .top)
                .lineLimit(5)
                .multilineTextAlignment(.leading)
        }
        .padding(20)
        .frame(width: 350, height: 227)
        .background(cardBackgroundColor)
        .cornerRadius(20)
    }
}
