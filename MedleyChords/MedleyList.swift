import SwiftUI

struct MedleyList: View {
    @EnvironmentObject var medleyData: MedleyData
    @State private var isAddingNewEvent = false
    @State private var newMedley = Medley(title: "", songs: [Song(chords: "", key: "")])

    
    var body: some View {
        List {
            Section(content: {
                ForEach(medleyData.medleys.indices, id: \.self) { index in
                    NavigationLink {
                        MedleyEditor(medley: $medleyData.medleys[index])
                    } label: {
                        MedleyRow(medley: medleyData.medleys[index])
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            medleyData.delete(medleyData.medleys[index])
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }, header: {
                Text("Events")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .fontWeight(.bold)
            })
        }
        .navigationTitle("Medley Chords")
        .toolbar {
            ToolbarItem {
                Button {
                    newMedley = Medley(title: "test", songs: [Song(chords: "F - G - A", key: "F")])
                    isAddingNewEvent = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MedleyList().environmentObject(MedleyData())
        }
    }
}
