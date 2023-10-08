import SwiftUI

struct MedleyDetail: View {
    @Binding var medley: Medley
    let isEditing: Bool
    
    @State private var isPickingSymbol = false
    
    var body: some View {
        List {
            HStack {
                Button {
                    isPickingSymbol.toggle()
                } label: {
                    Text("Click Me!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .cornerRadius(10)
          
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 5)

                if isEditing {
                    TextField("New Event", text: $medley.title)
                        .font(.title2)
                } else {
                    Text(medley.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            
            if isEditing {
               

            } else {
                HStack {
                  
                 
                }
                .listRowSeparator(.hidden)
            }
            
            Text("Songs")
                .fontWeight(.bold)
            
//            ForEach($event.tasks) { $item in
//                TaskRow(task: $item, isEditing: isEditing)
//            }
//            .onDelete(perform: { indexSet in
//                event.tasks.remove(atOffsets: indexSet)
//            })
            
            Button {
                medley.songs.append(Song(chords: "", key: ""))
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Song")
                }
            }
            .buttonStyle(.borderless)
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .sheet(isPresented: $isPickingSymbol) {
//            SymbolPicker(event: $event)
        }
    }
}

struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        MedleyDetail(medley: .constant(Medley.example), isEditing: true)
    }
}
