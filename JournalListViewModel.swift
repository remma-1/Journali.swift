import SwiftUI
import Combine

final class JournalListViewModel: ObservableObject {
    // MARK: - Input / Output
    @Published private(set) var entries: [JournalEntry] = []
    @Published var searchText: String = ""

    // UI state
    @Published var showDeleteConfirmation = false
    @Published var pendingDeleteIDs: Set<UUID> = []
    @Published var isAddingNewJournal = false
    @Published var isShowingBookmarks = false

    // Sorting state (example: by date desc)
    enum SortOption { case byBookmark, byDate }
    @Published var sort: SortOption = .byDate { didSet { sortEntries() } }

    private let repo: JournalRepository
    private let dateFormatter: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "dd/MM/yyyy"; return f
    }()

    init(repo: JournalRepository = InMemoryJournalRepository()) {
        self.repo = repo
        self.entries = repo.load()
        sortEntries()
    }

    // MARK: - Derived
    var filteredEntries: [JournalEntry] {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return entries }
        return entries.filter { e in
            e.title.lowercased().contains(q) || e.bodyText.lowercased().contains(q)
        }
    }

    // For swipe-to-delete on filtered list: map filtered indices to IDs
    func idsForOffsetsInFiltered(_ offsets: IndexSet) -> Set<UUID> {
        let subset = filteredEntries.enumerated().filter { offsets.contains($0.offset) }.map { $0.element.id }
        return Set(subset)
    }

    // MARK: - Actions
    func add(_ entry: JournalEntry) {
        repo.add(entry)
        entries.append(entry)
        sortEntries()
    }

    func requestDelete(ids: Set<UUID>) {
        pendingDeleteIDs = ids
        showDeleteConfirmation = true
    }

    func confirmDelete() {
        guard !pendingDeleteIDs.isEmpty else { return }
        repo.delete(pendingDeleteIDs)
        entries.removeAll { pendingDeleteIDs.contains($0.id) }
        pendingDeleteIDs.removeAll()
        showDeleteConfirmation = false
    }

    func cancelDelete() {
        pendingDeleteIDs.removeAll()
        showDeleteConfirmation = false
    }

    func toggleBookmark(id: UUID) {
        guard let i = entries.firstIndex(where: { $0.id == id }) else { return }
        entries[i].isBookmarked.toggle()
        repo.update(entries[i])
        sortEntries()
    }

    func sortByBookmark() { sort = .byBookmark }
    func sortByEntryDate() { sort = .byDate }

    private func sortEntries() {
        switch sort {
        case .byBookmark:
            entries.sort { (a, b) -> Bool in
                if a.isBookmarked == b.isBookmarked {
                    // tie-breaker by parsed date desc
                    return parsedDate(a) > parsedDate(b)
                }
                return a.isBookmarked && !b.isBookmarked
            }
        case .byDate:
            entries.sort { parsedDate($0) > parsedDate($1) }
        }
        objectWillChange.send()
    }

    private func parsedDate(_ entry: JournalEntry) -> Date {
        dateFormatter.date(from: entry.date) ?? .distantPast
    }
}
