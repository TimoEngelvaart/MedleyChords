import SwiftUI

// SwiftUI View
struct MedleyDetail: View {
    @ObservedObject var medley: Medley
     let isEditing: Bool
     @State private var isAddingSong: Bool = false  // <-- New state variable
     @State private var transposeKey: String = "C"
     @State private var isTransposed: Bool = false
    
    var body: some View {
                List {
                    titleSection
                    songsSection
                    addSongButton
                    transposeButton
                }
        }
    
    private var titleSection: some View {
        HStack {
            if isEditing {
                TextField("Medley name", text: $medley.title)
                    .font(.title2)
            } else {
                Text("Songs")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
        }
    }
    
    private var songsSection: some View {
        ForEach(medley.songs) { medley in
            VStack(alignment: .leading) {
                Text(medley.title)
                    .font(.headline)
                Text("Chords: \(medley.chords)")
                Text("Original Key: \(medley.key)")
                if isTransposed {
                    Text("Transposed to Key of \(transposeKey)")
                }
            }
        }
    }
    
    private var addSongButton: some View {
        Button(action: {
            isAddingSong = true  // Set isAddingSong to true when the button is tapped
        }) {
            HStack {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
                Text("Add Song")
                    .foregroundColor(.blue)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            NavigationLink("", destination: AddSongView(song: .constant(Song(title: "", chords: "", key: ""))), isActive: $isAddingSong)
                .opacity(0)  // This makes the NavigationLink invisible
        )
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
