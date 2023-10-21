import SwiftUI

struct MedleyDetail: View {
    @State private var isAddingSong: Bool = false
    @State private var transposeKey: String = "C"
    @State private var isTransposed: Bool = false
    //To update medley properties when there are updates
    @ObservedObject var medley: Medley
    
    var body: some View {
        
            List {
                //Title
                Text(medley.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                //Songs
                ForEach(medley.songs) { medley in
                    VStack(alignment: .leading){
                        Text(medley.title)
                            .font(.headline)
                        Text(medley.chords)
                    }
                }
                .onMove(perform: medley.moveSong)
                
                //Add Song Button
                NavigationLink(destination: AddSongView(medley: medley)) {
                    Button(action: {
                        isAddingSong = true
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Song")
                        }
                    }
                }
                
                //Transpose Button
                Button(action: transposeChords) {
                    Text("Transpose all songs to key of \(transposeKey)")
                }
            }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
    
    //function to transpose chords
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

#Preview {
    MedleyDetail(medley: Medley.sampleData[0])
}
