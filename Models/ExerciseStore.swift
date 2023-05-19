import Foundation

struct DayExercise: Hashable {
    let exercise: Exercise
    let sets: [SetData]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(exercise)
        hasher.combine(sets)
    }
    
    static func ==(lhs: DayExercise, rhs: DayExercise) -> Bool {
        return lhs.exercise == rhs.exercise && lhs.sets == rhs.sets
    }
}


class ExerciseStore: ObservableObject {
    @Published var dayExercises: [DayOfWeek: [DayExercise]] = [:]
    
    func addExercise(_ exercise: Exercise, sets: [SetData], for dayOfWeek: DayOfWeek) {
        let dayExercise = DayExercise(exercise: exercise, sets: sets)
        
        if dayExercises[dayOfWeek] != nil {
            dayExercises[dayOfWeek]?.append(dayExercise)
        } else {
            dayExercises[dayOfWeek] = [dayExercise]
        }
    }
    
    func getExercises(for dayOfWeek: DayOfWeek) -> [DayExercise]? {
        return dayExercises[dayOfWeek]
    }
}
