import Foundation
import Logging

private struct DummyLogHandler: LogHandler {
    subscript(metadataKey key: String) -> Logging.Logger.Metadata.Value? {
        get {
            return metadata[key]
        }
        set(newValue) {
            metadata[key] = newValue
        }
    }
    
    public var metadata = Logger.Metadata()
    public var logLevel: Logger.Level = .info
    
    func log(level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, source: String, file: String, function: String, line: UInt) {
        
        let metadataWithCodeContext = self.metadata
            .merging(metadata ?? [:], uniquingKeysWith: { $1 })
            .mapValues(\.description)
            .merging([
                "source": source,
                "file": file,
                "function": function,
                "line": String(line),
            ], uniquingKeysWith: { $1 })
        
        print("DB: context \(metadataWithCodeContext), Thread \(Thread.current.name)")
        
    }
}

public var logger: LogHandler = {
    MultiplexLogHandler([
        DummyLogHandler()
    ])
}()
