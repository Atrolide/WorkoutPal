import Foundation

struct Exercise: Hashable {
    let name: String
    var sets: [SetData] = []
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

struct SetData: Hashable {
    var reps: Int = 0
    var weight: Double = 0.0
}
