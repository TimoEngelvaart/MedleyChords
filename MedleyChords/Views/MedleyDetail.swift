import SwiftUI

struct MedleyDetail: View {
    @State private var isAddingSong: Bool = false
    @State private var transposeKey: String = "C"
    @State private var isTransposed: Bool = false
    //To update medley properties when there are updates
    @ObservedObject var medley: Medley
    
    // List of musical keys for the picker
    let musicalKeys = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    
    var body: some View {
        
        VStack {
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
                    
                    // Picker for transposeKey
                    Picker("Transpose to key:", selection: $transposeKey) {
                        ForEach(musicalKeys, id: \.self) { key in
                            Text(key).tag(key)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                Spacer()
                Button(action: transposeChords) {
                                Text("Transpose")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                .padding([.leading, .trailing, .bottom])
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
    
    //function to transpose chords
    private func transposeChords() {
        for index in medley.songs.indices {
            let originalChords = medley.songs[index].chords
            let originalKey = medley.songs[index].key
            
            if let transposedChords = transpose(chords: originalChords, fromKey: originalKey, toKey: transposeKey) {
                medley.songs[index].chords = transposedChords
                medley.songs[index].key = transposeKey
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
