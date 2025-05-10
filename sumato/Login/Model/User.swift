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
        print("🔑 idToken:", idToken)
        guard let jwt = try? decode(jwt: idToken) else {
            print("❌ couldn’t even decode JWT")
            return nil
        }
        print("📜 JWT claims:", jwt.body)
        guard let id = jwt.subject else {
              print("❌ missing sub")
              return nil
            }

        guard let appUserId = jwt["com.naz_desu.sumato/appUserId"].integer else {
              print("❌ error with appUserId")
              return nil
        }
        guard let nickname = jwt["nickname"].string else {
              print("❌ error with nickname")
              return nil
        }
        guard let name = jwt["name"].string else {
              print("❌ error with name")
              return nil
        }
        guard let picture = jwt["picture"].string else {
              print("❌ error with picture")
              return nil
        }
        guard let updatedAt = jwt["updated_at"].string else {
              print("❌ error with updated_at")
              return nil
        }

        guard let jwt = try? decode(jwt: idToken),
              let id = jwt.subject,
              let appUserId = jwt["com.naz_desu.sumato/appUserId"].integer,
              let nickname = jwt["nickname"].string,
              let name = jwt["name"].string,
              let picture = jwt["picture"].string,
              let updatedAt = jwt["updated_at"].string else {
            print("Returning nil")
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
