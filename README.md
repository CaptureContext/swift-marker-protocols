# swift-marker-protocols

Package that declares empty protocols for base classes of various system frameworks.

### Motivation

Those protocols are useful for building type-aware generic extensions.

```swift
// Generic function example
import AVFoundationMarkerProtocols

extension _AVCaptureDeviceProtocol {
  func withExclusiveLock(
    // In this context Self can only be used when
    // extending marker protocol, the type is kept
    // at the call site
    perform configuration: (Self) async -> Void
  ) async throws {
    try self.lockForConfiguration()
    await configuration(self)
    self.unlockForConfiguration()
  }
}

let instance: CustomAVCaptureDevice = .init()
instance.withExlusiveLock { device in
  // type of device is kept and it's CustomAVCaptureDevice
  // not just base AVCaptureDevice
}
```

```swift
// Generic proxy example
import CocoaMarkerProtocols

public struct LayoutProxy<Target: UIView> {
  public let target: Target
  
  internal init(_ target: Target) {
    self.target = target
  }
}

extension _UIViewProtocol {
  // In this context Self can only be used when
  // extending marker protocol, the type is kept
  // at the call site
  var layout: LayoutProxy<Self> { .init(self) }
}
```

And since those protocols have pretty generic names it may cause collisions for different dependencies that do use same strategy, this package allows other packages to build their extensions on top of shared protocol declarations

## Installation

Primary targets for this package are other packages

```swift
.package(
  url: "https://github.com/capturecontext/swift-marker-protocols.git", 
  .upToNextMajor(from: "1.0.0")
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
