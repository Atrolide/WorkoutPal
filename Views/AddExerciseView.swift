import SwiftUI

struct AddExerciseView: View {
    @EnvironmentObject var exerciseStore: ExerciseStore
    @State private var selectedMuscleGroup: String = ""
    @State private var selectedExercise: String = ""
    @State private var sets: [SetData] = []
    
    let muscleGroups: [MuscleGroup]
    let dayOfWeek: DayOfWeek
    
    var body: some View {
        VStack {
            Picker("Muscle Group", selection: $selectedMuscleGroup) {
                ForEach(muscleGroups, id: \.name) { muscleGroup in
                    Text(muscleGroup.name)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            if let selectedMuscleGroup = muscleGroups.first(where: { $0.name == selectedMuscleGroup }) {
                Picker("Exercise", selection: $selectedExercise) {
                    ForEach(selectedMuscleGroup.exercises, id: \.self) { exercise in
                        Text(exercise)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
            }
            
            VStack {
                ForEach(sets.indices, id: \.self) { index in
                    SetView(set: $sets[index], deleteSet: { deleteSet(at: index) })
                    Divider()
                }
                
                Button(action: addSet) {
                    Text("Add Set")
                }
                .padding()
            }
            .padding()
            
            Button(action: addExercise) {
                Text("Add Exercise")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(selectedMuscleGroup.isEmpty || selectedExercise.isEmpty)
            
            Spacer()
        }
        .navigationBarTitle("Add Exercise")
        .onAppear {
            // Set the default selected muscle group and exercise on view appear
            selectedMuscleGroup = muscleGroups.first?.name ?? ""
            selectedExercise = muscleGroups.first?.exercises.first ?? ""
        }
    }
    
    func addSet() {
        sets.append(SetData())
    }
    
    func deleteSet(at index: Int) {
        sets.remove(at: index)
    }
    
    func addExercise() {
        guard !selectedMuscleGroup.isEmpty, !selectedExercise.isEmpty else {
            return
        }
        
        let newExercise = Exercise(name: selectedExercise, sets: sets)
        exerciseStore.addExercise(newExercise, sets: sets, for: dayOfWeek)
        
        // Clear the selection and sets
        selectedMuscleGroup = ""
        selectedExercise = ""
        sets.removeAll()
    }
}

struct SetView: View {
    @Binding var set: SetData
    var deleteSet: () -> Void
    
    var body: some View {
        VStack {
            Stepper(value: $set.reps, in: 1...10) {
                Text("Reps: \(set.reps)")
            }
            .padding()
            
            Stepper(value: $set.weight, in: 0...100, step: 0.5) {
                Text("Weight: \(set.weight, specifier: "%.1f") kg")
            }
            .padding()
            
            Button(action: deleteSet) {
                Text("Delete Set")
                    .foregroundColor(.red)
            }
            .padding(.top, 4)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.vertical, 4)
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(muscleGroups: ExerciseData.muscleGroups, dayOfWeek: .Monday)
    }
}

