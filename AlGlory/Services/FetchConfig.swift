
import Foundation
import FirebaseRemoteConfig

final class FetchConfig {

    static func fetchMissionVersion() async throws -> Int {

        let remoteConfig = RemoteConfig.remoteConfig()

        // Provide fallback values
        let defaults: [String: NSObject] = [
            "missionVersion": 1 as NSNumber
        ]

        remoteConfig.setDefaults(defaults)

        // Fetch and activate remote configuration
        let status = try await remoteConfig.fetchAndActivate()

        dump("Remote Config status: \(status)")

        // Read the activated configuration value
        let missionVersion = remoteConfig
            .configValue(forKey: "missionVersion")
            .numberValue
            .intValue
dump(missionVersion)
        return missionVersion
    }
    
    static func fetchQuestionVersion() async throws -> Int {

        let remoteConfig = RemoteConfig.remoteConfig()

        // Provide fallback values
        let defaults: [String: NSObject] = [
            "QuestionVersion": 1 as NSNumber
        ]

        remoteConfig.setDefaults(defaults)

        // Fetch and activate remote configuration
        let status = try await remoteConfig.fetchAndActivate()

        dump("Remote Config status: \(status)")

        // Read the activated configuration value
        let questionVersion = remoteConfig
            .configValue(forKey: "QuestionVersion")
            .numberValue
            .intValue

        return questionVersion
    }
}
