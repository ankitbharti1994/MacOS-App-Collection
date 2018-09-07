//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport
import XCTest

struct NetworkManager<T: Decodable> {
    
    enum Result<T> {
        case Success(T)
        case Failure(Error)
    }

    func fetch(from urlString: String, _ completion: @escaping (Result<T>) -> ()) {
        
        let urlRequest = URLRequest(url: URL(string: urlString)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 45)
        let session = URLSession.shared
        session.dataTask(with: urlRequest) { (responseData, response, error) in
            var result : Result<T>
            if let data = responseData {
                let decoder = JSONDecoder()
                do {
                    let coursesList = try decoder.decode(T.self, from: data)
                    result = .Success(coursesList)
                }catch {
                    result = .Failure(CustomError.InvalidFile)
                }
            }else {
                result = .Failure(CustomError.DataNotFound)
            }
            completion(result)
        }.resume()
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true


NetworkManager<Courses>().fetch(from: ServerURL.RaywenderlichCourses) {
    switch $0 {
    case .Failure(let error):
        print(error)
    case .Success(let courses):
        print(courses)
    }
}

class NetworkTesting: XCTestCase {
    
    func testForData()  {
        let exceptation = self.expectation(description: "asyn task")
        NetworkManager<Courses>().fetch(from: ServerURL.RaywenderlichCourses) {
            switch $0 {
            case .Success(let data):
                XCTAssertGreaterThan(data.courses.count, 0)
            case .Failure(let error):
                XCTAssertNotNil(error)
            }
            exceptation.fulfill()
            PlaygroundPage.current.finishExecution()
        }
        wait(for: [exceptation], timeout: 45.0)
    }
}

NetworkTesting().testForData()


protocol Recognizable {
    var name: String { get }
}

func doSomeThing<T: Recognizable>(value: T) -> String {
    return value.name
}

struct User: Recognizable {
    var name: String {
        return "ankit"
    }
}

let user = doSomeThing(value: User())
