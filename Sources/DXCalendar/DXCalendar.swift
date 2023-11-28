//
//  DXCalendar
//

import SwiftUI

public struct DXCalendar<Configuration>: View where Configuration: DXCalendarDelegate {
    @StateObject var configuration: Configuration
    @State private var monthSelected = Calendar.current.component(.month, from: Date())
    private let viewModel = DXCalendarViewModel()

    public init(configuration: Configuration) {
        self._configuration = StateObject(wrappedValue: configuration)
    }
    
    public var body: some View {
        VStack {
            TabView(selection: $monthSelected) {
                ForEach((-configuration.dx_numberOfPastMonthsToShow..<configuration.dx_numberOfForwardMonthsToShow), id: \.self) { offset in
                    let monthDate: Date = Calendar.current.date(byAdding: .month, value: offset, to: Date())!
                    let monthNumber = Calendar.current.component(.month, from: monthDate)
                    let yearNumber = Calendar.current.component(.year, from: monthDate)
                    
                    VStack {
                        configuration.dxCalendarTitleView(date: monthDate)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
                            let weekDays = viewModel.getDayNames(format: configuration.dx_weekDaysFormat, codeLang: configuration.dx_weekDaysLanguage)
                            ForEach(weekDays, id: \.self) { day in
                                configuration.dxCalendarWeekdayView(day: day)
                            }
                            
                            let calendar = viewModel.getCalendar(month: monthNumber, year: yearNumber)
                            ForEach(calendar.indices, id: \.self) { weekIndex in
                                ForEach(calendar[weekIndex], id: \.self) { dayDate in
                                    configuration.dxCalendarDayView(day: dayDate, month: monthDate)
                                        .onTapGesture {
                                            configuration.dxCalendarDidSelect(day: dayDate, month: monthDate)
                                        }
                                }
                            }
                        }
                    }
                    .frame(height: configuration.dx_height, alignment: .top)
                    .tag(monthNumber)
                }
            }
            .frame(height: configuration.dx_height)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            configuration.dxCalendarLegendView()
        }
        .onChange(of: monthSelected) { value in
            configuration.dxCalendarDidChange(month: value)
        }
    }
}

struct DXCalendar_Previews: PreviewProvider {
    static var previews: some View {
        let configuration = DXCalendarDemoConfiguration()
        DXCalendar(configuration: configuration)
    }
}
