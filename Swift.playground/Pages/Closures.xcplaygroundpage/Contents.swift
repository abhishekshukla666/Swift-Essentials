
/*
func sumFunction(_ a: Int, _ b: Int) -> Int {
    return a + b
}

let sumClosure: (_ a: Int, _ b: Int) -> Int = { (a, b) in
    return a + b
}

func say(_ s: String, completion: @escaping () -> ()) {
    print(s)
    completion()
}

debugPrint(sumFunction(3,5))
debugPrint(sumClosure(3,7))

say("Hello Say") {
 print("say completed")
}


var count = 3

let closure1: () -> () = { [count] in
    debugPrint("Captured: \(count)")
}

let closure2: () -> () = {
    debugPrint("Not captured: \(count)")
}

count += 3
closure1()
closure2()

*/

//
//func addition(_ num1: Int, _ num2: Int, sum: @escaping (_ result: Int) -> ()) {
//    sum(num1 + num2)
//}
//
//addition(5, 7) { result in
//    print(result)
//}
//
//var count = 1
//
//debugPrint("Step 1")
//let closure1: () -> () = {[count] in
//    debugPrint(count)
//    debugPrint("Step 4")
//}
//
//let closure2: () -> () = {
//    debugPrint(count)
//    debugPrint("Step 5")
//}
//count += 1
//debugPrint("Step 2")
//
//closure1()
//closure2()

/*
func getNum() -> Int {
    print("Step 3")
    return 5
}

func getNumC(_ result: @escaping () -> Bool) {
    print("Step 1")
//    print(result())
    print("Step 4")
}

print("Started")
getNumC({
    print("Step 2")
    return getNum() == 5
})
print("Finished")
*/

/* Simple Closure */
let hello = {
    print("Hello Closure")
}

/* Closure with param */
let goodMorning: ((String) -> Void) = {(name) in
    print("Good morning \(name)")
}

/* Closure with return type */
/*
 let addTwoNumbers: ((Int, Int) -> Int) = {(num1, num2) in
     return num1 + num2
 }
 */
let addTwoNumbers = {(num1: Int, num2: Int) -> Int in
    return num1 + num2
}

/*
hello()
goodMorning("abhishek")
addTwoNumbers(5, 7)

func addition() -> (Int) -> Int {
    var sum = 0
    
    return { output in
        sum = sum + output
        return sum
    }
}

let op = addition()
let val1 = op(5)
let val2 = op(10)
let val3 = op(15)


var count = 1

let closure1 = { count in
    print(count)
    
}
count += 1
closure1("heelo")
*/

//func addUpEvenNumbersInArray(array: [Int], output: @escaping (Int) -> Void) {
//    let sum = array.filter { $0 % 2 == 0 }.reduce(0, +)
//    output(sum)
//}
//
//let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//addUpEvenNumbersInArray(array: array) { sum in
//    print("The sum of even numbers is \(sum).")
//}


/*
class ViewModel {
    var dataUpdate: ((Int) -> Void)?
    func getData() {
        print("getdata")
        dataUpdate?(1)
    }
}

class ViewController {
    var vm: ViewModel = ViewModel()
    
    func setup() {
        vm.dataUpdate = { [weak self] (value: Int) in
            guard let self = self else { return }
            print(value)
        }
        vm.getData()
    }
}

let vc = ViewController()
vc.setup()
 */

/* 
 --- Closure Retain Cycle ---
 
class River {
    let name: String
    var closure: (() -> ())?
    init(name: String) {
        self.name = name
        closure = {
            print("\(self.name) river init()")
        }
    }
    
    deinit {
        print("\(name) river deinit()")
    }
}

var ganga: River? = River(name: "Ganga")
ganga?.closure?()
ganga = nil
*/

var value = 1

let closure1 = { [value] in
    print("Closure1: ", value)
}

let closure2 = {
    print("Closure2: ", value)
}

value += 1

print("Last", value)

closure1()
closure2()
