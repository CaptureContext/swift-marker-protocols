#if canImport(AVFoundation)
import AVFoundation

public protocol _AVCaptureDeviceProtocol: AVCaptureDevice {}
extension AVCaptureDevice: _AVCaptureDeviceProtocol {}
#endif
