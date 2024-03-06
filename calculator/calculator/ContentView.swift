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
    @State private var isClicked : Bool = false
    @State private var display = "0"
    @State private var isNumber : Bool = false
    @State private var firstNum : Int = 0
    @State private var secondNum : Int = 0
    var body: some View {
        Color.black.ignoresSafeArea().overlay(
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Text(display)
                        .padding(.trailing, 40)
                        .foregroundColor(.white)
                        .font(.system(size: 88, weight: .light))
                }
                ForEach(numsAndOperations, id: \.self){row in
                    HStack{
                        ForEach(row, id: \.self) {char in
                            switch char{
                            case "=", "+", "-", "x", "÷" :
                                Button(char, action: {operationCalc()})
                                    .frame(width: 80, height: 80)
                                    .background(Color.orange)
                                    .cornerRadius(100)
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
            
                            case "1"..."9", "." :
                                Button(char, action: {manageBtn(char)})
                                    .frame(width: 80, height: 80)
                                    .background(Color(UIColor.darkGray))
                                    .cornerRadius(100)
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
                            case "0" :
                                Button(char, action: {manageBtn(char)})
                                    .padding(.leading, 30)
                                    .frame(width: 170, height: 80, alignment: .leading)
                                    .background(Color(UIColor.darkGray))
                                    .cornerRadius(100)
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
                                    
                            default:
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
    func operationCalc(){
//        switch char{
//        case "÷":
//        case "x":
//        case "-":
//        case "+":
//        }
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
}

#Preview {
    ContentView()
}
