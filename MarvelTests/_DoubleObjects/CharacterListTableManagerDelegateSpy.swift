import Foundation
@testable import Marvel

final class CharacterListTableManagerDelegateSpy: CharacterListTableManagerDelegate {
    private(set) var tableDidReachRegionAroundTheEndCalled: Bool = false
    func tableDidReachRegionAroundTheEnd() {
        tableDidReachRegionAroundTheEndCalled = true
    }

    private(set) var tableDidSelectCalled: Bool = false
    private(set) var indexPassed: Int? = nil
    func tableDidSelect(at index: Int) {
        tableDidSelectCalled = true
        indexPassed = index
    }
}
