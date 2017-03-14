///
/// TimeSince.swift
///

import Foundation
// from https://samoylov.tech/2016/09/19/implementing-time-since-function-in-swift-3/

extension DateFormatter {

    func timeSince(from: Date, numericDates: Bool = false) -> String {
        let calendar = Calendar.current
        let now = NSDate()
        let earliest = now.earlierDate(from as Date)
        let latest = earliest == now as Date ? from : now as Date
        let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest as Date)
        
        var result = ""
        
        if components.year! >= 2 {
            result = "\(components.year!) years ago"
        } else if components.year! >= 1 {
            if numericDates {
                result = "1 year ago"
            } else {
                result = "Last year"
            }
        } else if components.month! >= 2 {
            result = "\(components.month!) months ago"
        } else if components.month! >= 1 {
            if numericDates {
                result = "1 month ago"
            } else {
                result = "Last month"
            }
        } else if components.weekOfYear! >= 2 {
            result = "\(components.weekOfYear!) weeks ago"
        } else if components.weekOfYear! >= 1 {
            if numericDates {
                result = "1 week ago"
            } else {
                result = "Last week"
            }
        } else if components.day! >= 2 {
            result = "\(components.day!) days ago"
        } else if components.day! >= 1 {
            if numericDates {
                result = "1 day ago"
            } else {
                result = "Yesterday"
            }
        } else if components.hour! >= 2 {
            result = "\(components.hour!) hours ago"
        } else if components.hour! >= 1 {
            if numericDates {
                result = "1 hour ago"
            } else {
                result = "An hour ago"
            }
        } else if components.minute! >= 2 {
            result = "\(components.minute!) minutes ago"
        } else if components.minute! >= 1 {
            if numericDates {
                result = "1 minute ago"
            } else {
                result = "A minute ago"
            }
        } else if components.second! >= 3 {
            result = "\(components.second!) seconds ago"
        } else {
            result = "Just now"
        }
        
        return result
    }
}
