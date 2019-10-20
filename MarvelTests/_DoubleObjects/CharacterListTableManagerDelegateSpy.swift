import Foundation
@testable import Marvel

final class CharacterListTableManagerDelegateSpy: CharacterListTableManagerDelegate {
    private(set) var tableDidReachRegionAroundTheEndCalled: Bool = false
    func tableDidReachRegionAroundTheEnd() {
        tableDidReachRegionAroundTheEndCalled = true
    }

    private(set) var tableDidSelectCalled: Bool = false
    private(set) var indexPathPassed: IndexPath? = nil
    func tableDidSelect(at indexPath: IndexPath) {
        tableDidSelectCalled = true
        indexPathPassed = indexPath
    }
}
