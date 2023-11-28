//
//  DXCalendar
//

import SwiftUI

public protocol DXCalendarDelegate: ObservableObject {
    associatedtype DXCalendarDayView: View
    associatedtype DXCalendarLegendView: View
    associatedtype DXCalendarTitleView: View
    associatedtype DXCalendarWeekdayView: View
    
    var dx_height: CGFloat { get }
    var dx_weekDaysFormat: String { get }
    var dx_weekDaysLanguage: String { get }
    var dx_numberOfPastMonthsToShow: Int { get }
    var dx_numberOfForwardMonthsToShow: Int { get }
    func dxCalendarDidChange(month: Int)
    func dxCalendarDidSelect(day: Date?, month: Date)
    func dxCalendarWeekdayView(day: String) -> DXCalendarWeekdayView
    func dxCalendarTitleView(date: Date?) -> DXCalendarTitleView
    func dxCalendarDayView(day: Date?, month: Date) -> DXCalendarDayView
    func dxCalendarLegendView() -> DXCalendarLegendView
}
