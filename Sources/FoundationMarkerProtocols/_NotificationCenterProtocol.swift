#if canImport(Foundation) && !os(WASI)
import Foundation

public protocol _NotificationCenterProtocol: NotificationCenter {}
extension NotificationCenter: _NotificationCenterProtocol {}
#endif
