@testable import Marvel

final class RouterStub: Router {

    var sceneToReturn: Scene = UIViewControllerMock()
    func makeScene() -> Scene {
        return sceneToReturn
    }
}
