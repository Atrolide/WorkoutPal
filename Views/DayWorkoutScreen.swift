import SwiftUI

struct DayWorkoutScreen: View {
    let dayOfWeek: DayOfWeek
    @EnvironmentObject private var exerciseStore: ExerciseStore
    @State private var isAddingExercise = false
    
    var body: some View {
        VStack {
            Text(dayOfWeek.rawValue)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0xDD / 255, green: 0x00 / 255, blue: 0xFF / 255))
                .padding(.top)
                .padding(.bottom)
            
            if let exercises = exerciseStore.getExercises(for: dayOfWeek) {
                ForEach(exercises, id: \.self) { dayExercise in
                    Text(dayExercise.exercise.name)
                    // Display additional information for the exercise if needed
                }
            } else {
                Text("Rest Day")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                isAddingExercise = true
            }) {
                Text("Add Exercise")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isAddingExercise) {
                NavigationView {
                    AddExerciseView(muscleGroups: ExerciseData.muscleGroups, dayOfWeek: dayOfWeek)
                        .environmentObject(exerciseStore)
                        .navigationBarItems(trailing: Button(action: {
                            isAddingExercise = false
                        }) {
                            Text("Done")
                        })
                }
            }
        }
    }
}


struct DayWorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        DayWorkoutScreen(dayOfWeek: .Monday)
    }
}
