import JWTDecode

public struct User {
    let id: String
    let appUserId: Int
    let nickname: String
    let name: String
    let picture: String
    let updatedAt: String
}

public extension User {
    init?(from idToken: String) {
        guard let jwt = try? decode(jwt: idToken),
              let id = jwt.subject,
              let appUserId = jwt["com.naz_desu.sumato/appUserId"].integer,
              let nickname = jwt["nickname"].string,
              let name = jwt["name"].string,
              let picture = jwt["picture"].string,
              let updatedAt = jwt["updated_at"].string else {
            return nil
        }
        self.id = id
        self.appUserId = appUserId
        self.nickname = nickname
        self.name = name
        self.picture = picture
        self.updatedAt = updatedAt
    }
}
