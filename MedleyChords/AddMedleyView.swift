//import SwiftUI
//
//struct AddMedleyView: View {
//    @Binding var medleys: [Medley]
//    @State private var songs: [Song] = [Song(chords: "", key: "")]
//    @State private var showingAlert = false
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(songs) { song in
//                    if let index = songs.firstIndex(where: { $0.id == song.id }) {
//                        TextField("Chords", text: $songs[index].chords)
//                        TextField("Key", text: $songs[index].key)
//                    }
//                }
//            }
//            .navigationBarTitle("Add Songs")
//            .navigationBarItems(trailing: Button("Save") {
//                if songs.count <= 10 {
//                    // Transpose code logic here
//                    let newMedley = Medley(songs: songs)
//                    medleys.append(newMedley)
//                } else {
//                    showingAlert = true
//                }
//            })
//        }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("Error"), message: Text("Maximum of 10 songs allowed"), dismissButton: .default(Text("OK")))
//        }
//    }
//}
