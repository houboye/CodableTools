import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center,
               spacing: 20) {
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Click") {
                begin()
            }
            Spacer()
        }
    }
    
    private func begin() {
        let jsonString = """
        {
            "name":"zhy",
            "age":"18.5",
            "id": "11",
            "weight": "11.5"
        }
"""
        
        do {
            let p: Person = try CodableTools.jsonStringToModel(jsonString, using: .utf8)
            print(p.name)
            print(p)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
