//
//  JourneyViewModel.swift
//  Rush
//
//  Created by Aziz on 28.07.23.
//

import Foundation

class JourneyViewModel: ObservableObject {
    
    enum CurrentView {
        case devices
        case games
        case psnUsername
        case xboxUsername
    }
    
    enum SelectedDevice: String, Codable {
        case ps5
        case xbox
        case none
    }
    
    let config = SettingsManager.shared.journey
    @Published var currentView: CurrentView = .devices
    @Published var devices = SettingsManager.shared.journey.devices.items
    @Published var games = SettingsManager.shared.journey.games.items
    @Published var searchText = ""
    @Published var usernameText = ""
    @Published var selectedDevice: SelectedDevice = .none
    @Published var selectedGames: [String] = []

    func updateSelectedDevice(with type: JourneyViewModel.SelectedDevice) {
        devices = devices.map { item in
            var tmp = item
            selectedDevice = type
            tmp.isSelected = tmp.deviceType == type
            return tmp
        }
    }
    
    func updateSelectedGame(with name: String) {
        guard let index = games.firstIndex(where: { $0.gameName == name }) else { return }
        games[index].isSelected.toggle()
        games[index].isSelected ? selectedGames.append(name) : selectedGames.removeAll(where: { $0 == name })
    }
    
    var continueButtonDisabled: Bool {
        currentView == .devices ? (selectedDevice == .none) : selectedGames.count == 0
    }
    
    var buttonOpacity: CGFloat {
        (currentView == .devices ? selectedDevice == .none : selectedGames.count == 0) ? 0.5 : 1
    }
    
    var selectedDeviceConfig: ItemConfig {
        return selectedDevice == .ps5 ? config.usernames.psn : config.usernames.xbox
    }
    
    var deviceSearchResults: [DevicesConfig.Device] {
        guard !searchText.isEmpty else { return devices }
        return devices.filter { $0.deviceName.lowercased().contains(searchText.lowercased()) }
    }
    
    var gameSearchResults: [GamesConfig.Game] {
        guard !searchText.isEmpty else { return games }
        return games.filter { $0.gameName.lowercased().contains(searchText.lowercased()) }
    }
    
    var title: String {
        return currentView == .devices ? config.devices.title : config.games.title
    }
}
