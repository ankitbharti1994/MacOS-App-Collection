import Foundation

public struct Courses: Decodable {
    public let courses: [Course]
}

public struct Course: Decodable {
    public let title   : String?
    public let url     : String?
    public let upcoming: [Upcoming]
}

public struct Upcoming: Decodable {
    public let start_date  : String?
    public let end_date    : String?
    public let instructors : String?
    public let location    : String?
}

public enum CustomError: Error {
    case DataNotFound
    case InvalidFile
}

public enum ServerURL {
    public static let RaywenderlichCourses = "http://bookapi.bignerdranch.com/courses.json"
}
