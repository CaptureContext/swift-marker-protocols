#if canImport(UIKit)
import UIKit

public protocol _UIViewControllerProtocol: UIViewController {}
extension UIViewController: _UIViewControllerProtocol {}

#elseif os(macOS) && canImport(AppKit)
import AppKit

public protocol _NSViewControllerProtocol: NSViewController {}
extension NSViewController: _NSViewControllerProtocol {}
#endif
