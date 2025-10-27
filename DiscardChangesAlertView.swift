import SwiftUI

struct DiscardChangesAlertView: View {
    var discardAction: () -> Void
    var keepEditingAction: () -> Void

    private let alertBgColor = Color(red: 28/255, green: 28/255, blue: 30/255)
    private let bodyTextColor = Color.white.opacity(0.68)
    private let discardBtnTextColor = Color(red: 235/255, green: 90/255, blue: 90/255)
    private let btnBgColor = Color(red: 118/255, green: 118/255, blue: 128/255).opacity(0.24)

    var body: some View {
        Color.black.opacity(0.6).ignoresSafeArea()
        VStack(spacing: 0) {
            VStack(spacing: 10) {
                Text("Are you sure you want to discard changes on this journal?")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(bodyTextColor)
                    .multilineTextAlignment(.leading)
                    .frame(width: 252, height: 44, alignment: .leading)
            }
            .frame(width: 268, height: 76, alignment: .top)
            .padding(.top, 20)

            VStack(spacing: 8) {
                Button(action: discardAction) {
                    Text("Discard Changes").font(.system(size: 17, weight: .semibold)).foregroundColor(discardBtnTextColor).frame(maxWidth: .infinity)
                }
                .frame(height: 48).background(btnBgColor).cornerRadius(24)

                Button(action: keepEditingAction) {
                    Text("Keep Editing").font(.system(size: 17, weight: .semibold)).foregroundColor(.white).frame(maxWidth: .infinity)
                }
                .frame(height: 48).background(btnBgColor).cornerRadius(24)
            }
            .frame(width: 272)
            .padding(.top, 16)
            .padding(.bottom, 20)
        }
        .frame(width: 300, height: 212)
        .background(alertBgColor)
        .cornerRadius(34)
    }
}
