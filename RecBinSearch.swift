//
// RecBinSearch.swift
//
//  Created by Nicolas Riscalas
//  Created on 2023-03-05
//  Version 1.0
//  Copyright (c) 2023 Nicolas Riscalas. All rights reserved.
//
//  Does a binary search

import Foundation

// Define a function to find the index of the requested number using binary search
func binarySearch(_ arr: [Int], _ target: Int) -> Int? {
    return binarySearch(arr, target: target, low: 0, high: arr.count - 1)
}

func binarySearch(_ arr: [Int], target: Int, low: Int, high: Int) -> Int? {
    // If the low is bigger than the high then the number won't exist
    if low > high {
        return nil
    }
    // calculate the middle
    let mid = (low + high) / 2
    // If the number is the same then return the mid
    if arr[mid] == target {
        return mid
    // If the number is less then change the low to low + 1
    } else if arr[mid] < target {
        return binarySearch(arr, target: target, low: mid + 1, high: high)
    // If the number is bigger then change the high to mid - 1
    } else {
        return binarySearch(arr, target: target, low: low, high: mid - 1)
    }
}

// Define input and output file paths
let inputFilePath = "input.txt"
let outputFilePath = "output.txt"
var lineNumber = 0
// Read input from file
if let inputString = try? String(contentsOfFile: inputFilePath) {
    // Separate the input into lines
    let inputLines = inputString.components(separatedBy: .newlines)

    // Search for target number in each line and append the result to answers array
    var answers = [String]()
    for line in inputLines {
        // logic for having a proper order in terms of logic
        if let targetedNum = Int(line), lineNumber % 2 != 0 {
            let randomNumbers = inputLines[lineNumber - 1].components(separatedBy: " ").compactMap { Int($0) }
            // create the numbers array then sort it
            var numbers = Array(randomNumbers[0...])
            numbers.sort()
            // call the function
            let index = binarySearch(numbers, targetedNum)
            // display the output
            if let index = index {
                let resultString = "\(targetedNum) is the \(index + 1) number in ascending order"
                answers.append(resultString)
            } else {
                let resultString = "\(targetedNum) was not found in file"
                answers.append(resultString)
            }
        }
        lineNumber += 1
    }

    // Write output to file
    let outputString = answers.joined(separator: "\n")
    do {
        try outputString.write(toFile: outputFilePath, atomically: true, encoding: .utf8)
    } catch {
        print("Error writing to file: \(error)")
    }
} else {
    print("Error reading input file.")
}
