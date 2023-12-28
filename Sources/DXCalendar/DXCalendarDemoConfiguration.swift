//
//  DXCalendar
//  Example configuration
//

import SwiftUI


final class DXCalendarDemoConfiguration: ObservableObject {
    @Published var selectedDay = Date()
}

extension DXCalendarDemoConfiguration: DXCalendarDelegate {
    var dx_numberOfPastMonthsToShow: Int { 6 }
    var dx_numberOfForwardMonthsToShow: Int { 6 }
    var dx_height: CGFloat { 300.0 }
    var dx_weekDaysFormat: String { "EEE" }
    var dx_weekDaysLanguage: String { "en" }
    var dx_rowSpacing: CGFloat { 10 }
    
    func dxCalendarDidChange(month: Int) {
        // Do something when month changes
    }
    
    func dxCalendarDidSelect(day: Date?, month: Date) {
        if let day = day {
            let selectedMonth = Calendar.current.component(.month, from: day)
            let actualMonth = Calendar.current.component(.month, from: month)
            if selectedMonth == actualMonth {
                selectedDay = day
            }
        }
    }
    func dxCalendarWeekdayView(day: String) -> some View {
        Text(day)
            .frame(width: 30, height: 20)
            .font(.system(size: 10, weight: .bold))
            .foregroundStyle(.gray)
    }
    func dxCalendarTitleView(date: Date?) -> some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        var title: String = ""
        if let date = date {
            title = dateFormatter.string(from: date).capitalized
        }
        
        return Text(title)
            .font(.system(size: 16, weight: .bold))
            .padding(.bottom, 8)
    }
    
    func dxCalendarDayView(day: Date?, month: Date) -> some View {
        VStack {
            if let day = day {
                let isActualDay: Bool = Calendar.current.isDateInToday(day)
                let selected: Bool = selectedDay == day
                
                let selectedMonth = Calendar.current.component(.month, from: day)
                let actualMonth = Calendar.current.component(.month, from: month)

                VStack {
                    Text("\(Calendar.current.component(.day, from: day))")
                        .font(isActualDay ? .system(size: 17, weight: .bold) : .system(size: 13))
                        .foregroundColor(selectedMonth == actualMonth ? (selected ? .white : .black) : .clear)
                }
                .frame(width: 30, height: 30)
                .background(selectedMonth == actualMonth ? (selected ? Color.blue : .clear) : .clear)
                .cornerRadius(5)
            } else {
                Text(" ")
            }
        }
    }
    
    func dxCalendarLegendView() -> some View {
        HStack(spacing: 30) {
            HStack(spacing: 5) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundStyle(.green)
                    .frame(width: 10, height: 10)
                Text("Available")
                    .font(.system(size: 12))
            }
            HStack(spacing: 5) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundStyle(.red)
                    .frame(width: 10, height: 10)
                Text("Not available")
                    .font(.system(size: 12))
            }
        }
    }


}
