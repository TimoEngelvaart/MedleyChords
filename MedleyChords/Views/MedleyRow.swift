import SwiftUI

struct MedleyRow: View {
    let medley: Medley
    var body: some View {
        Text(medley.title)
            .fontWeight(.bold)
    }
}

#Preview {
    MedleyRow(medley: Medley.sampleData[0])
}
