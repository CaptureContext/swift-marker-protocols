#if canImport(UIKit)
import UIKit

@available(iOS 2.0, macCatalyst 13.1, visionOS 1.0, *)
@available(watchOS, unavailable)
public protocol _UIViewControllerProtocol: UIViewController {}

@available(iOS 2.0, macCatalyst 13.1, visionOS 1.0, *)
@available(watchOS, unavailable)
extension UIViewController: _UIViewControllerProtocol {}

#elseif os(macOS) && canImport(AppKit)
import AppKit

public protocol _NSViewControllerProtocol: NSViewController {}
extension NSViewController: _NSViewControllerProtocol {}
#endif
