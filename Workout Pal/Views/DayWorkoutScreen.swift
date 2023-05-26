import SwiftUI

struct DayWorkoutScreen: View {
    let dayOfWeek: DayOfWeek
    @EnvironmentObject private var exerciseStore: ExerciseStore
    @State private var isAddingExercise: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text(dayOfWeek.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0xDD / 255, green: 0x00 / 255, blue: 0xFF / 255))
                    .padding(.top)
                    .padding(.bottom)
                
                if let exercises = exerciseStore.getExercises(for: dayOfWeek) {
                    ForEach(exercises.indices, id: \.self) { index in
                        ExerciseRow(exercise: exercises[index], exerciseStore: exerciseStore, dayOfWeek: dayOfWeek)
                            .padding(.vertical, 4)
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
                        AddExerciseView(isAddingExercise: $isAddingExercise, muscleGroups: ExerciseData.muscleGroups, dayOfWeek: dayOfWeek)
                            .environmentObject(exerciseStore)
                            .navigationBarItems(leading: HStack(spacing: 4) {
                                Button(action: {
                                    isAddingExercise = false
                                }) {
                                    HStack(spacing: 2) {
                                        Image(systemName: "chevron.left")
                                            .imageScale(.large)
                                        Text("Back")
                                    }
                                    .padding(.vertical)
                                }
                            }, trailing: EmptyView())
                    }
                }
            }
        }
    }
}

struct ExerciseRow: View {
    let exercise: DayExercise
    let exerciseStore: ExerciseStore
    let dayOfWeek: DayOfWeek
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.up")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        moveExerciseUp()
                    }
                
                Image(systemName: "arrow.down")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        moveExerciseDown()
                    }
                
                Text(exercise.exercise.name)
                    .font(.headline)
                    .padding(.vertical, 8)
                
                Spacer()
                
                Button(action: {
                    exerciseStore.removeExercise(exercise.exercise, for: dayOfWeek)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                .padding(.trailing, 8)
                .buttonStyle(PlainButtonStyle())
            }
            
            ForEach(exercise.sets.indices, id: \.self) { index in
                let set = exercise.sets[index]
                VStack(spacing: 8) {
                    Divider()
                    HStack {
                        Text("Set")
                        Spacer()
                        Text("Reps")
                        Spacer()
                        Text("Weight")
                    }
                    HStack {
                        Text("\(index + 1)")
                        Spacer()
                        Text("\(set.reps)")
                        Spacer()
                        Text("\(String(format: "%.1fkg", set.weight))")
                    }
                }
                .padding(.vertical, 8)
                .cornerRadius(8)
                .padding(.horizontal, 16)
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
    
    private func moveExerciseUp() {
        if let currentIndex = exerciseStore.getExercises(for: dayOfWeek)?.firstIndex(where: { $0 == exercise }),
           currentIndex > 0 {
            let newIndex = currentIndex - 1
            exerciseStore.moveExercise(fromIndex: currentIndex, toIndex: newIndex, for: dayOfWeek)
        }
    }
    
    private func moveExerciseDown() {
        if let currentIndex = exerciseStore.getExercises(for: dayOfWeek)?.firstIndex(where: { $0 == exercise }),
           let exercises = exerciseStore.getExercises(for: dayOfWeek),
           currentIndex < exercises.count - 1 {
            let newIndex = currentIndex + 1
            exerciseStore.moveExercise(fromIndex: currentIndex, toIndex: newIndex, for: dayOfWeek)
        }
    }
}

struct DayWorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        DayWorkoutScreen(dayOfWeek: .Monday)
            .environmentObject(ExerciseStore())
    }
}
