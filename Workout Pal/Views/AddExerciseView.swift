import SwiftUI

struct AddExerciseView: View {
    @Binding var isAddingExercise: Bool
    @EnvironmentObject var exerciseStore: ExerciseStore
    @State private var selectedMuscleGroup: String = ""
    @State private var selectedExercise: String = ""
    @State private var sets: [SetData] = []
    
    let muscleGroups: [MuscleGroup]
    let dayOfWeek: DayOfWeek
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Picker("Muscle Group", selection: $selectedMuscleGroup) {
                        ForEach(muscleGroups, id: \.name) { muscleGroup in
                            Text(muscleGroup.name)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    
                    Spacer()
                }
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()

                if let selectedMuscleGroup = muscleGroups.first(where: { $0.name == selectedMuscleGroup }) {
                    HStack {
                        Picker("Exercise", selection: $selectedExercise) {
                            ForEach(selectedMuscleGroup.exercises, id: \.self) { exercise in
                                Text(exercise)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        
                        Spacer()
                    }
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding()
                }

                
                VStack {
                    ForEach(sets.indices, id: \.self) { index in
                        SetView(set: $sets[index], deleteSet: { deleteSet(at: index) })
                        Divider()
                    }
                    HStack {
                        Button(action: addSet) {
                            Text("Add Set")
                        }
                        .padding()
                        Spacer()
                    }
                }
                .padding()
                
                Button(action: addExercise) {
                    Text("Confirm")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(selectedMuscleGroup.isEmpty || selectedExercise.isEmpty || sets.isEmpty || sets.contains(where: { $0.reps == 0 }))
                
                if selectedMuscleGroup.isEmpty || selectedExercise.isEmpty || sets.isEmpty || sets.contains(where: { $0.reps == 0 }) {
                    Text("Please fill out all fields")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                }
                
                Spacer()
            }
            .onAppear {
                // Set the default selected muscle group and exercise on view appear
                selectedMuscleGroup = muscleGroups.first?.name ?? ""
                selectedExercise = muscleGroups.first?.exercises.first ?? ""
            }
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
        
        isAddingExercise = false
    }
}

struct SetView: View {
    @Binding var set: SetData
    var deleteSet: () -> Void
    
    var body: some View {
        VStack {
            Stepper(value: $set.reps, in: 0...10) {
                Text("Reps: \(set.reps)")
            }
            .padding()
            
            HStack {
                Text("Weight:")
                    .padding(.trailing, 8)
                Spacer()
                Picker(selection: $set.weight, label: Text("")) {
                    ForEach(Array(stride(from: 0, through: 600, by: 0.5)), id: \.self) { weight in
                        Text("\(weight, specifier: "%.1f") kg")
                    }
                }
                .frame(width: 100, height: 100)
                .clipped()
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
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
    @State static var isAddingExercise = false

    static var previews: some View {
        AddExerciseView(isAddingExercise: $isAddingExercise, muscleGroups: ExerciseData.muscleGroups, dayOfWeek: .Monday)
            .environmentObject(ExerciseStore())
    }
}
