import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e7dadc8612452cbf9475ba4f957aa245&units=metric"
    func fetchWeather(city:String) {
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handler(data:urlRespons:error:))
            task.resume()
        }
    }
    func handler(data: Data?, urlRespons: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
