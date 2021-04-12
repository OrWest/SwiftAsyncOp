import XCTest
@testable import SwiftAsyncOp

final class SwiftAsyncOpTests: XCTestCase {

    func testIsReady() {
        let op = AsyncOperation()
        XCTAssertTrue(op.isReady)
    }

    func testIsReadyChangedNotification() {
        let op = AsyncOperation()

        let exp = expectation(description: "isReady observer")
        let observer = op.observe(\.isReady) { object, change in
            XCTAssertFalse(object.isReady)
            XCTAssertTrue(object.isExecuting)
            XCTAssertFalse(object.isFinished)
            exp.fulfill()
        }

        op.state = .executing

        wait(for: [exp], timeout: 0.5)

        observer.invalidate()
    }

    func testIsExecuting() {
        let op = AsyncOperation()
        XCTAssertFalse(op.isExecuting)
    }

    func testIsExecutingChangedNotification() {
        let op = AsyncOperation()

        let exp = expectation(description: "isExecuting observer")
        let observer = op.observe(\.isExecuting) { object, change in
            XCTAssertFalse(object.isReady)
            XCTAssertTrue(object.isExecuting)
            XCTAssertFalse(object.isFinished)
            exp.fulfill()
        }

        op.state = .executing

        wait(for: [exp], timeout: 0.5)

        observer.invalidate()
    }

    func testIsFinished() {
        let op = AsyncOperation()
        XCTAssertFalse(op.isFinished)
    }

    func testIsFinishedChangedNotification() {
        let op = AsyncOperation()

        let exp = expectation(description: "isFinished observer")
        let observer = op.observe(\.isFinished) { object, change in
            XCTAssertFalse(object.isReady)
            XCTAssertFalse(object.isExecuting)
            XCTAssertTrue(object.isFinished)
            exp.fulfill()
        }

        op.state = .finished

        wait(for: [exp], timeout: 0.5)

        observer.invalidate()
    }

    func testIsAsynchronous() {
        let op = AsyncOperation()
        XCTAssertTrue(op.isAsynchronous)
    }

    func testMain() {
        let op = AsyncOperationMock()

        op.main()

        XCTAssertEqual(op.state, .executing)
        XCTAssertTrue(op.taskWasCalled)
    }

    func testMainCancelled() {
        let op = AsyncOperationMock()
        op.cancel()

        op.main()

        XCTAssertEqual(op.state, .finished)
        XCTAssertFalse(op.taskWasCalled)
    }

    func testFinish() {
        let op = AsyncOperation()
        op.finish()

        XCTAssertEqual(op.state, .finished)
    }
}

private class AsyncOperationMock: AsyncOperation {
    var taskWasCalled = false

    override func task() {
        super.task()

        taskWasCalled = true
    }
}
