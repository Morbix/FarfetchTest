import XCTest
@testable import Marvel

final class CharacterListTableManagerScrollDelegateTests: CharacterListTableManagerBaseTestCase {

    func testWhenContentSizeIsLessThanTable() throws {
        let contentHeight = try XCTUnwrap((0..<100).randomElement())
        tableSpy.frame = CGRect(x: 0, y: 0, width: 10, height: 100)
        tableSpy.contentSize = CGSize(width: 10, height: contentHeight)

        sut.scrollViewDidScroll(tableSpy)

        XCTAssertEqual(delegateSpy.tableDidReachRegionAroundTheEndCalled, false)
    }

    func testWhenOffsetIsNotCloseToTheContentEnd1() throws {
        let scrollPosition = try XCTUnwrap((0..<80).randomElement())
        tableSpy.frame = CGRect(x: 0, y: 0, width: 10, height: 100)
        tableSpy.contentSize = CGSize(width: 10, height: 200)
        tableSpy.contentOffset = CGPoint(x: 0, y: scrollPosition)

        sut.scrollViewDidScroll(tableSpy)

        XCTAssertEqual(delegateSpy.tableDidReachRegionAroundTheEndCalled, false, "scrollPosition: \(scrollPosition)")
    }

    func testWhenOffsetIsNotCloseToTheContentEnd2() throws {
        let scrollPosition = try XCTUnwrap((0..<800).randomElement())
        tableSpy.frame = CGRect(x: 0, y: 0, width: 10, height: 1000)
        tableSpy.contentSize = CGSize(width: 10, height: 2000)
        tableSpy.contentOffset = CGPoint(x: 0, y: scrollPosition)

        sut.scrollViewDidScroll(tableSpy)

        XCTAssertEqual(delegateSpy.tableDidReachRegionAroundTheEndCalled, false, "scrollPosition: \(scrollPosition)")
    }

    func testWhenOffsetIsCloseToTheContentEnd1() throws {
        let scrollPosition = try XCTUnwrap((80..<100).randomElement())
        tableSpy.frame = CGRect(x: 0, y: 0, width: 10, height: 100)
        tableSpy.contentSize = CGSize(width: 10, height: 200)
        tableSpy.contentOffset = CGPoint(x: 0, y: scrollPosition)

        sut.scrollViewDidScroll(tableSpy)

        XCTAssertEqual(delegateSpy.tableDidReachRegionAroundTheEndCalled, true, "scrollPosition: \(scrollPosition)")
    }

    func testWhenOffsetIsCloseToTheContentEnd2() throws {
        let scrollPosition = try XCTUnwrap((800..<1000).randomElement())
        tableSpy.frame = CGRect(x: 0, y: 0, width: 10, height: 1000)
        tableSpy.contentSize = CGSize(width: 10, height: 2000)
        tableSpy.contentOffset = CGPoint(x: 0, y: scrollPosition)

        sut.scrollViewDidScroll(tableSpy)

        XCTAssertEqual(delegateSpy.tableDidReachRegionAroundTheEndCalled, true, "scrollPosition: \(scrollPosition)")
    }

}
