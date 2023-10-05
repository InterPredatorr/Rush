//
//  ProfileScreen.swift
//  Rush
//
//  Created by aziz on 2023-07-29.
//

import SwiftUI
import Charts

struct ProfileScreen: View {
    var body: some View {
        ZStack {
            Colors.Primary.black
                .ignoresSafeArea()
            VStack(spacing: 24) {
                header
                ScrollView {
                    profileInfo
                    aggregateStats
                    films
                }
                Spacer()
            }
            .padding()
        }
        
    }
}

private extension ProfileScreen {
    
    var films: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Films")
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 20, weight: .medium))
            
            RoundedView {
                VStack(alignment: .leading, spacing: 8) {
                    Image("film")
                        .padding(.bottom, 12)

                    Text("FIFA 23")
                        .foregroundColor(Colors.Primary.purpleA)
                        .font(.system(size: 11, weight: .regular))
                    Text("FIFA 23 Pro Clubs, VOLTA FOOTBALL and Cross-Play Details Revealed")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 17, weight: .medium))
                    
                    HStack(spacing: 32) {
                        Text("By: ")
                        +
                        Text("STEVE NOAH")
                            .foregroundColor(Colors.Primary.blue)
                            .font(.system(size: 13, weight: .medium))
                        
                        Text("10th July, 2024")
                    }
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 13, weight: .regular))
                    
                    Text("EA has revealed details on FIFA 23 Pro Clubs, VOLTA FOOTBALL and cross-play today, along with...")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 14, weight: .regular))
                }
            }
        }
    }
    
    var aggregateStats: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Aggregate Stats")
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 20, weight: .medium))
            
            RoundedView {
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            getStatsItem(title: "Total matches played", value: "18")
                        }
                        
                        HStack(spacing: 32) {
                            getStatsItem(title: "Total wins", value: "12")
                            getStatsItem(title: "Total lost", value: "6")
                        }
                    }
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 15, weight: .medium))
                    Spacer()
                    
                    Color.gray
                        .frame(width: 84, height: 84)
                }
            }
            
            RoundedView {
                HStack(spacing: 64) {
                    getStatsItem(title: "Total Disputes", value: "4")
                    getStatsItem(title: "Disputes won", value: "3")
                    Spacer()
                }
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 15, weight: .medium))
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var profileInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image("wong")
                .padding(.top, 8)
            Text("Sh Xing Wong")
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 20, weight: .medium))
                .padding(.top, 8)
            Text(Image("pin")) + Text("  Osaka, Japan")
            
            Text("This is sample bio where you can talk about yourself and your achievements.")
                .padding(.top, 12)
            
            HStack() {
                VStack {
                    Text("$535.44")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 15, weight: .medium))
                    Text("Earnings")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 11, weight: .medium))
                }
                Spacer()
                VStack {
                    Text("32")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 15, weight: .medium))
                    Text("Following")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 11, weight: .medium))
                }
                Spacer()
                VStack {
                    Text("5k")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 15, weight: .medium))
                    Text("Followers")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 11, weight: .medium))
                }
                Spacer()
                Rectangle()
                    .fill(Colors.Secondary.highlightBlack)
                    .frame(width: 1, height: 30)
                    .layoutPriority(-1)
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(Image("shield"))
                    +
                    Text("  Rank 82")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 15, weight: .medium))
                    
                    Text("Amateur")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 11, weight: .medium))
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 18)
            
            
            HStack {
                Pill(text: "FIFA 2020")
                Pill(text: "NHL 2020")
                Pill(text: "MLB 2020")
                Pill(text: "Tennis 2023")
            }
            .padding(.top, 12)
            
            
        }
        .foregroundColor(Colors.Primary.white)
        .font(.system(size: 13, weight: .regular))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func getStatsItem(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .foregroundColor(Color.gray)
                .font(.system(size: 11, weight: .regular))
            Text(value)
        }
        .foregroundColor(Colors.Primary.white)
        .font(.system(size: 15, weight: .medium))
    }

}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
