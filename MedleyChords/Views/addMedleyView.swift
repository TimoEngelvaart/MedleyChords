import SwiftUI

struct AddMedleyView: View {
    @Binding var medleys: [Medley]
    @State private var title: String = ""
    @State private var songs: [Song] = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form{
            TextField("Medley Title", text: $title)
            // Add more fields for songs if needed
        }
        .navigationBarTitle("Add Medley", displayMode: .inline)
        .navigationBarItems(trailing: Button("Save") {
            let newMedley = Medley(title: title, songs: songs)
            medleys.append(newMedley)
            self.presentationMode.wrappedValue.dismiss()
        })
    }
}
