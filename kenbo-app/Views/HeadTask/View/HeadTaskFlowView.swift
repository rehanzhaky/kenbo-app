import SwiftUI

struct HeadTaskFlowView: View {
    @StateObject private var viewModel: HeadTaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    let questID: String
    
    init(questID: String, onComplete: @escaping (Int) -> Void) {
        self.questID = questID
        _viewModel = StateObject(wrappedValue: HeadTaskViewModel(turnGoal: 10, onComplete: onComplete))
    }
    
    var body: some View {
        Group {
            switch viewModel.currentStep {
            case .announcement:
                HeadTaskAnnouncementView(viewModel: viewModel)
                    .transition(.asymmetric(
                        insertion: .opacity,
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .tracking:
                HeadTaskTrackingView(viewModel: viewModel)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .result:
                HeadTaskResultView(viewModel: viewModel)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .opacity
                    ))
            case .earnXP:
                EarnXPView(
                    questID: questID,
                    userName: UserPreferences.shared.userName,
                    earnedAmount: viewModel.xpEarned,
                    onComplete: viewModel.onComplete
                )
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .animation(.easeInOut(duration: 0.4), value: viewModel.currentStep)
        .onChange(of: viewModel.isDismissed) { dismissed in
            if dismissed { dismiss() }
        }
        .onDisappear {
            viewModel.cancelTracking()
        }
    }
}
