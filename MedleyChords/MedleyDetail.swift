import SwiftUI

struct MedleyDetail: View {
    @ObservedObject var medley: Medley
    let isEditing: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var path: [Int] = []  // Nothing on the stack by default.
    @State private var transposeKey: String = "C"  // Target key to transpose to
    @State private var isTransposed: Bool = false  // Flag to indicate whether chords have been transposed
    
    func transpose(chords: String, toKey targetKey: String) -> String {
        let chordMap: [String: Int] = [
            "C": 0, "C#": 1, "D": 2, "D#": 3, "E": 4,
            "F": 5, "F#": 6, "G": 7, "G#": 8, "A": 9,
            "A#": 10, "B": 11
        ]

        guard let targetKeyPosition = chordMap[targetKey], let originalKeyPosition = chordMap[String(chords.prefix(1))] else { return chords }  // Return original chords if target key is invalid

        let chordsArray = chords.split(separator: "-").map { $0.trimmingCharacters(in: .whitespaces) }  // Split and trim chords

        let transposedChords = chordsArray.compactMap { chord -> String? in
            let chordRoot: String
            if chord.count > 1 && chordMap.keys.contains(String(chord.prefix(2))) {
                chordRoot = String(chord.prefix(2))
            } else {
                chordRoot = String(chord.prefix(1))
            }
            let chordSuffix = chord.dropFirst(chordRoot.count)  // Everything after the root
            
            guard let chordPosition = chordMap[chordRoot] else { return nil }  // Return nil if chord is invalid
            
            let transposedPosition = (chordPosition + (targetKeyPosition - originalKeyPosition + 12) % 12) % 12  // Transpose the chord
            let transposedChordRoot = chordMap.first(where: { $0.value == transposedPosition })?.key ?? chordRoot  // Use original root if transposition fails
            
            return transposedChordRoot + chordSuffix  // Concatenate transposed root with original suffix
        }.joined(separator: " - ")
 
    
        return transposedChords
    }
    
    // Function to transpose chords
    func transposeChords() {
        // Loop through each song in the medley
        for index in medley.songs.indices {
            // Transpose chords (assuming a simple transpose function is available)
            medley.songs[index].chords = transpose(chords: medley.songs[index].chords, toKey: transposeKey)
        }
        isTransposed = true  // Set the flag to true to indicate chords have been transposed
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                HStack {
                    if isEditing {
                        TextField("New Event", text: $medley.title)
                            .font(.title2)
                    } else {
                        Text("Songs")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }

                Text("Songs")
                    .fontWeight(.bold)
                
               
                
                ForEach(medley.songs.indices, id: \.self) { index in
                                   VStack(alignment: .leading) {
                                       Text(medley.songs[index].title)
                                           .font(.headline)
                                       Text("Chords: \(medley.songs[index].chords)")
                                       Text("Original Key: \(medley.songs[index].key)")
                                       if isTransposed {
                                           Text("Transposed to Key of \(transposeKey)")
                                       }
                                   }
                                 
                               }
                
                Button {
                    path.append(1)  // Pushing onto the navigation stack
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Song")
                    }
                }
                .buttonStyle(.borderless)
                Button(action: transposeChords) {
                                   Text("Transpose All Songs to Key of \(transposeKey)")
                               }
            }
            .navigationTitle(medley.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                    }
                }
            }
            .navigationDestination(for: Int.self) { _ in
                AddSongView(song: .constant(Song(title: "", chords: "", key: "")))  // Destination view
            }
        }
    }
}

struct MedleyDetail_Previews: PreviewProvider {
    static var medleyData = MedleyData()  // Create an instance of MedleyData

    static var previews: some View {
        // Assume we're using the first medley in the medleys array for preview
        MedleyDetail(medley: medleyData.medleys[0], isEditing: true)
            .environmentObject(medleyData)  // Pass medleyData as an environment object
    }
}
