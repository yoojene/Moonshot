//
//  CrewView.swift
//  Moonshot
//
//  Created by Eugene on 22/08/2023.
//

import SwiftUI

struct CrewView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let mission: Mission
    let crew: [CrewMember]

    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                ForEach(crew, id:\.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Circle())
                                .overlay(
                                    (Circle())
                                        .strokeBorder(crewMember.role == "Commander" || crewMember.role == "Command Pilot" ? .white : .black, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                }
            }
        }
    }
    
    // Create a map of role / astronauts from the missions data.  Return fatalError if name is not found (bad JSON!)
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct CrewView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        CrewView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
