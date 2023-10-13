import SwiftUI

// Enum for musical keys
enum MusicalKey: String, CaseIterable {
    case C, Cs, D, Ds, E, F, Fs, G, Gs, A, As, B
    
    var position: Int {
        return MusicalKey.allCases.firstIndex(of: self)!
    }
}

// SwiftUI View
struct MedleyDetail: View {
    @ObservedObject var medley: Medley
    let isEditing: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var path: [Int] = []
    @State private var transposeKey: String = "C"
    @State private var isTransposed: Bool = false
    
    var body: some View {
            NavigationStack(path: $path) {
                List {
                    titleSection
                    songsSection
                    addSongButton
                    transposeButton
                }
                .navigationTitle(medley.title)
                .navigationDestination(for: Int.self) { _ in
                    AddSongView(song: .constant(Song(title: "", chords: "", key: "")))
                }
            }
        }
    
    private var titleSection: some View {
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
    }
    
    private var songsSection: some View {
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
    }
    
    private var addSongButton: some View {
        Button {
            path.append(1)
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("Add Song")
            }
        }
        .buttonStyle(.borderless)
    }
    
    private var transposeButton: some View {
        Button(action: transposeChords) {
            Text("Transpose All Songs to Key of \(transposeKey)")
        }
    }
    
    private func transposeChords() {
        for index in medley.songs.indices {
            let originalChords = medley.songs[index].chords
            let originalKey = medley.songs[index].key
            
            if let transposedChords = transpose(chords: originalChords, fromKey: originalKey, toKey: transposeKey) {
                medley.songs[index].chords = transposedChords
            } else {
                print("Could not transpose chords for song: \(medley.songs[index].title)")
            }
        }
        isTransposed = true
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
