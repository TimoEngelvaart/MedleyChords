import SwiftUI

struct Medley: Identifiable, Hashable {
    var id = UUID()
    var title = ""
    var songs = [Song(title: "test", chords: "F - G - A", key: "F")]

    init(title: String, songs: [Song]) {
        self.title = title
        self.songs = songs
    }
    
    static var example = Medley(
        title: "Avicii",
        songs: [
            Song(title: "", chords: "F - G - A", key: "D"),
            Song(title: "", chords: "C# - G# - A#", key: "C#")
        ]
    )
}
