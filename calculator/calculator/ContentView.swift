//
//  ContentView.swift
//  calculator
//
//  Created by StudentAM on 3/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var numsAndOperations: [[String]] = [
        ["AC","+/-", "%", "÷"],
        ["7","8", "9", "x"],
        ["4","5", "6", "-"],
        ["1","2", "3", "+"],
        ["0", "." , "="]
    ]
    //create variables
    @State private var isClicked : String? = nil //keep track which button is clicked
    @State private var display = "0"
    @State private var firstNum : String = ""
    @State private var secondNum : String = ""
    @State private var operations : String = ""
    var body: some View {
        //change the whole background to black
        Color.black.ignoresSafeArea().overlay(
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Text(display)
                        .padding(.trailing, 40) //make the 0 to the right of the display
                        .foregroundColor(.white)
                        .font(.system(size: display.count > 6 ? 73 : 88, weight: .light)) //if the number is more than 6 digits then decrease the size
                        .lineLimit(1) //make the number appears only in 1 line
                }
                ForEach(numsAndOperations, id: \.self){row in //access the row in the 2D array
                    HStack{ //align the each row horizontally
                        ForEach(row, id: \.self) {char in //access the numbers and operations in the row
                            switch char{
                            case "=", "+", "-", "x", "÷" : //manage when the operation and equal signs are clicked
                                let isOperator = ["+", "-", "x", "÷"].contains(char) //check if the char is found in the array
                                Button(char, action: {
                                    operationCalc(char)
                                    isClicked = char //change the isClicked to the button that is clicked
                                })
                                .frame(width: 80, height: 80)
                                .background(isClicked == char && isOperator ? Color.white : Color.orange) //if the clicked button is an operation then change the background to white
                                .cornerRadius(100)
                                .foregroundColor(isClicked == char && isOperator ? Color.orange : Color.white) //if the clicked button is an operation then change the font to orange
                                .font(.system(size: 32))
                                .animation(.easeInOut(duration: 0.4), value: isClicked) //when isClicked changes value, animation will work
                                
                            case "1"..."9", "." : //manage when numbers and "."
                                Button(char, action: {
                                    manageBtn(char)
                                    isClicked = nil //reset the isClicked
                                })
                                .frame(width: 80, height: 80)
                                .background(Color(UIColor.darkGray))
                                .cornerRadius(100)
                                .foregroundColor(.white)
                                .font(.system(size: 32))
                            case "0" : //style 0 button differently
                                Button(char, action: {
                                    manageBtn(char)
                                    isClicked = nil
                                })
                                .padding(.leading, 30)
                                .frame(width: 170, height: 80, alignment: .leading)
                                .background(Color(UIColor.darkGray))
                                .cornerRadius(100)
                                .foregroundColor(.white)
                                .font(.system(size: 32))
                                
                            default: //manage and style AC, +/- or % are clicked
                                Button(char, action: {
                                    manageBtn(char)
                                    isClicked = nil
                                })
                                .frame(width: 80, height: 80)
                                .background(Color(UIColor.lightGray))
                                .cornerRadius(100)
                                .foregroundColor(.black)
                                .font(.system(size: 32))
                            }
                        }
                    }
                }
            }
        )
    }
    func operationCalc(_ char : String){ //manage the operation buttons
        switch char{
        case "÷", "x", "-", "+": //when operation buttons are clicked
            operations = char //store the operation that is clicked
            firstNum = display //store the first num
            display = "0" //reset the display
        default: //when the "=" button is clicked
            secondNum = display //store the second num
            manageOperations() //call the func to do the calculation
        }
    }
    
    func manageOperations(){
        if !firstNum.isEmpty && !secondNum.isEmpty{ //if first and second nums are entered
            switch operations{
            case "÷" :
                divideNums(firstNum, secondNum) //call func to deal with dividing
            case "-" :
                subtractNums(firstNum, secondNum) //call func to deal with subtracting
            case "x" :
                multiplyNums(firstNum, secondNum) //call func to deal with multiplying
            case "+" :
                addNums(firstNum, secondNum) //call func to deal with adding
            default:
                break
            }
        }
    }
    
    func manageBtn(_ char : String){ //manage all the numbers and "." buttons
        if let _ = Int(char){ //convert the char to int
            numsAndOperations[0][0] = "C" //change AC button to C when numbers are entered
            if display == "0"{ //if the display is 0
                display = char //display will change to new numbers that are entered
            }
            else{
                display += char //add numbers to the display
            }
        }
        if char == "."{ //if "." is entered
            numsAndOperations[0][0] = "C" //change AC button to C
            display += char //add it to the previous numbers
        }
        else if char == "AC" || char == "C"{ //if AC is clicked
            //reset the variables to do the calculation
            display = "0"
            firstNum = ""
            secondNum = ""
            numsAndOperations[0][0] = "AC"
        }
        else if char == "+/-" && display != "0"{ //if +/- is clicked and the display is not 0
            if let number = Int(display){ //convert the display num to int
                display = String(-number) //make the num to the opposite sign of that num
            }
        }
        else if char == "%"{ //if % is clicked
            if let num = Double(display){ //convert the display num to double
                display = String(num/100) //divide the num by 100 to convert num to a percentage
            }
        }
    }
    
    func divideNums(_ firstNum : String, _ secondNum : String){
        if let num1 = Double(firstNum), let num2 = Double(secondNum), num2 != 0{ //if the num2 is not 0
            let result = num1/num2 //divide num1 by num2
            display = String(result) //display the result
            
            if result.truncatingRemainder(dividingBy: 1) == 0{ //if the result is a whole number, then convert it to int
                display = String(Int(result))
            }
        }
        else{ //if num2 is 0, then it will show error
            display = "Error"
        }
    }
    func subtractNums(_ firstNum : String, _ secondNum : String){
        if let num1 = Double(firstNum), let num2 = Double(secondNum){ //convert num1 and num2 to double to handle desmos
            let result = num1 - num2
            display = String(result)
            
            if result.truncatingRemainder(dividingBy: 1) == 0{ //check if the result is whole number
                display = String(Int(result))
            }
        }
    }
    
    func multiplyNums(_ firstNum : String, _ secondNum : String){
        if let num1 = Double(firstNum), let num2 = Double(secondNum){
            let result = num1 * num2
            display = String(result)
            
            if result.truncatingRemainder(dividingBy: 1) == 0{ //check if the result is whole number
                display = String(Int(result))
            }
        }
    }
    
    func addNums(_ firstNum : String, _ secondNum : String){
        if let num1 = Double(firstNum), let num2 = Double(secondNum){
            let result = num1 + num2
            display = String(result)
            
            if result.truncatingRemainder(dividingBy: 1) == 0{ //check if the result is whole number
                display = String(Int(result))
            }
        }
    }
}
    

#Preview {
    ContentView()
}
