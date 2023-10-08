import SwiftUI

struct MedleyRow: View {
    let medley: Medley
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(medley.title)
                    .fontWeight(.bold)
            }
        }
    }
}

struct MedleyRow_Previews: PreviewProvider {
    static var previews: some View {
        MedleyRow(medley: Medley.example)
    }
}
