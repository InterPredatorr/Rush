//
//  LeadershipScreen.swift
//  Rush
//
//  Created by Aziz on 31.07.23.
//

import SwiftUI

struct LeaderboardScreen: View {
    
    @State private var isPresentingFilterSheet: Bool = false
    @State private var isPresentingSortSheet: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 16)
                VStack {
                    LeaderboardTopView(title: "Leaderboard") {
                        isPresentingFilterSheet.toggle()
                    } sortButtonTapped: {
                        isPresentingSortSheet.toggle()
                    }
                    .background(Colors.Secondary.highlightBlack)
                    .sheet(isPresented: $isPresentingFilterSheet) {
                        LeaderboardFilterView()
                            .presentationDetents([.fraction(0.8)])
                    }
                    .sheet(isPresented: $isPresentingSortSheet) {
                        LeaderboardSortView()
                            .background(Colors.Secondary.highlightBlack)
                            .presentationDetents([.fraction(0.4)])
                    }
                }
                Spacer().frame(width: 16)
            }
            .background(Colors.Secondary.highlightBlack)
            ScrollView {
                VStack {
                    LeaderboardTopsView()
                    Spacer().frame(height: 30)
                    LeaderboardCollectionView()
                }
                Spacer()
            }
            .background(Colors.Primary.black)
            .padding(.horizontal, 16)
        }
        .background(Color.clear)
    }
}


struct LeaderboardTopView: View {
    
    var title: String
    let filterButtonTapped: () -> Void
    let sortButtonTapped: () -> Void
    
    var body: some View {
        VStack {
            Spacer().frame(height: 12)
            HStack {
                Text(title)
                    .font(AppFont.everettMedium.size(28))
                    .foregroundColor(Colors.Primary.white)
                Spacer()
                Button {
                    sortButtonTapped()
                } label: {
                    Text("Sort")
                        .font(AppFont.everettMedium.size(15))
                        .foregroundColor(Colors.Primary.white)
                        .frame(width: 60, height: 35)
                        .cornerRadius(50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(lineWidth: 1)
                                .fill(Colors.Opacity.line)
                        }
                }
                Spacer().frame(width: 16)
                Button {
                    filterButtonTapped()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .frame(width: 24, height: 24)
                        .foregroundColor(Colors.Primary.white)
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                                .fill(Colors.Opacity.line)
                                .frame(width: 40, height: 40)
                        }
                }
            }
            Divider()
            Spacer().frame(height: 12)
                .background(Colors.Secondary.highlightBlack)
            LeaderboardLeagueView()
                .background(Colors.Secondary.highlightBlack)
            Spacer().frame(height: 10)
        }
    }
}

struct LeaderboardLeagueView: View {
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text("League")
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Secondary.copyText)
                Spacer().frame(height: 9)
                Text("Professional")
                    .font(AppFont.everettMedium.size(24))
                    .foregroundColor(Colors.Primary.purpleB)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Button {
                    //
                } label: {
                    HStack {
                        Spacer().frame(width: 12)
                        Image(ImageResources.fifa)
                            .resizable()
                            .frame(width: 16, height: 16)
                        Spacer().frame(width: 6)
                        Text("FIFA 23")
                            .font(AppFont.everettMedium.size(15))
                            .foregroundColor(Colors.Primary.white)
                        Spacer().frame(width: 12)
                    }
                    .frame(height: 30)
                    .background(Colors.Primary.purpleA)
                    .cornerRadius(50)
                    .padding(.vertical, 7)
                }
                Spacer().frame(height: 9)
                Text("23/24 session")
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Primary.white)
            }
        }
    }
}

struct LeadershipProfileItem: Identifiable {
    var id = UUID()
    var imageUrl: String
    var name: String
    var place: Int
    var wins: Int
    var losses: Int
    var country: String
    var city: String
}


struct LeaderboardTopsView: View {
    
    let topThrees: [LeadershipProfileItem] = [
        LeadershipProfileItem(imageUrl: "https://pbs.twimg.com/profile_images/1543187429666000896/SbilQ-pO_400x400.jpg",
                              name: "S. Curran", place: 2, wins: 250, losses: 50, country: "", city: ""),
        LeadershipProfileItem(imageUrl: "https://pbs.twimg.com/profile_images/1543187429666000896/SbilQ-pO_400x400.jpg",
                              name: "Macho.M", place: 1, wins: 300, losses: 89, country: "", city: ""),
        LeadershipProfileItem(imageUrl: "https://pbs.twimg.com/profile_images/1543187429666000896/SbilQ-pO_400x400.jpg",
                              name: "D. Brave", place: 3, wins: 290, losses: 100, country: "", city: "")]
    
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(topThrees) { profile in
                LeaderboardTopProfileView(profile: profile)
                if profile.place != 3 {
                    Spacer()
                }
            }
        }
        .padding(.top, 24)
    }
}


struct LeaderboardTopProfileView: View {
    
    let profile: LeadershipProfileItem
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: profile.imageUrl)) { image in
                    image
                        .resizable()
                        .cornerRadius(profile.place == 1 ? 50 : 40)
                        .aspectRatio(1, contentMode: .fit)
                        .overlay {
                            RoundedRectangle(cornerRadius: profile.place == 1 ? 50 : 40)
                                .stroke(lineWidth: 2)
                                .fill(Colors.Opacity.line)
                        }
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: profile.place == 1 ? 100 : 80, height: profile.place == 1 ? 100 : 80)
                .aspectRatio(contentMode: .fill)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(String(profile.place))
                            .frame(width: 20, height: 20)
                            .font(AppFont.everettMedium.size(13))
                            .foregroundColor(Colors.Primary.white)
                            .background(Colors.Primary.blue)
                            .cornerRadius(10)
                        Spacer().frame(width: profile.place == 1 ? 10 : 8)
                    }
                }
                .frame(width: profile.place == 1 ? 100 : 80, height: profile.place == 1 ? 100 : 80)
            }
            Spacer().frame(height: 10)
            Text(profile.name)
                .font(AppFont.everettMedium.size(17))
                .foregroundColor(Colors.Primary.white)
            Spacer().frame(height: 4)
            Text("Wins: " + String(profile.wins))
                .font(AppFont.everettMedium.size(11))
                .foregroundColor(Colors.Secondary.copyText)
            Spacer().frame(height: 4)
            Text("Losses: " + String(profile.losses))
                .font(AppFont.everettMedium.size(11))
                .foregroundColor(Colors.Secondary.copyText)
        }
    }
}


struct LeaderboardCollectionView: View {
    
     @State var profiles: [LeadershipProfileItem] = [
        LeadershipProfileItem(imageUrl: "https://pbs.twimg.com/profile_images/1543187429666000896/SbilQ-pO_400x400.jpg",
                              name: "S. Curran", place: 4, wins: 250, losses: 50, country: "Armenia", city: "Yerevan"),
        LeadershipProfileItem(imageUrl: "https://pbs.twimg.com/profile_images/1543187429666000896/SbilQ-pO_400x400.jpg",
                              name: "Macho.M", place: 5, wins: 300, losses: 89, country: "Germany", city: "Berlin"),
        LeadershipProfileItem(imageUrl: "https://pbs.twimg.com/profile_images/1543187429666000896/SbilQ-pO_400x400.jpg",
                              name: "D. Brave", place: 6, wins: 290, losses: 100, country: "USA", city: "Los Angeles"),
        LeadershipProfileItem(imageUrl: "https://pbs.twimg.com/profile_images/1543187429666000896/SbilQ-pO_400x400.jpg",
                              name: "S. Curran", place: 7, wins: 250, losses: 50, country: "Armenia", city: "Yerevan"),
        LeadershipProfileItem(imageUrl: "https://pbs.twimg.com/profile_images/1543187429666000896/SbilQ-pO_400x400.jpg",
                              name: "Macho.M", place: 8, wins: 300, losses: 89, country: "Germany", city: "Berlin"),
        LeadershipProfileItem(imageUrl: "https://pbs.twimg.com/profile_images/1543187429666000896/SbilQ-pO_400x400.jpg",
                              name: "D. Brave", place: 9, wins: 290, losses: 100, country: "USA", city: "Los Angeles")]
    
    var body: some View {
        VStack {
                HStack {
                    Spacer()
                    HStack {
                        Text("Wins")
                            .font(AppFont.everettRegular.size(11))
                            .foregroundColor(Colors.Primary.white)
                        Spacer()
                        Text("Losses")
                            .font(AppFont.everettRegular.size(11))
                            .foregroundColor(Colors.Primary.white)
                    }
                    .frame(width: 100)
                    Spacer().frame(width: 6)
                }
                Spacer().frame(height: 5)
                VStack {
                    ForEach(profiles) { profile in
                        LeaderboardProfileView(profile: profile)
                    }
                    Spacer().frame(height: 20)
                    Text("View full leaderboard")
                        .font(AppFont.everettMedium.size(17))
                        .foregroundColor(Colors.Primary.white)
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .scaledToFill()
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                                .fill(Colors.Opacity.line)
                        }
                        .background(Colors.Secondary.highlightBlack)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 2)
            }
            .scrollIndicators(.hidden)
            .onAppear {
                profiles.sort(by: { ($0.wins - $0.losses) > ($1.wins - $1.losses) })
                profiles = profiles.enumerated().map { index, profile in
                    var p = profile
                    p.place = index + 4
                    return p
                }
            }
    }
}

struct LeaderboardProfileView: View {
    
    let profile: LeadershipProfileItem
    
    var body: some View {
        HStack {
            Text(String(profile.place))
                .frame(width: 20, height: 20)
                .font(AppFont.everettMedium.size(13))
                .foregroundColor(Colors.Primary.white)
                .background(Colors.Primary.blue)
                .cornerRadius(10)
            Spacer().frame(width: 10)
            AsyncImage(url: URL(string: profile.imageUrl)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 32, height: 32)
            .cornerRadius(16)
            Spacer().frame(width: 8)
            VStack(alignment: .leading) {
                Text(profile.name)
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Primary.white)
                Spacer().frame(height: 4)
                Text(profile.city + ", " + profile.country)
                    .font(AppFont.everettRegular.size(11))
                    .foregroundColor(Colors.Secondary.copyText)
            }
            Spacer()
            HStack {
                Spacer().frame(width: 10)
                Text(String(profile.wins))
                    .font(AppFont.everettMedium.size(15))
                    .foregroundColor(Colors.Primary.white)
                Spacer()
                Text(String(profile.losses))
                    .font(AppFont.everettMedium.size(15))
                    .foregroundColor(Colors.Primary.white)
            }
            .frame(width: 100)
        }
        .frame(height: 70)
        .padding(.horizontal, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 1)
                .fill(Colors.Opacity.line)
        }
    }
}

struct SortItem: Identifiable {
    var id = UUID()
    var name: String
    var isSelected: Bool
}

struct LeaderboardSortView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var types: [SortItem] = [SortItem(name: "Wins", isSelected: true),
                             SortItem(name: "Earnings", isSelected: false)]
    
    var body: some View {
        VStack {
            LeaderboardSheetsTopView(title: "Sort by") {
                dismiss()
            }
            Divider()
            LeaderboardFilterReusableHItemsView(types: $types)
            Spacer()
            LeaderboardBottomButtonsView {
                dismiss()
            } showButtonTapped: {
                dismiss()
            }
        }
        .padding(.horizontal, 16)
    }
}

struct LeaderboardFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            LeaderboardSheetsTopView(title: "Filter by") {
                dismiss()
            }
            Divider()
            Spacer().frame(height: 24)
            ReusableSortTitleView(title: "Country or City")
            SearchField(searchText: $searchText, placeholderText: "Los Angeles")
            LeaderboardFilterContentView()
            Spacer()
            LeaderboardBottomButtonsView {
                dismiss()
            } showButtonTapped: {
                dismiss()
            }
        }
        .padding(.horizontal, 16)
        .background(Colors.Secondary.highlightBlack)
    }
}

struct LeaderboardFilterContentView: View {
    
    
    @State var gameTypes: [SortItem] = [SortItem(name: "FIFA", isSelected: true),
                                        SortItem(name: "NHL", isSelected: false),
                                        SortItem(name: "MHL", isSelected: false),
                                        SortItem(name: "NBA", isSelected: false),
                                        SortItem(name: "MSB", isSelected: false)]
    @State var consoleTypes: [SortItem] = [SortItem(name: "PS5", isSelected: true),
                                           SortItem(name: "Xbox", isSelected: false)]
    @State var yearTypes: [SortItem] = [SortItem(name: "2023", isSelected: true),
                                           SortItem(name: "2024", isSelected: false)]
    
    var body: some View {
        Spacer().frame(height: 44)
        ReusableSortTitleView(title: "Game")
        LeaderboardFilterReusableHItemsView(types: $gameTypes)
        Spacer().frame(height: 44)
        ReusableSortTitleView(title: "Console")
        LeaderboardFilterReusableHItemsView(types: $consoleTypes)
        Spacer().frame(height: 44)
        ReusableSortTitleView(title: "Year")
        LeaderboardFilterReusableHItemsView(types: $yearTypes)
    }
}



struct ReusableSortTitleView: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(AppFont.everettMedium.size(17))
                .foregroundColor(Colors.Primary.white)
            Spacer()
        }
        .frame(height: 20)
    }
}

struct LeaderboardSheetsTopView: View {
        
    let title: String
    let buttonTapped: () -> Void
    
    var body: some View {
        Spacer().frame(height: 12)
        HStack {
            Spacer()
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 140, height: 5)
                .foregroundColor(Colors.Opacity.line)
            Spacer()
        }
        Spacer().frame(height: 24)
        HStack {
            Text(title)
                .font(AppFont.everettMedium.size(24))
                .foregroundColor(Colors.Primary.white)
            Spacer()
            Button {
                buttonTapped()
            } label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .foregroundColor(Colors.Secondary.copyText)
            }
            .frame(width: 24, height: 24)
            .foregroundColor(Colors.Secondary.copyText)
        }
    }
    
}

struct ReusableComponentView: View {
    
    let title: String
    var isSelected: Bool
    let buttonTapped: () -> Void
    
    var body: some View {
        Button {
            buttonTapped()
        } label: {
            HStack {
                Text(title)
                    .font(AppFont.everettMedium.size(13))
                    .foregroundColor(Colors.Primary.white)
                    .padding(.horizontal, 16)
            }
            .frame(height: 36)
            .background(isSelected ? Colors.Primary.blue : Colors.Secondary.highlightBlack)
            .overlay {
                RoundedRectangle(cornerRadius: 67)
                    .stroke(lineWidth: 1)
                    .fill(isSelected ? Colors.Primary.blue : Colors.Opacity.line)
            }
            .cornerRadius(67)
        }
    }
}


struct LeaderboardBottomButtonsView: View {
    
    
    let clearButtonTapped: () -> Void
    let showButtonTapped: () -> Void
    
    var body: some View {
        HStack {
            Button {
                clearButtonTapped()
            } label: {
                HStack {
                    Text("Clear Filter")
                        .font(AppFont.everettMedium.size(17))
                        .foregroundColor(Colors.Primary.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal)
                        .minimumScaleFactor(0.2)
                }
                .background(Colors.Secondary.highlightBlack)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .fill(Colors.Opacity.line)
                }
                .cornerRadius(12)
            }
            .frame(maxWidth: .infinity)
            Spacer().frame(width: 11)
            Button {
                showButtonTapped()
            } label: {
                HStack {
                    Text("Show Leaderboard")
                        .font(AppFont.everettMedium.size(17))
                        .foregroundColor(Colors.Primary.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal)
                        .minimumScaleFactor(0.2)
                }
                .background(Colors.Primary.blue)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .fill(Colors.Primary.blue)
                }
                .cornerRadius(12)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 52)
    }
}

struct LeaderboardFilterReusableHItemsView: View {
    
    @Binding var types: [SortItem]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(types) { type in
                    ReusableComponentView(title: type.name, isSelected: type.isSelected) {
                        types = types.map { t in
                            var tmp = t
                            tmp.isSelected = t.id == type.id
                            return tmp
                        }
                    }
                    
                }
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct LeaderboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardScreen()
    }
}
