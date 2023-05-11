import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    Text("Your Weekly Workout")
                        .font(Font.custom("Arial-BoldMT", size: 36))
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0x3E / 255, green: 0x1C / 255, blue: 0xA8 / 255))
                        .padding(.bottom, 6)
                    
                   
                    
                    ForEach(DayOfWeek.allCases, id: \.self) { day in
                        NavigationLink(destination: DayWorkoutScreen(dayOfWeek: day)) {
                            VStack(spacing: 8) {
                                Text(day.rawValue)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0xDD / 255, green: 0x00 / 255, blue: 0xFF / 255))
                                
                                if let workout = getWorkout(for: day) {
                                    Text("Workout:")
                                        .font(.subheadline)
                                    Text(workout.description)
                                        .font(.footnote)
                                } else {
                                    Text("Rest day")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                }
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(40)
                            .shadow(radius: 5)
                        
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    func getWorkout(for day: DayOfWeek) -> Workout? {
        // Here, you can implement the logic to get the workout for the given day
        // This could involve reading from a database, a local file, or any other source
        // For now, we will just return nil, indicating there is no workout for any day
        return nil
    }
}

enum DayOfWeek: String, CaseIterable {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

struct Workout {
    let muscleGroups: [MuscleGroup]
    
    var description: String {
        muscleGroups.map(\.name).joined(separator: ", ")
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
