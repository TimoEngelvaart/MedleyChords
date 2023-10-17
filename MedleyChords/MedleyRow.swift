import SwiftUI

struct MedleyRow: View {
    let medley: Medley
    
    var body: some View {
        HStack {
            Text(medley.title)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    MedleyRow(medley: Medley.example)
}
