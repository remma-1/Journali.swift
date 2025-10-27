import SwiftUI

struct NewJournalView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = NewJournalViewModel()

    var onSave: (JournalEntry) -> Void

    // Button colors & styles
    private let saveGradientEnd = Color(red: 127/255, green: 129/255, blue: 255/255)
    private let cancelGradientEnd = Color(red: 26/255, green: 26/255, blue: 26/255)
    private let saveIconColor = Color(red: 13/255, green: 13/255, blue: 13/255)
    private let cancelIconColor = Color.white
    private let neumorphicButtonTopLight = Color(red: 77/255, green: 77/255, blue: 77/255)
    private let neumorphicButtonBottomDark = Color(red: 38/255, green: 38/255, blue: 38/255)

    // Content colors
    private let viewBackgroundColor = Color(red: 5/255, green: 5/255, blue: 5/255)
    private let mainTitleColor = Color(red: 62/255, green: 62/255, blue: 62/255)
    private let dateGrayColor = Color(red: 163/255, green: 154/255, blue: 154/255)
    private let placeholderColor = Color(red: 79/255, green: 79/255 ,blue: 79/255)
    private let bodyTextColor = Color.white.opacity(0.8)

    var body: some View {
        ZStack {
            viewBackgroundColor.ignoresSafeArea()

            VStack(spacing: 0) {
                // Top buttons
                HStack {
                    Button {
                        if vm.shouldShowDiscard() { vm.showingDiscardAlert = true } else { dismiss() }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 15.65, weight: .medium))
                            .foregroundColor(cancelIconColor)
                    }
                    .buttonStyle(NeumorphicCircleButtonStyle(
                        gradientEndColor: cancelGradientEnd,
                        topShadowColor: neumorphicButtonTopLight,
                        bottomShadowColor: neumorphicButtonBottomDark
                    ))

                    Spacer()

                    Button { saveJournal() } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 18.64, weight: .medium))
                            .foregroundColor(saveIconColor)
                    }
                    .buttonStyle(NeumorphicCircleButtonStyle(
                        gradientEndColor: saveGradientEnd,
                        topShadowColor: neumorphicButtonTopLight,
                        bottomShadowColor: neumorphicButtonBottomDark
                    ))
                    .disabled(!vm.canSave)
                }
                .padding(.horizontal)
                .padding(.top, 15)
                .padding(.bottom, 10)

                // Content
                VStack(alignment: .leading, spacing: 5) {
                    TextField("Title", text: $vm.title)
                        .font(.system(size: 34, weight: .bold))
                        .tint(saveGradientEnd)
                        .foregroundColor(mainTitleColor)
                        .onSubmit { saveJournal() }

                    Text(vm.today)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(dateGrayColor)

                    ZStack(alignment: .topLeading) {
                        if vm.bodyText.isEmpty {
                            Text("Type your Journal...")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(placeholderColor)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                                .allowsHitTesting(false)
                        }
                        TextEditor(text: $vm.bodyText)
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(bodyTextColor)
                            .scrollContentBackground(.hidden)
                            .frame(maxHeight: .infinity)
                    }
                }
                .padding()
            }
        }
        .onAppear { vm.captureOriginal() }
        .overlay(
            Group {
                if vm.showingDiscardAlert {
                    DiscardChangesAlertView(
                        discardAction: { dismiss() },
                        keepEditingAction: { vm.showingDiscardAlert = false }
                    )
                }
            }
        )
    }

    private func saveJournal() {
        guard let newEntry = vm.saveEntry() else { return }
        onSave(newEntry)
        dismiss()
    }
}
