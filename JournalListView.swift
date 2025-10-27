import SwiftUI

struct JournalListView: View {
    @StateObject private var vm = JournalListViewModel()

    // Colors
    private let containerBackgroundColor = Color.black.opacity(0.72)
    private let gradientDark = Color(red: 26/255, green: 26/255, blue: 26/255)
    private let neumorphicTopLight = Color(red: 77/255, green: 77/255, blue: 77/255)
    private let neumorphicBottomDark = Color(red: 38/255, green: 38/255, blue: 38/255)

    var body: some View {
        ZStack {
            containerBackgroundColor
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    headerButtons
                }
                .padding(.horizontal, 20)
                .frame(height: 62)
                
                Group {
                    if vm.filteredEntries.isEmpty {
                        Spacer()
                        VStack(spacing: 9) {
                            Image("book")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 151.39, height: 97.32)
                            
                            
                            Text("Begin Your Journal")
                                .foregroundColor(Color("Color1"))
                                .font(.system(size: 24, weight: .bold))

                            Text("Craft your personal diary, tap the plus icon to begin")
                                .foregroundColor(.secondary)
                                .font(.system(size: 18, weight: .light))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: 282)
                                .kerning(0.6)
                        }
                        Spacer()
                    } else {
                        List {
                            ForEach(vm.filteredEntries) { entry in
                                JournalEntryCardView(
                                    entry: entry,
                                    onToggleBookmark: { vm.toggleBookmark(id: entry.id) }
                                )
                                .listRowBackground(Color(red: 5/255, green: 5/255, blue: 5/255))
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                            }
                            .onDelete { offsets in
                                let ids = vm.idsForOffsetsInFiltered(offsets)
                                vm.requestDelete(ids: ids)
                            }
                        }
                        .listStyle(.plain)
                        .background(Color(red: 5/255, green: 5/255, blue: 5/255))
                        .scrollContentBackground(.hidden)
                    }
                }

                // Search Bar
                NeumorphicLargeBar(gradientDark: gradientDark, topLight: neumorphicTopLight, bottomDark: neumorphicBottomDark) {
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundColor(.white.opacity(0.8)).padding(.leading, 18)
                        TextField("Search", text: $vm.searchText)
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .textFieldStyle(.plain)
                        Image(systemName: "mic.fill").foregroundColor(.white.opacity(0.8)).padding(.trailing, 18)
                    }
                }
                .padding(.bottom, 30)
            }

            // Delete dialog
            if vm.showDeleteConfirmation {
                CustomDeleteConfirmationDialog(
                    deleteAction: vm.confirmDelete,
                    cancelAction: vm.cancelDelete
                )
            }
        }
        .sheet(isPresented: $vm.isAddingNewJournal) {
            NewJournalView(onSave: { entry in vm.add(entry) })
        }
        .sheet(isPresented: $vm.isShowingBookmarks) {
            BookmarkedJournalCardView()
        }
    }

    // MARK: Header Buttons
    private var headerButtons: some View {
        HStack(spacing: 0) {
            Menu {
                Button("Sort by Bookmark") { vm.sortByBookmark() }
                Button("Sort by Entry Date") { vm.sortByEntryDate() }
            } label: {
                Image(systemName: "line.horizontal.3")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                    .frame(width: 52, height: 48)
            }

            Divider().frame(width: 1, height: 30).background(.white.opacity(0.3))

            Button(action: { vm.isAddingNewJournal = true }) {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                    .frame(width: 52, height: 48)
            }
        }
        .frame(width: 104, height: 48)
        .background(
            LinearGradient(colors: [Color.black.opacity(0.4), gradientDark], startPoint: .top, endPoint: .bottom)
        )
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.5), radius: 3, x: 2, y: 2)
        .shadow(color: .white.opacity(0.1), radius: 2, x: -1, y: -1)
    }
}

// MARK: - Neumorphic Large Bar
struct NeumorphicLargeBar<Content: View>: View {
    var gradientDark: Color
    var topLight: Color
    var bottomDark: Color
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .frame(width: 351, height: 48)
            .background(
                LinearGradient(colors: [Color.black.opacity(0.4), gradientDark], startPoint: .top, endPoint: .bottom)
            )
            .clipShape(Capsule())
            .shadow(color: bottomDark.opacity(0.5), radius: 0.25, x: 1, y: 1)
            .shadow(color: topLight.opacity(0.2), radius: 2, x: 2, y: 2)
            .shadow(color: bottomDark.opacity(0.5), radius: 0.25, x: -1, y: -1)
            .shadow(color: topLight.opacity(0.2), radius: 2, x: -2, y: -2)
            .overlay(Capsule().stroke(Color.black.opacity(0.1), lineWidth: 1))
            .blur(radius: 0.5)
    }
}
