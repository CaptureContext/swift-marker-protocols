#if canImport(QuartzCore)
import QuartzCore

@available(iOS 2.0, macOS 10.5, macCatalyst 13.1, tvOS 9.0, visionOS 1.0, *)
@available(watchOS, unavailable)
public protocol _CALayerProtocol: CALayer {}

@available(iOS 2.0, macOS 10.5, macCatalyst 13.1, tvOS 9.0, visionOS 1.0, *)
@available(watchOS, unavailable)
extension CALayer: _CALayerProtocol {}
#endif
