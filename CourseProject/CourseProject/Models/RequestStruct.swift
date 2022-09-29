
import Foundation



struct TokenModel: Codable {
    let success: Bool
    let expiresAt, requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
