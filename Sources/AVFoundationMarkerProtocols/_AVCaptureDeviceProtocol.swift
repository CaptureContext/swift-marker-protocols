#if canImport(AVFoundation) && !os(watchOS)
import AVFoundation

@available(iOS 4.0, macOS 10.7, macCatalyst 14.0, tvOS 17.0, visionOS 1.0, *)
@available(watchOS, unavailable)
public protocol _AVCaptureDeviceProtocol: AVCaptureDevice {}

@available(iOS 4.0, macOS 10.7, macCatalyst 14.0, tvOS 17.0, visionOS 1.0, *)
@available(watchOS, unavailable)
extension AVCaptureDevice: _AVCaptureDeviceProtocol {}
#endif
