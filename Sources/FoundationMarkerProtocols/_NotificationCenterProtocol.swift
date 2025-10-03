#if canImport(Foundation)
import Foundation

public protocol _NotificationCenterProtocol: NotificationCenter {}
extension NotificationCenter: _NotificationCenterProtocol {}
#endif
