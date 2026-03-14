import Foundation
import ARKit
import Combine

class ARFaceTrackingManager: NSObject, ObservableObject, ARSessionDelegate {
    static let shared = ARFaceTrackingManager()
    
    let session = ARSession()
    private var isTracking = false
    
    @Published var isBlinkingLeft: Bool = false
    @Published var isBlinkingRight: Bool = false
    @Published var isBothBlinking: Bool = false
    
    @Published var headYaw: Float = 0.0 // Rotation left-to-right
    @Published var headPitch: Float = 0.0 // Rotation up-and-down
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    func startTracking() {
        guard ARFaceTrackingConfiguration.isSupported else {
            print("ARFaceTracking is not supported on this device/simulator.")
            return
        }
        
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        isTracking = true
    }
    
    func stopTracking() {
        if isTracking {
            session.pause()
            isTracking = false
        }
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else { return }
        
        // 1. Blend Shapes for Eye Blinking
        let blinkLeft = faceAnchor.blendShapes[.eyeBlinkLeft]?.floatValue ?? 0.0
        let blinkRight = faceAnchor.blendShapes[.eyeBlinkRight]?.floatValue ?? 0.0
        
        let threshold: Float = 0.4
        let leftClosed = blinkLeft > threshold
        let rightClosed = blinkRight > threshold
        
        // 2. Transform for Head Rotation
        let transform = faceAnchor.transform
        // Extract Euler angles (yaw, pitch, roll) from the 4x4 transform matrix
        let yaw = asin(-transform.columns.2.x)
        let pitch = atan2(transform.columns.2.y, transform.columns.2.z)
        
        DispatchQueue.main.async {
            self.isBlinkingLeft = leftClosed
            self.isBlinkingRight = rightClosed
            self.isBothBlinking = leftClosed && rightClosed
            
            self.headYaw = yaw
            self.headPitch = pitch
        }
    }
}
