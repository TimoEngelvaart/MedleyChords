import SwiftUI

struct AddSongView: View {
    @Binding var song: Song
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form {
            TextField("Chords", text: $song.chords)
            TextField("Key", text: $song.key)
        }
        .navigationBarTitle("Add Song", displayMode: .inline)
        .navigationBarItems(trailing: Button("Save") {
            self.presentationMode.wrappedValue.dismiss()
        })
    }
}
