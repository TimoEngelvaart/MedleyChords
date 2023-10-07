import Foundation

struct Song: Identifiable {
    let id = UUID()
    var chords: String
    var key: String
}

struct Medley: Identifiable {
    let id = UUID()
    var songs: [Song]
}
