import SwiftUI

class MedleyData: ObservableObject {
    @Published var medleys: [Medley] = [
        Medley(title: "Avicii",
             songs: [
                 Song(chords: "F - G - A", key: "F"),
                 Song(chords: "C# - G# - A#", key: "C#")
             ]
        ),
        Medley(title: "The Sorry Medley",
             songs: [
                 Song(chords: "F - G - A", key: "F"),
                 Song(chords: "C# - G# - A#", key: "C#")
             ]
        ),
        Medley(title: "Demi Lovato",
             songs: [
                 Song(chords: "F - G - A", key: "F"),
                 Song(chords: "C# - G# - A#", key: "C#")
             ]
        ),
        Medley(title: "Coldplay",
             songs: [
                 Song(chords: "F - G - A", key: "F"),
                 Song(chords: "C# - G# - A#", key: "C#")
             ]
        ),
        Medley(title: "Just another medley",
             songs: [
                 Song(chords: "F - G - A", key: "F"),
                 Song(chords: "C# - G# - A#", key: "C#")
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
        medleys.contains(medley)
    }
}
