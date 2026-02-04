extension _OptionalProtocol {
	@_spi(Internals)
	@available(*, deprecated, renamed: "_optional")
	public var __marker_value: Wrapped? {
		get { self._optional }
		set { self._optional = newValue }
	}
}
