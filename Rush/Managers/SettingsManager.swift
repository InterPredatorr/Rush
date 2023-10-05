//
//  SettingsManager.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct AppSettingsModel: Codable {
    let settings: AppSettings
}

struct AppSettings: Codable {
    let splash: SplashConfig
    let login: LoginConfig
    let forgotPassword: ForgotPasswordConfig
    let signup: SignupConfig
    let journey: JourneyConfig
    let buyCoins: BuyCoinsConfig
}

struct BuyCoinsConfig: Codable {
    let title: String
    let subtitle: String
    let description: String
    let tokenBalanceTitle: String
    var options: [BuyCoinsOption]
    
    struct BuyCoinsOption: Codable, Hashable {
        let title: String
        let count: Int
        var cost: Double
    }
}

struct LoginConfig: Codable {
    var email: TextFieldConfig
    var password: TextFieldConfig
    var confirmPassword: TextFieldConfig
}

struct SignupConfig: Codable {
    var email: ItemConfig
    var confirmEmail: ItemConfig
    var fullname: ItemConfig
    var username: ItemConfig
    var password: ItemConfig
    
}

struct SplashConfig: Codable {
    let items: [SplashItem]
    
    struct SplashItem: Codable {
        let imageName: String
        let title: String
        let description: String
        let index: Int
    }
}

struct ForgotPasswordConfig: Codable {
    let forgotPassword: ForgotPasswordItem
    let checkEmail: ForgotPasswordItem
    let setNewPassword: ForgotPasswordItem
    
    struct ForgotPasswordItem: Codable {
        let title: String
        let description: String
    }
}

struct JourneyConfig: Codable {
    let devices: DevicesConfig
    let games: GamesConfig
    let usernames: JourneyUsername
    let followOthers: FollowOthers
    
    struct JourneyUsername: Codable {
        let psn: ItemConfig
        let xbox: ItemConfig
    }
    
    struct FollowOthers: Codable {
        let followTitle: String
        let recommendedTitle: String
    }
}



struct DevicesConfig: Codable {
    let title: String
    let items: [Device]
    
    struct Device: Codable, Hashable {
        let deviceName: String
        let imageName: String
        let deviceType: JourneyViewModel.SelectedDevice
        var isSelected: Bool
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            deviceName = try container.decode(String.self, forKey: .deviceName)
            imageName = try container.decode(String.self, forKey: .imageName)
            deviceType = JourneyViewModel.SelectedDevice(rawValue: try container.decodeIfPresent(String.self,
                                                                                                 forKey: .deviceType) ?? "none") ?? .none
            isSelected = try container.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
        }
    }
}

struct GamesConfig: Codable {
    let title: String
    let items: [Game]
    
    struct Game: Codable, Hashable {
        let gameName: String
        let imageName: String
        var isSelected: Bool
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            gameName = try container.decode(String.self, forKey: .gameName)
            imageName = try container.decode(String.self, forKey: .imageName)
            isSelected = try container.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
        }
    }
}

struct TextFieldConfig: Codable, Hashable {
    var title: String
    let placeholderText: String
    
    init(title: String, placeholderText: String) {
        self.title = title
        self.placeholderText = placeholderText
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        placeholderText = try container.decode(String.self, forKey: .placeholderText)
    }
}

struct ItemConfig: Codable {
    let title: String
    var description: String
    let textFieldConfig: TextFieldConfig
}

struct SettingsManager {
    
    static let shared = SettingsManager.fetchSettings()!
    private init() {}
    
    static private func fetchSettings() -> AppSettings? {
        let decoder = JSONDecoder()

        let settingsFilePath = Bundle.main.path(forResource: "AppSettings", ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(filePath: settingsFilePath))
            let result = try decoder.decode(AppSettingsModel.self, from: data)
            return result.settings
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

