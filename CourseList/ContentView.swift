import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear(perform: { getCourses() })
    }

    func getCourses() {
        if let apiUrl = URL(string: "https://zappycode.com/api/courses?format=json") {
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                onCourses(error, data)
            }.resume()
        }
    }

    fileprivate func onCourses(_ error: Error?, _ data: Data?) {
        if error != nil {
            print("There was an error")
        }

        if data != nil {
            print(String(data: data!, encoding: .utf8))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

