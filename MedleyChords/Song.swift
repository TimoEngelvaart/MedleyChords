import Foundation

struct Song: Identifiable, Hashable {
    var id = UUID()
    var chords: String
    var key: String
}
