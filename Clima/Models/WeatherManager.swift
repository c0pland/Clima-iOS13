import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherMAnager: WeatherManager, weather: WeatherModel)
    func didFail(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e7dadc8612452cbf9475ba4f957aa245&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(city:String) {
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(urlString)
    }
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in if error != nil {
                self.delegate?.didFail(error: error!)
                return
            }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ data: Data) -> WeatherModel?{
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let conditionID = decodedData.weather[0].id
            let city = decodedData.name
            let temperature = decodedData.main.temp
            let weather = WeatherModel(conditionID: conditionID, temperature: temperature, city: city)
            return weather
        } catch {
            self.delegate?.didFail(error: error)
            return nil
        }
        
    }
}
