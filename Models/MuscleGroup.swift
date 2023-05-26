import Foundation

struct MuscleGroup: Hashable {
    let name: String
    let exercises: [String]
    let imageName: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func ==(lhs: MuscleGroup, rhs: MuscleGroup) -> Bool {
        return lhs.name == rhs.name && lhs.exercises == rhs.exercises && lhs.imageName == rhs.imageName
    }
}
