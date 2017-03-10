///
/// User.swift
///

import Foundation

final class User {
    
    static let sharedInstance = User()
    
    fileprivate let STORED_EVENTS_COUNT = 5
    
    var dataStore = DataStore()
    let defaults = UserDefaults.standard
    var state = ""
    
    private init() {}
}


extension User {
    
    func fetchMembers() {
        dataStore.members = CongressMember.all(for: state)
    }
    
    func fetchEvents(handler: @escaping () -> ()) {
        let backgroundQueue = DispatchQueue.global()
        let group = DispatchGroup()
        
        dataStore.members.forEach { member in
            group.enter()
            backgroundQueue.async(group: group, execute: {
                member.fetchEvents() { events in
                    member.events = events
                    group.leave()
                }
            })
        }
        
        group.notify(queue: DispatchQueue.main, execute: {
            self.selectMostRecentEvents()
            self.mergeEvents()
            handler()
        })
    }
    
    fileprivate func selectMostRecentEvents() {
        dataStore.members = dataStore.members.map { member in
            member.events = orderByRecency(member.events)
            return member
        }
    }
    
    fileprivate func orderByRecency(_ events: [Event]) -> [Event] {
        let sorted = events.sorted { $0.0.date > $0.1.date }
        let mostRecent = Array(sorted.prefix(STORED_EVENTS_COUNT))
        return mostRecent
    }
    
    fileprivate func mergeEvents() {
        let mergedEvents = identifyDuplicateEvents()
        dataStore.members = dataStore.members.map { return resetEvents(for: $0, mergedEvents) }
    }
    
    fileprivate func identifyDuplicateEvents() -> [(Int, [CongressMember])] {
        let members = dataStore.members
        let uniqueEvents = Set(members.flatMap({ $0.events.map({ $0.hashValue }) }))
        return uniqueEvents.map { identifier -> (Int, [CongressMember]) in
            let participants = members.filter({ $0.events.map({ $0.hashValue }).contains(identifier) })
            return (identifier, participants)
        }
    }
        
    fileprivate func resetEvents(for member: CongressMember, _ mergedEvents: [(Int, [CongressMember])]) -> CongressMember {
        let newMember = member
        newMember.events = newMember.events.map { event in
            var newEvent = event
            mergedEvents.forEach { if event.hashValue == $0.0 { newEvent.congressMembers = $0.1 } }
            return newEvent
        }
        return newMember
    }
}
