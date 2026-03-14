import SwiftUI
import ARKit

struct ARFaceView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView(frame: .zero)
        arView.session = ARFaceTrackingManager.shared.session
        arView.backgroundColor = .clear // Make background clear
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // Updates handled internally by the shared ARSession
    }
}
