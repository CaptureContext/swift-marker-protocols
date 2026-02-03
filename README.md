# swift-marker-protocols

[![CI](https://github.com/CaptureContext/swift-marker-protocols/actions/workflows/ci.yml/badge.svg)](https://github.com/CaptureContext/swift-marker-protocols/actions/workflows/ci.yml) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FCaptureContext%2Fswift-marker-protocols%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/CaptureContext/swift-marker-protocols) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FCaptureContext%2Fswift-marker-protocols%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/CaptureContext/swift-marker-protocols)

Package that declares empty protocols for base classes of various system frameworks.

## Table of contents

- [Motivation](#motivation)
- [Examples](#examples)
  - [Methods on generic Self](#methods-on-generic-self)
  - [Properties on generic Self](#properties-on-generic-self)
  - [Optionals](#optionals)
- [Products](#products)
- [Installation](#installation)
- [License](#license)

## Motivation

Marker protocols is an approach of partially erasing type constraints for writing generic extensions for types in Swift. 

Such protocols can be required by different packages and declaring them in-place may cause name collisions.

This lightweight package declares a set of core marker protocols to potentially address such collisions.

## Examples

Marker protocols are useful for building type-aware generic extensions.

### Methods on generic Self

#### Without MarkerProtocols

```swift
extension AVCaptureDevice {
  func withExclusiveLock(
    // ❌ `Self` can't be used on non-final class AVCaptureDevice
    perform configuration: (AVCaptureDevice) async -> Void
  ) async throws {
    try self.lockForConfiguration()
    await configuration(self)
    self.unlockForConfiguration()
  }
}

let instance: CustomAVCaptureDevice = .init()
instance.withExlusiveLock { device in
  // ❌ Type of device is erased to AVCaptureDevice
  // not just base AVCaptureDevice
}
```

#### With MarkerProtocols

```swift
import AVFoundationMarkerProtocols

extension _AVCaptureDeviceProtocol {
  func withExclusiveLock(
    // ✅ `Self` can be used on a marker protocol
    perform configuration: (Self) async -> Void
  ) async throws {
    try self.lockForConfiguration()
    await configuration(self)
    self.unlockForConfiguration()
  }
}

let instance: CustomAVCaptureDevice = .init()
instance.withExlusiveLock { device in
  // ✅ Type of device is kept - CustomAVCaptureDevice
}
```

### Properties on generic Self

Lets say you want to build some layout proxy for Cocoa views

- Target API
  ```swift
  view.layout.chain.of.calls()
  ```

- Chainable proxy type
  ```swift
  public struct LayoutProxy<Target: UIView> {
    public let target: Target
  
    internal init(_ target: Target) {
      self.target = target
    }
  }
  ```

#### Without MarkerProtocols

```swift

extension UIView {
  // ❌ `Self` can't be used on non-final class UIView
  // Using this property on any type will always
  // erase a type of the view
  var layout: LayoutProxy<UIView> { .init(self) }
}
```

#### With MarkerProtocols

```swift
extension _UIViewProtocol {
  // ✅ `Self` can be used here and the type
  // of the view is kept at the call site
  var layout: LayoutProxy<Self> { .init(self) }
}
```

### Optionals

```swift
struct GenericContainer<Content> {
  var content: Content
}
```

#### Without MarkerProtocols

```swift
extension GenericContainer {
  // This declaration is completely fine, except
  // of being a bit too verbose
  func unwrapped<Value>(with value: Value) -> GenericContainer<Value>
  where Content == Value {
    .init(content: content ?? value)
  }
  
  // ❌ Won't compile since properties can't be 
  // generic and we can't declare `Value` type here
  var unsafelyUnwrapped: GenericContainer<Value> { /*...*/ }
}
```

#### With MarkerProtocols

```swift
extension GenericContainer where Content: _OptionalProtocol {
  func unwrapped(with value: Value) -> GenericContainer<Value> {
    .init(with: content.__marker_value ?? value)
  }
  
  var unsafelyUnwrapped: GenericContainer<Content.Wrapped> {
    get { .init(content: content.__marker_value!) }
    set { self.content = newValue.content }
  }
}
```

## Products

#### SwiftMarkerProtocols

- `_OptionalProtocol<Wrapped>`
- `_AnyKeyPathProtocol` - alternative to `Swift._AppendKeyPath` protocol

#### QuartzCoreMarkerProtocols

- `_CALayerProtocol`
- Exports `FoundationMarkerProtocols`

#### AVFoundationMarkerProtocols

- `_AVCaptureDeviceProtocol`
- Exports `FoundationMarkerProtocols`

#### FoundationMarkerProtocols

- `_NotificationCenterProtocol`
- Exports `SwiftMarkerProtocols`

#### CocoaMarkerProtocols

- `_UIViewProtocol` / `_NSViewProtocol`
- `_UIViewControllerProtocol` / `_NSViewControllerProtocol`
- Exports `FoundationMarkerProtocols`

> [!TIP]
>
> - `UIKit` is basically a **Cocoa**Touch framework
> - `AppKit` is basically **Cocoa** framework without `CoreData`
>
> Both frameworks could have shared `Cocoa` prefix for their types, so [capturecontext/cocoa-aliases](https://github.com/capturecontext/cocoa-aliases) package provides `Cocoa`-prefixed aliases for `UI`/`NS` prefixed Cocoa types, it also exports aliased `_CocoaViewProtocol` and `_CocoaViewControllerProtocol` marker protocols.

#### MarkerProtocols

This is an umbrella product that exports all available marker protocols.

## Installation

Primary targets for this package are other packages

```swift
.package(
  url: "https://github.com/capturecontext/swift-marker-protocols.git", 
  .upToNextMajor(from: "1.1.0")
)
```

Do not forget about target dependencies:

```swift
.product(
  name: "MarkerProtocols", 
  package: "swift-marker-protocols"
)
```

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
