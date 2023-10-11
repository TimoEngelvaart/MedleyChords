import SwiftUI

class Medley: ObservableObject, Identifiable {
    var id = UUID()
    @Published var title: String
    @Published var songs: [Song]

    init(title: String, songs: [Song]) {
        self.title = title
        self.songs = songs
    }

    static var example = Medley(
        title: "Avicii",
        songs: [
            Song(title: "Wake me Up", chords: "F - G - A", key: "A"),
            Song(title: "Levels", chords: "C# - G# - A#", key: "C#")
        ]
    )
}

struct Song: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var chords: String
    var key: String
}
