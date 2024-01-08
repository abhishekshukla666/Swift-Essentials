
/*
 1. What is opaque type
 */

print("====================")

/* 2. print this for closure function */
func getNum() -> Int {
    print("getnum")
    return 5
}

func getNumC(_ result: () -> Bool) {
    print(result())
    print("inside getnum clousere")
}

print(getNumC({ getNum() == 5 }))
print("====================")

/* 3. print this for loop */
let num: [Any?] = ["a", 16, nil, "b", 12.32]

for n in num where n is String? {
    print(n)
}
for case let .some(n) in num where n is String {
    print(n)
}
print("====================")

/* 4. print this enum allcases */
enum Demo: CaseIterable {
    case a
    case b(value: String)
    case c
    case d
    
    /* This needs to be added if cases are not identical */
    static var allCases: [Demo] {
        return [.a, .c]
    }
}

print(Demo.allCases.count)
print("====================")


/* Difference between class & static */

/* Task and Task Group */

/* Design Patterns */

/* Architecture Design Patterns */

/* Count all palindrom substring */
