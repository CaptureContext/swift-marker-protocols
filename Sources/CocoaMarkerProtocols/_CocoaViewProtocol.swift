#if canImport(UIKit)
import UIKit

public protocol _UIViewProtocol: UIView {}
extension UIView: _UIViewProtocol {}

#elseif os(macOS) && canImport(AppKit)
import AppKit

public protocol _NSViewProtocol: NSView {}
extension NSView: _NSViewProtocol {}
#endif
