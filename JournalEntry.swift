import Foundation
import SwiftUI
struct JournalEntry: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var date: String   // dd/MM/yyyy
    var bodyText: String
    var isBookmarked: Bool = false
}
