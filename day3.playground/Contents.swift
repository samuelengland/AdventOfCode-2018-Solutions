import Foundation

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

// Force unwrap, because why not
let input = content.components(separatedBy: "\n").map { $0.replacingOccurrences(of: " ", with: "").components(separatedBy: "@").last! }.filter{ $0 != "" }

// Problem #1
func calculateClaims(input: [String]) -> Int {
    
    // Create a grid to store the values in... there is probably a better way to do this without initally using a bunch of space
    var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: 1200), count: 1200)
    
    // For each entry parse out the position components and area components
    for entry in input {
        let components = entry.components(separatedBy: CharacterSet(charactersIn: ",:x"))
        guard let x = Int(components[0]),
              let y = Int(components[1]),
              let width = Int(components[2]),
              let height = Int(components[3]) else {
            return 0
        }
        
        // For each row
        for i in 0...width-1 {
            // For each column
            for j in 0...height-1 {
                // Add 1 to the position
                grid[x+i][y+j] = grid[x+i][y+j] + 1
            }
        }
    }
    
    return grid.reduce(0, {
        return $0 + $1.reduce(0, {
            return $1 > 1 ? $0 + 1 : $0
        })
    })

}

// Problem #2
func intactClaim(input: [String]) -> Int {
    
    // Create a grid to store the values in... there is probably a better way to do this without initally using a bunch of space
    var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: 1200), count: 1200)
    
    // For each entry parse out the position components and area components
    for entry in input {
        let components = entry.components(separatedBy: CharacterSet(charactersIn: ",:x"))
        guard let x = Int(components[0]),
            let y = Int(components[1]),
            let width = Int(components[2]),
            let height = Int(components[3]) else {
                return 0
        }
        
        // For each row
        for i in 0...width-1 {
            // For each column
            for j in 0...height-1 {
                // Add 1 to the position
                grid[x+i][y+j] = grid[x+i][y+j] + 1
            }
        }
    }
    
    // Go over the entire array again and check but this time we care about the index
    for (index, entry) in input.enumerated() {
        let components = entry.components(separatedBy: CharacterSet(charactersIn: ",:x"))
        guard let x = Int(components[0]),
            let y = Int(components[1]),
            let width = Int(components[2]),
            let height = Int(components[3]) else {
                return 0
        }
        
        // Flag to tell whether the claim is one we are looking for
        var correctClaim = true
        
        // Loop over every position in the claim, if any are over 1, we know its not the claim we are looking for
        claimLoop: for i in 0...width-1 {
            // For each column
            for j in 0...height-1 {
                // Add 1 to the position
                if grid[x+i][y+j] > 1 {
                    correctClaim = false
                    break claimLoop
                }
            }
        }
        
        // If the claim is correct, return the index + 1 (since index starts at 0 and the claims start at 1)
        if correctClaim {
            return index + 1
        }
    }
    
    return 0
}

calculateClaims(input: input)
intactClaim(input: input)

