//: Playground - noun: a place where people can play
import Foundation

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let input = content.components(separatedBy: "\n")


// Question 1
func parseTotal(input: [String]) -> Int {
    
    let freqTotal = input.reduce(0, {
        guard let op = $1.first else {
            return $0
        }
        
        if let entry = Int($1.dropFirst()) {
            return op == "+" ? $0 + entry : $0 - entry
        } else {
            return $0
        }
        
    })
    
    return freqTotal
}

parseTotal(input: input)


// Question 2
func parseFirstRep(input: [String]) -> Int? {
    
    var set = Set<Int>()
    var firstRep : Int?
    
    var freqTotal = 0
    
    while firstRep == nil {
        freqTotal = input.reduce(freqTotal, {
            guard let op = $1.first else {
                return $0
            }
            
            if let entry = Int($1.dropFirst()) {
                let total = op == "+" ? $0 + entry : $0 - entry
                if set.contains(total) && firstRep == nil {
                    firstRep = total
                }
                set.insert(total)
                return total
            } else {
                return $0
            }
            
        })
    }
    
    return firstRep
}

parseFirstRep(input: input)
