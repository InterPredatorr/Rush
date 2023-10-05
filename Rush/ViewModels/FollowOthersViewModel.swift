//
//  FollowOthersViewModel.swift
//  Rush
//
//  Created by Aziz on 29.07.23.
//

import Foundation

struct Player: Identifiable {
    var id = UUID()
    let name: String
    let imageUrl: String
    var isFollowing: Bool
    var isFromContacts: Bool
}

class FollowOthersViewModel: ObservableObject {
    
    let config = SettingsManager.shared.journey.followOthers
    
    @Published var followPlayers: [Player] = [
        .init(name: "Andrade Gold",
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCp_ByMCZW8m0s3KmAbIENDvR2Zc_HkBJyYw&usqp=CAU",
              isFollowing: false,
              isFromContacts: true),
        .init(name: "Lina Armas",
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCp_ByMCZW8m0s3KmAbIENDvR2Zc_HkBJyYw&usqp=CAU",
              isFollowing: false,
              isFromContacts: true),
        .init(name: "Krunal Pandya",
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCp_ByMCZW8m0s3KmAbIENDvR2Zc_HkBJyYw&usqp=CAU",
              isFollowing: true,
              isFromContacts: true)]
    
    @Published var recommendedPlayers: [Player] = [
        .init(name: "Dino Ovcina",
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCp_ByMCZW8m0s3KmAbIENDvR2Zc_HkBJyYw&usqp=CAU",
              isFollowing: false,
              isFromContacts: false),
        .init(name: "Jean Paul",
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCp_ByMCZW8m0s3KmAbIENDvR2Zc_HkBJyYw&usqp=CAU",
              isFollowing: false,
              isFromContacts: false),
        .init(name: "Shubman Gill",
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCp_ByMCZW8m0s3KmAbIENDvR2Zc_HkBJyYw&usqp=CAU",
              isFollowing: true,
              isFromContacts: false)]
    
}
