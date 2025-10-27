import Foundation
import SwiftUI
protocol JournalRepository {
    func load() -> [JournalEntry]
    func add(_ entry: JournalEntry)
    func delete(_ ids: Set<UUID>)
    func update(_ entry: JournalEntry)
}

final class InMemoryJournalRepository: JournalRepository {
    private var store: [JournalEntry] = [
        JournalEntry(title: "My Birthday", date: "02/09/2024", bodyText: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh viverra non", isBookmarked: false),
        JournalEntry(title: "Bookmarked Journal", date: "01/09/2024", bodyText: "A different entry to show how the list works. This one might be longer or shorter.", isBookmarked: true),
        JournalEntry(title: "Great day", date: "02/09/2024", bodyText: "I had the best breakfast ever", isBookmarked: true)
    ]

    func load() -> [JournalEntry] { store }

    func add(_ entry: JournalEntry) { store.append(entry) }

    func delete(_ ids: Set<UUID>) { store.removeAll { ids.contains($0.id) } }

    func update(_ entry: JournalEntry) {
        if let i = store.firstIndex(where: { $0.id == entry.id }) { store[i] = entry }
    }
}
