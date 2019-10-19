import XCTest
@testable import Marvel

final class CharacterListViewElementsTests: XCTestCase {

    private let frameStub = CGRect.fixtureRamdom
    private lazy var sut: CharacterListViewElements = .init(parentFrame: frameStub)

    func testTableView() {
        let e = sut.tableView
        XCTAssertTrue(e.autoresizingMask.contains(.flexibleHeight))
        XCTAssertTrue(e.autoresizingMask.contains(.flexibleWidth))
        XCTAssertEqual(e.frame, frameStub)
    }

    func testSpinner() {
        let e = sut.spinner
        XCTAssertTrue(e.autoresizingMask.contains(.flexibleHeight))
        XCTAssertTrue(e.autoresizingMask.contains(.flexibleWidth))
        XCTAssertEqual(e.frame, frameStub)
        XCTAssertEqual(e.hidesWhenStopped, true)
    }

    func testRetryButton() {
        let e = sut.retryButton
        XCTAssertEqual(e.backgroundColor, .clear)
        XCTAssertEqual(e.title(for: .normal), "Try again")
        XCTAssertEqual(e.titleColor(for: .normal), .darkGray)
        XCTAssertEqual(e.titleColor(for: .highlighted), .lightGray)
        XCTAssertEqual(e.layer.cornerRadius, 8)
        XCTAssertEqual(e.layer.borderColor, UIColor.darkGray.cgColor)
        XCTAssertEqual(e.layer.borderWidth, 1)
        XCTAssertTrue(e.hasActiveAnchor(.width, 160))
        XCTAssertTrue(e.hasActiveAnchor(.height, 44))
    }

    func testRetryLabel() {
        let e = sut.retryLabel
        XCTAssertEqual(e.text, "Ops, something is wrong. I\'ve called for the Heroes, but nobody answered. =[")
        XCTAssertEqual(e.textColor, .darkGray)
        XCTAssertEqual(e.textAlignment, .center)
        XCTAssertEqual(e.numberOfLines, 0)
        XCTAssertEqual(e.lineBreakMode, .byWordWrapping)
    }

    func testRetryStack() {
        let e = sut.retryStack
        XCTAssertEqual(e.arrangedSubviews.count, 2)
        XCTAssertEqual(e.arrangedSubviews[safe: 0], sut.retryLabel)
        XCTAssertEqual(e.arrangedSubviews[safe: 1], sut.retryButton)
        XCTAssertEqual(e.axis, .vertical)
        XCTAssertEqual(e.spacing, 20)
        XCTAssertEqual(e.alignment, .center)
    }

    func testEmptyFeedbackLabel() {
        let e = sut.emptyFeedbackLabel
        XCTAssertEqual(e.text, "There are no Heroes to show. This is the real life.")
        XCTAssertEqual(e.textColor, .darkGray)
        XCTAssertEqual(e.textAlignment, .center)
        XCTAssertEqual(e.numberOfLines, 0)
        XCTAssertEqual(e.lineBreakMode, .byWordWrapping)
    }
}

private extension CGRect {
    static var fixtureRamdom: Self {
        return .init(
            x: .random(in: 0...9),
            y: .random(in: 0...9),
            width: .random(in: 0...9),
            height: .random(in: 0...9)
        )
    }
}
