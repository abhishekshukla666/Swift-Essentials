

import Foundation

let customQueue = DispatchQueue(label: "CustomQueue", attributes: [.concurrent])
let semaphore = DispatchSemaphore(value: 1)
var totalTickets = 10

let tickets = [2:"A", 3:"B", 5:"C", 4:"D"]

func bookTicket() {
    customQueue.async {
        for ticket in tickets {
//            semaphore.wait()
            sleep(1)
            if totalTickets >= ticket.key {
                totalTickets -= ticket.key
                debugPrint("Ticket booked for \(ticket.value)")
            }
//            semaphore.signal()
        }
    }
}

func doSomeOtherStuff() {
    debugPrint("Do some other stuff")
}

bookTicket()
doSomeOtherStuff()
