public protocol _OptionalProtocol<Wrapped>: ExpressibleByNilLiteral {
	associatedtype Wrapped

	@inlinable
	var _optional: Wrapped? { get set }
}

extension Optional: _OptionalProtocol {
	@inlinable
	public var _optional: Optional<Wrapped> {
		get { self }
		set { self = newValue }
	}
}
