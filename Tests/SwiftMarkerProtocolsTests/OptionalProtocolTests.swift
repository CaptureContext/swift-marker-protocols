import Testing
@_spi(Internals) import SwiftMarkerProtocols

@Suite
struct OptionalProtocolTests {
	@Test
	func main() async throws {
		do { // non-nil
			let sut = Container<Int?>(10)
			#expect(sut.isValueNil == false)
			#expect(sut.unwrapped(with: 0).value == 10)
		}

		do { // nil custom init
			let sut = Container<Int?>()
			#expect(sut.isValueNil == true)
			#expect(sut.unwrapped(with: 0).value == 0)
		}

		do { // nil
			let sut = Container<Int?>(nil)
			#expect(sut.isValueNil == true)
			#expect(sut.unwrapped(with: 0).value == 0)
		}

		do { // non-optional APIs are not available
			// let sut = Container<Int>(10)
			// #expect(sut.isValueNil == false)
			// #expect(sut.unwrapped(with: 0).value == 10)
		}
	}
}

private struct Container<T> {
	var value: T

	init(_ value: T) {
		self.value = value
	}
}

extension Container where T: _OptionalProtocol {
	init() {
		self.init(nil)
	}

	var isValueNil: Bool {
		return value.__marker_value == nil
	}

	func unwrapped(with value: T.Wrapped) -> Container<T.Wrapped> {
		.init(self.value.__marker_value ?? value)
	}
}
