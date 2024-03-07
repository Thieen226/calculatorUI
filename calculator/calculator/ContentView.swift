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
    @State private var isClicked : Bool = false
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
                        .padding(.trailing, 40)
                        .foregroundColor(.white)
                        .font(.system(size: display.count > 6 ? 78 : 88, weight: .light)) //if the number is more than 6 digits then decrease the size
                }
                ForEach(numsAndOperations, id: \.self){row in //access the row in the 2D array
                    HStack{ //align the each row horizontally
                        ForEach(row, id: \.self) {char in //access the numbers and operations in the row
                            switch char{
                            case "=", "+", "-", "x", "÷" : //manage when the operation and equal signs are clicked
                                Button(char, action: {operationCalc(char)})
                                    .frame(width: 80, height: 80)
                                    .background(Color.orange)
                                    .cornerRadius(100)
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
                                
                            case "1"..."9", "." : //manage when numbers and . are clicked
                                Button(char, action: {manageBtn(char)})
                                    .frame(width: 80, height: 80)
                                    .background(Color(UIColor.darkGray))
                                    .cornerRadius(100)
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
                            case "0" : //style 0 button differently
                                Button(char, action: {manageBtn(char)})
                                    .padding(.leading, 30)
                                    .frame(width: 170, height: 80, alignment: .leading)
                                    .background(Color(UIColor.darkGray))
                                    .cornerRadius(100)
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
                                
                            default: //manage AC, +/- or % are clicked
                                Button(char, action: {manageBtn(char)})
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
    func operationCalc(_ char : String){
        switch char{
        case "÷", "x", "-", "+":
            operations = char
            firstNum = display
            display = "0"
        default:
            secondNum = display
            manageOperations()
        }
    }
    
    func manageOperations(){
        if !firstNum.isEmpty && !secondNum.isEmpty{
            switch operations{
            case "÷" :
                divideNums(firstNum, secondNum)
            case "-" :
                subtractNums(firstNum, secondNum)
            case "x" :
                multiplyNums(firstNum, secondNum)
            case "+" :
                addNums(firstNum, secondNum)
            default:
                break
            }
        }
    }
    
    func manageBtn(_ char : String){
        if let _ = Int(char){
            if display == "0"{
                display = char
            }
            else{
                display += char
            }
        }
        if char == "."{
            display += char
        }
        else if char == "AC"{
            display = "0"
            firstNum = ""
            secondNum = ""
        }
        else if char == "+/-" && display != "0"{
            if let number = Int(display){
                display = String(-number)
            }
        }
        else if char == "%"{
            if let num = Double(display){
                display = String(num/100)
            }
        }
    }
    
    func divideNums(_ firstNum : String, _ secondNum : String){
        if let num1 = Double(firstNum), let num2 = Double(secondNum), num2 != 0{
            display = String(format: "%.2f", num1/num2)
        }
        else{
            display = "Error"
        }
    }
    func subtractNums(_ firstNum : String, _ secondNum : String){
        if !firstNum.contains(".") && !secondNum.contains("."){
            if let num1 = Int(firstNum), let num2 = Int(secondNum){
                display = String(num1 - num2)
            }
        }
        else{
            if let num1 = Double(firstNum), let num2 = Double(secondNum){
                display = String(num1 - num2)
            }
        }
    }
    
    func multiplyNums(_ firstNum : String, _ secondNum : String){
        if !firstNum.contains(".") && !secondNum.contains("."){
            if let num1 = Int(firstNum), let num2 = Int(secondNum){
                display = String(num1 * num2)
            }
        }
        else{
            if let num1 = Double(firstNum), let num2 = Double(secondNum){
                display = String(format: "%.2f", num1 * num2)
            }
        }
    }
    func addNums(_ firstNum : String, _ secondNum : String){
        if !firstNum.contains(".") && !secondNum.contains("."){
            if let num1 = Int(firstNum), let num2 = Int(secondNum){
                display = String(num1 + num2)
            }
        }
        else{
            if let num1 = Double(firstNum), let num2 = Double(secondNum){
                display = String(num1 + num2)
            }
        }
    }
}
    

#Preview {
    ContentView()
}
