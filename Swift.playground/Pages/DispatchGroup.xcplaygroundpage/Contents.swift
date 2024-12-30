
import Foundation

func doTest() {
    let otherQueue = DispatchQueue(label: "otherQueue")
    
    DispatchQueue.main.async {
        print("First \(Thread.isMainThread)")  // Prints whether it's on the main thread or not
        otherQueue.sync {
            print("Second \(Thread.isMainThread)")  // Prints whether it's on the main thread or not
        }
        otherQueue.async {
            print("Third \(Thread.isMainThread)")  // Prints whether it's on the main thread or not
        }
    }
}

// doTest()

func testDispatchGroup() {
    let group = DispatchGroup ( )
    group.enter ()
    DispatchQueue.global().async {
        sleep(2)
        print("1")
        group.leave()
    }
        
    group.enter()
    DispatchQueue.global().async {
        sleep(1)
        print("2")
        group.leave( )
    }
    
    group.notify( queue: .main) {
        print( "All tasks completed")
        print( "Tasks" )
    }
}

testDispatchGroup()

/*
let customQueue = DispatchQueue(
    label: "com.custom.queue",
    attributes: [.concurrent]
)
print("start")
customQueue.sync {
    customQueue.sync {
        for n in 1...10 {
            print(n)
        }
    }
    for n in 11...20 {
        print(n)
    }
}

print("end")

*/



//let concurrentQueue = DispatchQueue(label: "com.concurrent.queue", attributes: [.concurrent])
////
//concurrentQueue.async {
//    for n in 1...1000 {
//        print(n)
//    }
//}
//
//concurrentQueue.sync {
//    for n in 1100...2000 {
//        print(n)
//    }
//}

//DispatchQueue.main.async {
//    for n in 0...9 {
//        print(n)
//    }
//
//    DispatchQueue.main.sync {
//        for n in 10...20 {
//            print(n)
//        }
//    }
//
//
//}


/*

 

let group = DispatchGroup()

func say(_ text: String, completion: @escaping () -> ()) {
    let delay = Double.random(in: 0...0)
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        print(text)
        completion()
    }
}

print("Hi")

group.enter()
say("I love cookies") {
    group.leave()
}

group.enter()
say("My dog is called Emma") {
    group.leave()
}

group.enter()
say("I develop iOS apps") {
//    group.leave()
}

group.notify(queue: .main) {
    print("Goodbye")
}

*/
