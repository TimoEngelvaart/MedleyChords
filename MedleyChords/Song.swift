import Foundation

struct Song: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var chords: String
    var key: String
}
