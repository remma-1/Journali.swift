import SwiftUI

struct ContentView: View {
    @State private var showMainApp: Bool = false

    let topColor = Color(red: 20/255, green: 20/255, blue: 32/255)
    let bottomColor = Color.black

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()
                Image("j")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 77.7, height: 101)

                Text("Journali")
                    .font(.system(size: 42, weight: .black))
                    .foregroundColor(.white)
                    .frame(width: 174, height: 50)
                    .minimumScaleFactor(0.5)

                Text("Your thoughts, your story")
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.white)
                    .tracking(1)
                    .frame(width: 225, height: 21)
                Spacer()
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showMainApp) {
            JournalListView()
        }
        .onAppear {
            Task { try? await Task.sleep(for: .seconds(3)); showMainApp = true }
        }
    }
}
