

import Foundation

struct Ticket {
    let key: Int
    let value: String
}

class RaceConditionDemo {
    let customQueue = DispatchQueue(label: "CustomQueue", attributes: [.concurrent])
    let semaphore   = DispatchSemaphore(value: 1)
    
    private(set) var totalTickets = 5
    
    func buyTicket(_ tickets: [Ticket]) {
        for ticket in tickets {
            customQueue.async {
                self.bookTicket(ticket)
            }
        }
    }
    
    func bookTicket(_ ticket: Ticket) {
        semaphore.wait()
        debugPrint("Started booking for \(ticket.value)")
        sleep(1)
        if totalTickets >= ticket.key {
            totalTickets -= ticket.key
            debugPrint("Sucessfull, Ticket booked for \(ticket.value)")
        } else {
            debugPrint("Unsuccessfull, Ticket not booked for \(ticket.value)")
        }
        semaphore.signal()
    }
    
    func doSomeOtherStuff() {
        debugPrint("Do some other stuff")
    }
}

let rcDemo = RaceConditionDemo()
let tickets = [
    Ticket(key: 3, value: "A"),
    Ticket(key: 2, value: "B"),
    Ticket(key: 4, value: "C"),
    Ticket(key: 2, value: "D")
]
rcDemo.buyTicket(tickets)
rcDemo.doSomeOtherStuff()
