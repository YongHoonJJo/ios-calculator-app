//
//  Calculator.swift
//  Calculator
//
//  Created by Kim Do hyung on 2021/06/22.
//

import Foundation

struct Calculator {
    var infix: [Computable]
    
    mutating func convertToPostFix() throws -> [Computable] {
        var postfix: [Computable] = []
        var operatorStack = Stack<Operator>()
        
        for character in infix {
            if let value = character as? Operand {
                postfix.append(value)
            } else if let value = character as? Operator {
                while try !operatorStack.isEmpty() && value < operatorStack.peek() {
                    try postfix.append(operatorStack.pop())
                }
                operatorStack.push(object: value)
            }
        }
        
        while !operatorStack.isEmpty() {
            try postfix.append(operatorStack.pop())
        }
        
        return postfix
    }
    
    mutating func pushToInfix(with inputNotation: [String]) { // ["1", "+", "a", "3", "*", "5"]
        for value in inputNotation {
            if let operatorValue = Operator(rawValue: value) {
                infix.append(operatorValue)
            } else if let operandValue = Operand(operand: value) {
                infix.append(operandValue)
            }
        }
    }
}
