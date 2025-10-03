#if canImport(QuartzCore)
import QuartzCore

public protocol _CALayerProtocol: CALayer {}
extension CALayer: _CALayerProtocol {}
#endif
