

let sum = [1,3,5] + [2,4,6]

func +(left: [Int], right: [Int]) -> [Int] {
    var result = [Int]()
    for (i, v) in left.enumerated() {
        result.append(left[i] + right[i])
    }
    return result
}

print(sum)


