import SwiftUI

struct CourseTileView: View {
    var course: Course

    var body: some View {
        ZStack {
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

            VStack {
                Spacer()
                HStack {
                    Text(course.title).bold().foregroundColor(.white).padding(5)
                    Spacer()
                }.background(.purple.opacity(0.8))
            }
        }
    }
}

struct CourseTileView_Previews: PreviewProvider {
    static var previews: some View {
        CourseTileView(
            course: Course(
                id: 14,
                title: "Create Apps on Your iPad - Swift Playgrounds for Beginners",
                subtitle: "Learn Swift and SwiftUI to Create Amazing Apps That You Will Submit to the App Store. All on Your iPad!",
                image: "https://zappycode.com/media/course_images/PlaygroundsCourseImageFULL.png"
            )
        ).frame(height: 200)
    }
}

