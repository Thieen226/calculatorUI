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
                            if char == "=" || char == "+" || char == "-" || char == "x" || char == "÷"{
                                Button(char, action: {operationCalc()})
                                    .frame(width: 80, height: 80)
                                    .background(Color.orange)
                                    .cornerRadius(100)
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
                            }
                            else if char == "1" || char == "2" || char == "3" || char == "4" || char == "5" || char == "6" || char == "7" || char == "8" || char == "9" || char == "."{
                                Button(char, action: {isNum = true; showNum()})
                                    .frame(width: 80, height: 80)
                                    .background(Color(UIColor.darkGray))
                                    .cornerRadius(100)
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
                            }
                            else if char == "0"{
                                Button(char, action: {isNumber = true; showNum()})
                                    .padding(.leading, 30)
                                    .frame(width: 170, height: 80, alignment: .leading)
                                    .background(Color(UIColor.darkGray))
                                    .cornerRadius(100)
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
                                    
                            }
                            else{
                                Button(char, action: {showNum()})
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
        
    }
    
    func showNum(_ char : String){
        if char.isNumber{
            if display == "0" || display == "."{
                display = char
            }
            else{
                display += char
            }
        }
    }
}

#Preview {
    ContentView()
}
