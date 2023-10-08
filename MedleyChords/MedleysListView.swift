//import SwiftUI
//
//struct MedleysListView: View {
//    @State private var medleys: [Medley] = []
//    @State private var showingAddMedleyView = false
//
//    var body: some View {
//        NavigationView {
//            List(medleys) { medley in
//                Text("Medley \(medley.id)")
//            }
//            .navigationBarTitle("Medleys")
//            .navigationBarItems(trailing: Button(action: {
//                showingAddMedleyView = true
//            }) {
//                Image(systemName: "plus")
//            })
//        }
//        .sheet(isPresented: $showingAddMedleyView) {
//            AddMedleyView(medleys: $medleys)
//        }
//    }
//}
