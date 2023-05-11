import Foundation

struct Exercise: Hashable {
    let name: String
    var sets: Int = 0
    var reps: Int = 0
    var weight: Double = 0.0
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }

}
