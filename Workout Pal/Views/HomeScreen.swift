import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var exerciseStore: ExerciseStore
    
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
                                
                                let exercises = exerciseStore.getExercises(for: day)
                                
                                if let muscleGroups = getMuscleGroups(for: exercises) {
                                    HStack {
                                        ForEach(muscleGroups.indices, id: \.self) { index in
                                            Image(muscleGroups[index].imageName)
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())

                                            
                                            if index < muscleGroups.count - 1 {
                                                Text(" ")
                                                    .font(.title2)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
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
    
    func getMuscleGroups(for exercises: [DayExercise]?) -> [MuscleGroup]? {
        guard let exercises = exercises else {
            return nil
        }
        
        let exerciseNames = exercises.map { $0.exercise.name }
        
        var muscleGroups: [MuscleGroup] = []
        
        for muscleGroup in ExerciseData.muscleGroups {
            let matchingExercises = muscleGroup.exercises.filter { exerciseNames.contains($0) }
            if !matchingExercises.isEmpty {
                muscleGroups.append(muscleGroup)
            }
        }
        
        return muscleGroups.isEmpty ? nil : muscleGroups
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
            .environmentObject(ExerciseStore())
    }
}

