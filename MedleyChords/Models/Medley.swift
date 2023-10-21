import Foundation

class Medley: Identifiable, ObservableObject {
    let id: UUID
    var title: String
    // @Published will notify the view to update when the property 'songs' is changed.
    @Published var songs: [Song]
    
    func addSong(_ song: Song) {
        songs.append(song)
    }
    
    func moveSong(from sourceIndex: IndexSet, to destinationIndex: Int) {
        songs.move(fromOffsets: sourceIndex, toOffset: destinationIndex)
    }

    
    init(id: UUID = UUID(), title: String, songs: [Song]) {
        self.id = id
        self.title = title
        self.songs = songs
    }
}

struct Song: Identifiable {
    var id = UUID()
    var title: String
    var chords: String
    var key: String
}

extension Medley {
    static var sampleData: [Medley] =
    [
        Medley(title: "Avicii",
           songs: [
               Song(title: "Wake me Up", chords: "D - D - Em", key: "D"),
               Song(title: "Levels", chords: "C# - G# - A#", key: "C#")
           ]
        ),
        Medley(title: "The Sorry Medley",
             songs: [
                 Song(title: "", chords: "F - G - A", key: "F"),
                 Song(title: "", chords: "C# - G# - A#", key: "C#")
             ]
        ),
        Medley(title: "Demi Lovato",
             songs: [
                 Song(title: "", chords: "F - G - A", key: "F"),
                 Song(title: "", chords: "C# - G# - A#", key: "C#")
             ]
        ),
        Medley(title: "Coldplay",
             songs: [
                 Song(title: "", chords: "F - G - A", key: "F"),
                 Song(title: "", chords: "C# - G# - A#", key: "C#")
             ]
        ),
        Medley(title: "Just another medley",
             songs: [
                 Song(title: "", chords: "F - G - A", key: "F"),
                 Song(title: "", chords: "C# - G# - A#", key: "C#")
             ]
        ),
    ]
}
