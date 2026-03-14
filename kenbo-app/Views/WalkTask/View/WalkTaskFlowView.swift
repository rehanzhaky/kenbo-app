import SwiftUI

struct WalkTaskFlowView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: WalkTaskViewModel
    
    init(onComplete: @escaping (Int) -> Void) {
        _viewModel = StateObject(wrappedValue: WalkTaskViewModel(onComplete: onComplete))
    }
    
    var body: some View {
        ZStack {
            // Steps router
            switch viewModel.currentStep {
            case .announcement:
                WalkTaskAnnouncementView(viewModel: viewModel)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .tracking:
                WalkTaskTrackingView(viewModel: viewModel)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .result:
                WalkTaskResultView(viewModel: viewModel)
                    .transition(.opacity.combined(with: .scale))
            case .earnXP:
                EarnXPView(
                    questID: "quest_walk",
                    userName: UserPreferences.shared.userName,
                    earnedAmount: viewModel.xpEarned,
                    onComplete: viewModel.onComplete
                )
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .animation(.easeInOut, value: viewModel.currentStep)
        .onChange(of: viewModel.isDismissed) { _, newValue in
            if newValue {
                dismiss()
            }
        }
        // If user actively swipes away the fullScreenCover instead of using the buttons
        .onDisappear {
            viewModel.cancelTask()
        }
    }
}
