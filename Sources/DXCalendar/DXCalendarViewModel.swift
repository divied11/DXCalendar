//
//  DXCalendar
//

import Foundation

final class DXCalendarViewModel {
    
    func getDayNames(format: String, codeLang: String) -> [String] {
        var days = [String]()
        
        let calendar = Calendar(identifier: .iso8601)
        let firstDayOfWeek = calendar.date(bySetting: .weekday, value: 2, of: Date())!
        
        for i in 0..<7 {
            let date = calendar.date(byAdding: .day, value: i, to: firstDayOfWeek)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.locale = Locale(identifier: codeLang)
            
            let dayName = dateFormatter.string(from: date)
            days.append(dayName.uppercased())
        }
        
        return days
    }
    
    func getCalendar(month: Int, year: Int) -> [[Date?]] {
        var dates = [[Date?]]()
        
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        
        guard let startDate = calendar.date(from: components), let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) else {
            return dates
        }
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startDate))!
        let endOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: endDate))!
        
        let numberOfWeeks = (calendar.dateComponents([.weekOfYear], from: startOfWeek, to: endOfWeek).weekOfYear ?? 0) + 1
        
        for week in 0..<numberOfWeeks {
            var weekArray = [Date?]()
            for day in 0...6 {
                let weekDays = week*7
                let sumDays = day+weekDays
                let calcDay = calendar.date(byAdding: .day, value: sumDays, to: startOfWeek)
                weekArray.append(calcDay)
            }
            dates.append(weekArray)
        }
        return dates
    }
}
