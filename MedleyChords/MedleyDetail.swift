import SwiftUI

struct MedleyDetail: View {
    @Binding var medley: Medley
    let isEditing: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isAddingSong: Bool = false
    @State private var newSong: Song = Song(name: "", chords: "", key: "")
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    if isEditing {
                        TextField("New Event", text: $medley.title)
                            .font(.title2)
                    } else {
                        Text(medley.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }

                Text("Songs")
                    .fontWeight(.bold)
                
                Button {
                    isAddingSong = true
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Song")
                    }
                }
                .buttonStyle(.borderless)
                .background(
                    NavigationLink("", destination: AddSongView(song: $newSong), isActive: $isAddingSong)
                        .hidden()
                )
            }
            .navigationTitle("Medleys")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                    }
                }
            }
        }
    }
}

struct MedleyDetail_Previews: PreviewProvider {
    static var previews: some View {
        MedleyDetail(medley: .constant(Medley.example), isEditing: true)
    }
}
