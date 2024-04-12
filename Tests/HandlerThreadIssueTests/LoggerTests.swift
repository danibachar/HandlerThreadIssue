import Foundation
import XCTest

import Logging
import HandlerThreadIssue

final class LoggerTests: XCTestCase {
    
    func test_thread_safety() {
        for _ in 0...100_000 {
            DispatchQueue.global().async {
                logger.metadata = [UUID().uuidString: .string(UUID().uuidString)]
            }
            DispatchQueue.global().async {
                logger.log(level: .error,
                           message: "dummy message",
                           metadata: nil, 
                           source: "",
                           file: #file,
                           function: #function,
                           line: #line)
            }
        }
    }
}
