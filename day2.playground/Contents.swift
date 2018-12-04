import Foundation

// Parse the file as an array of strings
let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let input = content.components(separatedBy: "\n").filter{ $0 != "" }


// Question 1
func checksum(input: [String]) -> Int {
    
    // Set your amount of doubles and triples
    var doubles = 0
    var triples = 0
    
    // Go through all the strings
    for str in input {
        
        // Create a dictionary to store all the different characters in the string
        var dict : [Character: Int] = [:]
        
        // Go through all the characters in the string and increment the value of each character you see in your dictionary
        for char in str {
            if let value = dict[char] {
                dict[char] = value + 1
            } else {
                dict[char] = 1
            }
        }

        // Add to the doubles if there was atleast one set
        doubles += dict.values.contains(2) ? 1 : 0
        
        // Add to the triples if there was atleast one set
        triples += dict.values.contains(3) ? 1 : 0

    }
    
    // Return the checksum
    return doubles * triples
}

checksum(input: input)


// Question 2
func findCharDiff(input: [String]) -> String {
    
    // Make a copy of the input, so we can mutate it later
    var inputCopy = input
    
    // Iterate through the entire list
    for (firstIndex, first) in input.enumerated() {
        
        // For each string, compare it to every other string
        for second in input {
            
            // Check to see if the character difference is equal to 1
            let diffOfOne = zip(first, second).filter{ $0 != $1 }.count == 1
            
            if diffOfOne {
                
                // Store the removal Index
                var removalIndex = 0
                
                // Compare each element to find differing index
                for (i, (first1, second1)) in zip(first, second).enumerated() {
                    if first1 != second1 {
                        removalIndex = i
                    }
                }
                
                // Convert to String.Index
                let s = inputCopy[firstIndex]
                guard let i = s.index(s.startIndex, offsetBy: removalIndex, limitedBy: s.endIndex) else {
                    // Never happen
                    print("yo")
                    return ""
                }
                
                // Remove the differing character and return the string
                inputCopy[firstIndex].remove(at: i)
                return inputCopy[firstIndex]

            }
        }
    }
    
    return ""
}

findCharDiff(input: input)
