import SwiftUI

struct MedleyDetail: View {
    @Binding var medley: Medley
    let isEditing: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var path: [Int] = []  // Nothing on the stack by default.
    @State private var transposeKey: String = "C"  // Target key to transpose to
    @State private var isTransposed: Bool = false  // Flag to indicate whether chords have been transposed
    
    func transpose(chords: String, toKey targetKey: String) -> String {
        // Define a mapping of chords to positions in the chromatic scale
        let chordMap: [String: Int] = [
            "C": 0, "C#": 1, "D": 2, "D#": 3, "E": 4,
            "F": 5, "F#": 6, "G": 7, "G#": 8, "A": 9,
            "A#": 10, "B": 11
        ]

        // Split the chords string into an array of individual chords
        let chordsArray = chords.split(separator: " ")

        // Determine the transposition interval based on the target key
        guard let targetKeyPosition = chordMap[targetKey] else { return chords }  // Return original chords if target key is invalid

        // Transpose each chord and join them back into a string
        let transposedChords = chordsArray.compactMap { chord -> String? in
            guard let chordPosition = chordMap[String(chord)] else { return nil }  // Return nil if chord is invalid
            let transposedPosition = (chordPosition + targetKeyPosition) % 12  // Transpose the chord
            return chordMap.first(where: { $0.value == transposedPosition })?.key  // Get the transposed chord or return nil if there's an error
        }.joined(separator: " ")

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
    static var previews: some View {
        MedleyDetail(medley: .constant(Medley.example), isEditing: true)
    }
}


