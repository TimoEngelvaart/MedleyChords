import SwiftUI

struct MedleyList: View {
    @EnvironmentObject var medleyData: MedleyData
    
    var body: some View {
        NavigationView {
            List {
                Section(content: {
                    ForEach(medleyData.medleys.indices, id: \.self) { index in
                        NavigationLink(destination: MedleyDetail(medley: medleyData.medleys[index], isEditing: false)) {  // Updated this line
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
                    Text("Medleys")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .fontWeight(.bold)
                })
            }
            .navigationTitle("Medley Chords")
        }
    }
}

struct MedleyList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MedleyList().environmentObject(MedleyData())
        }
    }
}
