import Foundation

struct ExerciseData {
    static let chestExercises = [
        "Bench Press",
        "Incline Dumbbell Press",
        "Dumbbell Fly",
        "Push-up"
    ]
    
    static let backExercises = [
        "Pull-up",
        "Lat Pulldown",
        "Barbell Row",
        "T-bar Row"
    ]

    static let muscleGroups = [
        MuscleGroup(name: "Chest", exercises: chestExercises),
        MuscleGroup(name: "Back", exercises: backExercises)
    ]
}
