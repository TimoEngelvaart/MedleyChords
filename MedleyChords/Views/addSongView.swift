import SwiftUI

struct AddSongView: View {
    @ObservedObject var medley: Medley
    @State private var title: String = ""
    @State private var chords: String = ""
    @State private var key: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form{
            TextField("Song", text: $title)
            TextField("Chords", text: $chords)
            TextField("Key", text: $key)
        }
        .navigationBarTitle("Add Song", displayMode: .inline)
        .navigationBarItems(trailing: Button("Save") {
            let newSong = Song(title: title, chords: chords, key: key)
            medley.addSong(newSong)
            self.presentationMode.wrappedValue.dismiss()
        })
    }
}
