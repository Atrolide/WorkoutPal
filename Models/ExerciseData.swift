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
    
    static let legsExercises = [
        "Barbell Squats",
        "Bulgarian Split Squats",
        "Calf Raises",
        "Lunges"
    ]
    
    static let bicepExercises = [
        "Dumbbell Curls",
        "Barbell Curls",
        "String Curls"
    ]
    
    static let tricepExercises = [
        "Dumbbell Overhead Extensions",
        "Skull Crushers",
        "String Pushdown",
        "Kickbacks"
    ]
    
    static let shouldersExercises = [
        "Dumbbell Overhead Press",
        "Barbell Overhead Press",
        "Arnold Press",
        "Lateral Raises",
        "High Pulls"
    ]
    
    static let absExercises = [
        "Leg Raises",
        "Crunches",
        "Russian Twist",
        "Sit-ups"
    ]

    static let muscleGroups = [
        MuscleGroup(name: "Chest", exercises: chestExercises, imageName: "chest"),
        MuscleGroup(name: "Back", exercises: backExercises, imageName: "back"),
        MuscleGroup(name: "Legs", exercises: legsExercises, imageName: "legs"),
        MuscleGroup(name: "Bicep", exercises: bicepExercises, imageName: "bicep"),
        MuscleGroup(name: "Tricep", exercises: tricepExercises, imageName: "triceps"),
        MuscleGroup(name: "Shoulders", exercises: shouldersExercises, imageName: "shoulders"),
        MuscleGroup(name: "Abs", exercises: absExercises, imageName: "abs")
    ]
}
