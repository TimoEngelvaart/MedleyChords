import SwiftUI

class MedleyData: ObservableObject {
    @Published var medleys: [Medley] = [
        Medley(title: "Avicii",
             songs: [
                 Song(title: "Wake me Up", chords: "Bm - D - A", key: "D"),
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
    func delete(_ medley: Medley) {
        medleys.removeAll { $0.id == medley.id }
    }
    
    func add(_ medley: Medley) {
        medleys.append(medley)
    }
    
    func exists(_ medley: Medley) -> Bool {
        return medleys.contains { $0.id == medley.id }
    }
}
