#if canImport(AVFoundation) && !os(watchOS)
import AVFoundation

@available(macOS 10.7, iOS 4.0, macCatalyst 14.0, tvOS 17.0, visionOS 1.0, *)
public protocol _AVCaptureDeviceProtocol: AVCaptureDevice {}

@available(macOS 10.7, iOS 4.0, macCatalyst 14.0, tvOS 17.0, visionOS 1.0, *)
extension AVCaptureDevice: _AVCaptureDeviceProtocol {}
#endif
