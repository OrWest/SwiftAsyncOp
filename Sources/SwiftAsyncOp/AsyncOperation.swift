import Foundation

open class AsyncOperation: Operation {
    enum State: String {
        case ready
        case executing
        case finished
        
        var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state: State = .ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    public override var isReady: Bool {
        return state == .ready && super.isReady
    }
    
    public override var isExecuting: Bool {
        return state == .executing
    }
    
    public override var isFinished: Bool {
        return state == .finished || isCancelled
    }
    
    public override var isAsynchronous: Bool {
        return true
    }
    
    public override func main() {
        guard !isCancelled else {
            state = .finished
            print("Cancelled.")
            return
        }
        
        state = .executing
        task()
    }
    
    open func task() {
        // Should be overwritten by subclass
        // When task is completed func finish() have to be called
    }
    
    open func finish() {
        state = .finished
    }
}
