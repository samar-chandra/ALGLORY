//
//  MissionsCardView.swift
//  AlGlory
//
//  Created by Comviva on 24/11/26.
//

import SwiftUI

struct MissionsCardView: View {
    var mission: Mission
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                HStack {
                    VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "cellularbars")
                            Text(mission.difficulty.rawValue.capitalized)
                        }
                        .foregroundStyle(self.getColor(difficulty: mission.difficulty))
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(self.getColor(difficulty: mission.difficulty))
                                .opacity(0.2)
                        }
                        
                        Text(mission.title)
                            .font(.title)
                            .bold()
                        Text(mission.details)
                            .font(.body)
                    }
                    Image(systemName: "chevron.left.forwardslash.chevron.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                }
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                HStack {
                    HStack {
                        Image.init(systemName: "clock")
                        Text("10 min")
                            .font(.footnote)
                    }
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                            .frame(width: 1, height: 15)
                    HStack {
                        Image.init(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("50 XP")
                            .font(.footnote)
                    }
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 1, height: 15)
                    HStack {
                        Image.init(systemName: "app.grid")
                        Text("Arrays")
                            .font(.footnote)
                    }
                    Spacer()
                    Button {
                        print("Mission Started")
                    } label: {
                        HStack(alignment: .center) {
                            Image.init(systemName: "play.fill")
                            Text("Start")
                                .font(.footnote)
                        }
                        .foregroundStyle(Color.white)
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .center).background {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.blue)
                                }
                        
                    }

                }
                .scenePadding(.top)
                
            }
        }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading).background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(
                        color: getColor(difficulty: mission.difficulty).opacity(0.12),
                                radius: 12,
                                x: 0,
                                y: 6
                            )
                    }
                    .padding()
            
    }
    
    func getColor(difficulty: Difficulty) -> Color {
        switch difficulty {
        case .easy:
            return Color.green
        case .medium:
            return Color.yellow
        default:
            return Color.red
        }
    }
}

#Preview {
    MissionsCardView(mission: Mission(schemaVersion: 1, id: UUID(), title: "Two Sum", details: "Find two numbers in an array that add up to a target.", completionStatus: .notStarted, createdAt: Date(), updatedAt: Date(), difficulty: .easy))
}
