import Foundation
import SwiftUI
import Combine

final class NewJournalViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var bodyText: String = ""

    // For discard alert logic
    @Published var originalJournalText: String = ""
    @Published var originalJournalTitle: String = ""
    @Published var showingDiscardAlert: Bool = false

    var today: String {
        let f = DateFormatter(); f.dateFormat = "dd/MM/yyyy"; return f.string(from: Date())
    }

    var canSave: Bool { !(title.isEmpty && bodyText.isEmpty) }

    func saveEntry() -> JournalEntry? {
        guard canSave else { return nil }
        let finalTitle = title.isEmpty ? (bodyText.isEmpty ? "" : "New Journal") : title
        guard !finalTitle.isEmpty || !bodyText.isEmpty else { return nil }
        return JournalEntry(title: finalTitle, date: today, bodyText: bodyText)
    }

    func captureOriginal() {
        if originalJournalText.isEmpty && originalJournalTitle.isEmpty {
            originalJournalText = bodyText
            originalJournalTitle = title
        }
    }

    func shouldShowDiscard() -> Bool { bodyText != originalJournalText || title != originalJournalTitle }
}
