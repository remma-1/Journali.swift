import SwiftUI

struct CustomDeleteConfirmationDialog: View {
    var deleteAction: () -> Void
    var cancelAction: () -> Void

    private let alertBgColor = Color(red: 28/255, green: 28/255, blue: 30/255)
    private let bodyTextColor = Color.white.opacity(0.8)
    private let deleteBtnColor = Color.red
    private let cancelBtnBgColor = Color(red: 40/255, green: 40/255, blue: 40/255)

    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture { cancelAction() }

            VStack(spacing: 0) {
                VStack(spacing: 5) {
                    Text("Delete Journal?")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                    Text("Are you sure you want to delete this journal?")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(bodyTextColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .padding(.top, 20)
                .padding(.bottom, 20)

                HStack(spacing: 10) {
                    Button(action: cancelAction) {
                        Text("Cancel")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 50)
                    .background(cancelBtnBgColor)
                    .foregroundColor(.white)
                    .cornerRadius(25)

                    Button(action: deleteAction) {
                        Text("Delete")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 50)
                    .background(deleteBtnColor)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
            }
            .frame(width: 320)
            .background(alertBgColor)
            .cornerRadius(15)
            .shadow(radius: 10)
        }
    }
}
