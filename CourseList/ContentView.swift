import SwiftUI

struct ContentView: View {
  @State var courses: [Course] = []

  var body: some View {
    if courses.count == 0 {
      VStack {
        ProgressView()
          .padding()

        Text("Loading data...")
          .padding()
          .onAppear(perform: { getCourses() })
      }
    } else {
      ScrollView {
        VStack {
          ForEach(courses) { course in
            AsyncImage(url: URL(string: course.image)) { phase in
              switch phase {
              case .success(let image):
                image.resizable().scaledToFill()
              default:
                VStack {
                  Image(systemName: "books.vertical")
                    .font(.largeTitle)
                    .padding(80)
                }.frame(maxWidth: .infinity).background(.gray)
              }
            }
          }
        }
      }
    }
  }

  func getCourses() {
    if let apiUrl = URL(string: "https://zappycode.com/api/courses?format=json") {
      var request = URLRequest(url: apiUrl)
      request.httpMethod = "GET"

      URLSession.shared.dataTask(with: request) { (data, response, error) in
        onCourses(data, error)
      }.resume()
    }
  }

  fileprivate func onCourses(_ data: Data?, _ error: Error?) {
    if error != nil {
      print("There was an error")
    }

    if data != nil {
      setCoursesFromData(data)
    }
  }

  fileprivate func setCoursesFromData(_ data: Data?) {
    if let coursesFromApi = try? JSONDecoder().decode([Course].self, from: data!) {
      courses = coursesFromApi
    }
  }

}

struct Course: Codable, Identifiable {
  var id: Int
  var title: String
  var subtitle: String
  var image: String
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

