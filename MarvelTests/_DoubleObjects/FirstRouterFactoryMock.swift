@testable import Marvel

final class FirstRouterFactoryMock: FirstRouterFactory {
    override func createRouter(with navigator: Navigator) -> Router {
        return RouterStub()
    }
}
