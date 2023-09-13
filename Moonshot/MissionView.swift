//
//  MissionView.swift
//  Moonshot
//
//  Created by Eugene on 22/08/2023.
//

import SwiftUI

struct MissionView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    let mission: Mission
    
    let labels = [
        "apollo1": "A circular stars and stripes badge, with an inner circle coloured gold.  The inner circle has the names White, Grissom and Chaffee insigned at 9, 12 and 3 o'clock on the face.  Inside the inner circle is a image of the globe and the rocket ship above it in orbit with the moon in the background.  The title Apollo 1 is at 6 0'clock on the inner gold circle",
        "apollo11": "Two thin circles yellow then blue.  Inside the blue circle is an image of the surface of the moon with an eagle coming into land with the earth in the background, 2/3rds visible.  The text Apollo 11 is at above in yellow against the black space"]
    
        
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .accessibilityRemoveTraits(.isImage)
                        .accessibilityLabel(labels[mission.image, default: "Unknown"])
                    
                    Text(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A")
                        .font(.title2.bold())
                        .padding(.top)

                    VStack(alignment: .leading) {
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    CrewView(mission: mission, astronauts: astronauts)
 
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[1])
            .preferredColorScheme(.dark)
    }
}
