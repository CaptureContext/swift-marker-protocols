public protocol _OptionalProtocol<Wrapped>: ExpressibleByNilLiteral {
	associatedtype Wrapped

	@_spi(Internals)
	var __marker_value: Optional<Wrapped> { get set }
}

extension Optional: _OptionalProtocol {
	@_spi(Internals)
	public var __marker_value: Optional<Wrapped> {
		get { self }
		set { self = newValue }
	}
}
