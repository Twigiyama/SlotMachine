//
//  SlotBrain.swift
//  SlotMachine2
//
//  Created by Asitha Rodrigo on 29/03/2015.
//  Copyright (c) 2015 Twig. All rights reserved.
//

import Foundation

class SlotBrain {
    
    class func unpackSlotIntoRows (slots: [[Slot]]) -> [[Slot]] {
        
        var slotRow: [[Slot]] = [[]]
        //var slotRow2: [Slot] = []
        //var slotRow3: [Slot] = []
        
        for slotArray in slots {
  
            for var index = 0; index < slotArray.count; index++ {
                
                if slotArray.count > slotRow.count {
                    slotRow.append([])
                }
                
                let slot = slotArray[index]
                slotRow[index].append(slot)
            }
        }
        
    return slotRow
    
    }
    
    class func computeWinnings (slots: [[Slot]]) -> Int {
        
        var slotsInRows = unpackSlotIntoRows(slots)
        var winnings = 0
        
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        
        for slotRow in slotsInRows {
            
            if checkFlush(slotRow) == true {
                println("flush")
                winnings += 1
                flushWinCount += 1
            }
            
            if checkThreeInARow(slotRow) == true {
                println("Three in a row")
                winnings += 1
                straightWinCount += 1
            }
            
            if checkThreeOfAKind(slotRow) == true {
                println("Three of a Kind")
                winnings += 3
                threeOfAKindWinCount += 1
            }
        }
        
        if flushWinCount == 3 {
            println("Royal Flush")
            winnings += 15
        }
        
        if straightWinCount == 3 {
            println("Epic Straight")
            winnings += 1000
        }
        
        if threeOfAKindWinCount == 3 {
            println("Threes all around")
            winnings += 50
        }

        return winnings
    }
    
    class func checkFlush (slotRow: [Slot]) -> Bool {
        var checkMultiple: Bool = false
        var numberReds: Int = 0
        
        for slot in slotRow {
            
            if slot.isRed {
                ++numberReds
            }
        }
        
        if (numberReds >= 3) || (numberReds == 0) {
            checkMultiple = true
        }
        return checkMultiple
    }
    
    
    
    class func checkThreeInARow (slotRow: [Slot]) -> Bool {
        var checkMultiple = false
        var numberOfAscHits = 1
        var largestAscSequence = 1
        var numberOfDscHits = 1
        var largestDscSequence = 1
        
        //Count number of ascending numbers in a row
        for (index, slot) in enumerate(slotRow) {
            if index < slotRow.count - 1{
                if slot.value - slotRow[index+1].value == -1 {
                    ++numberOfAscHits
                }
                else {
                    if numberOfAscHits > largestAscSequence {
                        largestAscSequence = numberOfAscHits
                        numberOfAscHits = 1
                    }
                    else {
                        numberOfAscHits = 1
                    }
                }
            }
        }
        
        //Count number of descending numbers in a row
        for (index, slot) in enumerate(slotRow) {
            if index < slotRow.count - 1{
                if slot.value - slotRow[index+1].value == 1 {
                    ++numberOfDscHits
                }
                else {
                    
                    if numberOfDscHits > largestDscSequence {
                        largestDscSequence = numberOfDscHits
                        numberOfDscHits = 1
                    }
                    else {
                        numberOfDscHits = 1
                    }
                }
            }
        }
        
        if abs(largestAscSequence) >= 3 || abs(largestDscSequence) >= 3 {
            checkMultiple = true
        }
        
        return checkMultiple
    }


    class func checkThreeOfAKind (slotRow: [Slot]) -> Bool {
        
        var checkMultiple = false
        var numberOfHits = 0
        var hitsArray = Array(count: 13, repeatedValue: 0)
        
        for (index, slot) in enumerate(slotRow) {
            ++hitsArray[slot.value - 1]
        }
        if maxElement(hitsArray) >= 3 {
            checkMultiple = true
        }
        
        return checkMultiple
    }

}