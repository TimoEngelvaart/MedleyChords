import SwiftUI

struct MedleyEditor: View {
    @Binding var medley: Medley
    var isNew = false
    
    @State private var isDeleted = false
    @EnvironmentObject var medleyData: MedleyData
    @Environment(\.dismiss) private var dismiss
    
    // Keep a local copy in case we make edits, so we don't disrupt the list of events.
    // This is important for when the date changes and puts the event in a different section.
    @State private var medleyCopy = Medley(title: "", songs: [Song(title: "", chords: "String", key: "String")])
    @State private var isEditing = false
    
    private var isMedleyDeleted: Bool {
        !medleyData.exists(medley) && !isNew
    }
    
    var body: some View {
        VStack {
            MedleyDetail(medley: medleyCopy, isEditing: isNew ? true : isEditing)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        if isNew {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                    }
                    ToolbarItem {
                        Button {
                            if isNew {
                                medleyData.medleys.append(medleyCopy)
                                dismiss()
                            } else {
                                if isEditing && !isDeleted {
                                    print("Done, saving any changes to \(medley.title).")
                                    withAnimation {
                                        medley = medleyCopy // Put edits (if any) back in the store.
                                    }
                                }
                                isEditing.toggle()
                            }
                        } label: {
                            Text(isNew ? "Add" : (isEditing ? "Done" : "Edit"))
                        }
                    }
                }
                .onAppear {
                    medleyCopy = medley // Grab a copy in case we decide to make edits.
                }
                .disabled(isMedleyDeleted)

            if isEditing && !isNew {

                Button(role: .destructive, action: {
                    isDeleted = true
                    dismiss()
                    medleyData.delete(medley)
                }, label: {
                    Label("Delete Event", systemImage: "trash.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                })
                    .padding()
            }
        }
        .overlay(alignment: .center) {
            if isMedleyDeleted {
                Color(UIColor.systemBackground)
                Text("Event Deleted. Select an Event.")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct MedleyEditor_Previews: PreviewProvider {
    static var previews: some View {
        MedleyEditor(medley: .constant(Medley(title: "String", songs: [Song(title: "", chords: "", key: "String")])))
            .environmentObject(MedleyData()) // Add this line to provide EventData
    }
}
