#if canImport(UIKit)
import UIKit

@available(iOS 2.0, macCatalyst 13.1, visionOS 1.0, *)
@available(watchOS, unavailable)
public protocol _UIViewProtocol: UIView {}

@available(iOS 2.0, macCatalyst 13.1, visionOS 1.0, *)
@available(watchOS, unavailable)
extension UIView: _UIViewProtocol {}

#elseif os(macOS) && canImport(AppKit)
import AppKit

public protocol _NSViewProtocol: NSView {}
extension NSView: _NSViewProtocol {}
#endif
