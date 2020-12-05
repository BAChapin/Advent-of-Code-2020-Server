//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/4/20.
//

import Foundation

typealias PassportFieldInput = (field: String, value: String)

struct Passport: RawRepresentable {
    
    typealias PassportField = (field: Field, value: String)

    var fields: [PassportField]

    enum Field: Hashable {
        static let numberOfFields: Int = 7
        
        case birthYear
        case issueYear
        case expYear
        case height
        case hairColor
        case eyeColor
        case passportID
        case countryID
        case invalid

        var rawValue: String {
            switch self {
            case .birthYear:    return "byr"
            case .issueYear:    return "iyr"
            case .expYear:      return "eyr"
            case .height:       return "hgt"
            case .hairColor:    return "hcl"
            case .eyeColor:     return "ecl"
            case .passportID:   return "pid"
            case .countryID:    return "cid"
            case .invalid:      return "invalid"
            }
        }

        init(_ field: String) {
            switch field {
            case "byr":     self = .birthYear
            case "iyr":     self = .issueYear
            case "eyr":     self = .expYear
            case "hgt":     self = .height
            case "hcl":     self = .hairColor
            case "ecl":     self = .eyeColor
            case "pid":     self = .passportID
            case "cid":     self = .countryID
            default:        self = .invalid
            }
        }
        
        static var all: [Field] {
            return [.birthYear, .issueYear, .expYear, .height, .hairColor, .eyeColor, .passportID, .countryID]
        }
        
        static func random() -> Field {
            return all.randomElement()!
        }
        
        func isValid(_ value: String) -> Bool {
            switch self {
            case .birthYear:    return isValidBirthYear(value)
            case .issueYear:    return isValidIssueYear(value)
            case .expYear:      return isValidExpYear(value)
            case .height:       return isValidHeight(value)
            case .hairColor:    return isValidHairColor(value)
            case .eyeColor:     return isValidEyeColor(value)
            case .passportID:   return isValidPassportID(value)
            case .countryID:    return true
            default:            return false
            }
        }
        
        func generateValue(_ isCorrect: Bool, minimum: Int? = nil) -> String {
            switch self {
            case .birthYear:    return generateBirthYear(isCorrect)
            case .issueYear:    return generateIssueYear(isCorrect)
            case .expYear:      return generateExpYear(isCorrect)
            case .height:       return generateHeight(isCorrect)
            case .hairColor:    return generateHairColor(isCorrect)
            case .eyeColor:     return generateEyeColor()
            case .passportID:   return generatePassportID(isCorrect)
            case .countryID:    return generateCountryID()
            default:            return ""
            }
        }
        
        private func isValidBirthYear(_ value: String) -> Bool {
            let range = 1920...2002
            guard let num = Int(value) else { return false }
            return range.contains(num)
        }
        
        private func generateBirthYear(_ isValid: Bool) -> String {
            let range = 1920...2002
            return isValid ? String(Int.random(in: range)) : String(Int.random(in: 1800...2020))
        }
        
        private func isValidIssueYear(_ value: String) -> Bool {
            let range = 2010...2020
            guard let num = Int(value) else { return false }
            return range.contains(num)
        }
        
        private func generateIssueYear(_ isValid: Bool) -> String {
            let range = 2010...2020
            return isValid ? String(Int.random(in: range)) : String(Int.random(in: 2000...2020))
        }
        
        private func isValidExpYear(_ value: String) -> Bool {
            let range = 2020...2030
            guard let num = Int(value) else { return false }
            return range.contains(num)
        }
        
        private func generateExpYear(_ isValid: Bool) -> String {
            let range = 2020...2030
            return isValid ? String(Int.random(in: range)) : String(Int.random(in: 2010...2040))
        }
        
        private func isValidHeight(_ value: String) -> Bool {
            let newVal = String(value.dropLast(2))
            guard let num = Int(newVal) else { return false }
            if value.contains("cm") {
                let range = 150...193
                return range.contains(num)
            } else if value.contains("in") {
                let range = 59...76
                return range.contains(num)
            }
            
            return false
        }
        
        private func generateHeight(_ isValid: Bool) -> String {
            let isMetric = Bool.random()
            if isMetric {
                let range = 150...193
                return isValid ? "\(Int.random(in: range))cm" : "\(Int.random(in: 100...230))cm"
            } else {
                let range = 59...76
                return isValid ? "\(Int.random(in: range))in" : "\(Int.random(in: 40...95))in"
            }
        }
        
        private func isValidHairColor(_ value: String) -> Bool {
            let check = "0123456789abcdef"
            var newVal = value
            let first = newVal.remove(at: newVal.startIndex)
            if first == "#" {
                for char in newVal {
                    if !check.contains(char) {
                        return false
                    }
                }
                return true
            }
            
            return false
        }
        
        private func generateHairColor(_ isValid: Bool) -> String {
            let check = "0123456789abcdef"
            let badCheck = "0123456789abcdefghijklmnopqrstuvwxyz"
            var color: String = "#"
            for _ in 1...6 {
                color.append(isValid ? check.randomElement()! : badCheck.randomElement()!)
            }
            return color
        }
        
        private func isValidEyeColor(_ value: String) -> Bool {
            let options = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
            return options.contains(value)
        }
        
        private func generateEyeColor() -> String {
            let options = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
            return options.randomElement()!
        }
        
        private func isValidPassportID(_ value: String) -> Bool {
            guard let _ = Int(value) else { return false }
            return value.count == 9
        }
        
        private func generatePassportID(_ isValid: Bool) -> String {
            let numOfZeros: Int = Int.random(in: 0...8)
            var constructedString: String = ""
            for num in 1...9 {
                if num > numOfZeros {
                    constructedString.append(String(Int.random(in: 1...9)))
                } else {
                    constructedString.append("0")
                }
            }
            return constructedString
        }
        
        private func generateCountryID() -> String {
            return String(Int.random(in: 100..<1000))
        }
    }
    
    init(_ input: String) {
        var seperated = input.components(separatedBy: .whitespaces)
        seperated.removeAll(where: { $0 == "" })
        let items = seperated.map { $0.passportField() }
        self.fields = items.compactMap { (Field($0.field), $0.value) }
    }
    
    init(_ fields: [PassportField]) {
        self.fields = fields
    }
    
    static func generatePassportArray(from input: [String]) -> [String] {
        var tempArray: [String] = []
        var tempString: String = ""
        
        for entry in input {
            if entry == "" {
                tempArray.append(tempString)
                tempString = ""
            } else {
                tempString.append(" \(entry)")
            }
        }
        
        return tempArray
    }
    
    static func generatePassport(_ shouldContainAll: Bool) -> Passport {
        let shouldBeCorrect = Bool.random()
        
        if shouldContainAll && shouldBeCorrect {
            return generateAllCorrectPassport()
        } else if shouldContainAll {
            return generateAllPassport()
        } else if shouldBeCorrect {
            return generateCorrectPassport()
        }
        
        let numOfFields = Int.random(in: 1...6)
        var usableFields: [Field] = []
        var tempNum = 0
        var tempArray: [PassportField] = []
        
        for _ in 0...numOfFields {
            var added = false
            
            while !added {
                let random = Field.random()
                
                if !usableFields.contains(random) {
                    usableFields.append(random)
                    let ranCorrect = Bool.random()
                    
                    switch random {
                    case .birthYear:
                        tempNum = Int(random.generateValue(ranCorrect))!
                        tempArray.append((random, String(tempNum)))
                    case .issueYear:
                        tempNum = Int(random.generateValue(ranCorrect, minimum: tempNum))!
                        tempArray.append((random, String(tempNum)))
                    case .expYear:
                        tempNum = Int(random.generateValue(ranCorrect, minimum: tempNum))!
                        tempArray.append((random, String(tempNum)))
                    default:
                        tempArray.append((random, random.generateValue(ranCorrect)))
                    }
                    
                    added = true
                }
            }
        }
        
        return Passport(tempArray)
    }
    
    static func generateAllCorrectPassport() -> Passport {
        let usableFields = Field.all
        var tempNum = 0
        var tempArray: [PassportField] = []
        
        for field in usableFields {
            switch field {
            case .birthYear:
                tempNum = Int(field.generateValue(true))!
                tempArray.append((field, String(tempNum)))
            case .issueYear:
                tempNum = Int(field.generateValue(true, minimum: tempNum))!
                tempArray.append((field, String(tempNum)))
            case .expYear:
                tempNum = Int(field.generateValue(true, minimum: tempNum))!
                tempArray.append((field, String(tempNum)))
            default:
                tempArray.append((field, field.generateValue(true)))
            }
        }
        
        return Passport(tempArray)
    }
    
    static func generateAllPassport() -> Passport {
        let usableFields = Field.all
        var tempNum = 0
        var tempArray: [PassportField] = []
        
        for field in usableFields {
            let ranCorrect = Bool.random()
            
            switch field {
            case .birthYear:
                tempNum = Int(field.generateValue(ranCorrect))!
                tempArray.append((field, String(tempNum)))
            case .issueYear:
                tempNum = Int(field.generateValue(ranCorrect, minimum: tempNum))!
                tempArray.append((field, String(tempNum)))
            case .expYear:
                tempNum = Int(field.generateValue(ranCorrect, minimum: tempNum))!
                tempArray.append((field, String(tempNum)))
            default:
                tempArray.append((field, field.generateValue(ranCorrect)))
            }
        }
        
        return Passport(tempArray)
    }
    
    static func generateCorrectPassport() -> Passport {
        let amount = Int.random(in: 1...7)
        var usableFields: [Field] = []
        var tempNum = 0
        var tempArray: [PassportField] = []
        
        for _ in 0...amount {
            var added = false
            
            while !added {
                let random = Field.random()
                
                if !usableFields.contains(random) {
                    usableFields.append(random)
                    
                    switch random {
                    case .birthYear:
                        tempNum = Int(random.generateValue(true))!
                        tempArray.append((random, String(tempNum)))
                    case .issueYear:
                        tempNum = Int(random.generateValue(true, minimum: tempNum))!
                        tempArray.append((random, String(tempNum)))
                    case .expYear:
                        tempNum = Int(random.generateValue(true, minimum: tempNum))!
                        tempArray.append((random, String(tempNum)))
                    default:
                        tempArray.append((random, random.generateValue(true)))
                    }
                    
                    added = true
                }
            }
        }
        
        return Passport(tempArray)
    }
    
    func isValid() -> Bool {
        if fields.count >= Field.numberOfFields && fields.isUnique {
            if !fields.map({ $0.field }).contains(.invalid) {
                if fields.count == Field.numberOfFields {
                    return !fields.map{ $0.field }.contains(.countryID)
                } else {
                    return true
                }
            }
        }
        
        return false
    }
    
    func isDeepScanValid() -> Bool {
        if isValid() {
            for entry in fields {
                if !entry.field.isValid(entry.value) {
                    return false
                }
            }
            
            return true
        }
        
        return false
    }
    
    func rawRepresentation() -> String {
        var constructedString: String = ""
        let upper = (fields.count < 5) ? fields.count - 1 : 4
        let randomReturns = Int.random(in: 1...upper)
        var returnsAfter: [Int] = []
        
        for num in 0...randomReturns {
            if num != 0 {
            var added = false
            while !added {
                let random = Int.random(in: 0..<(fields.count - 1))
                if !returnsAfter.contains(random) {
                    returnsAfter.append(random)
                    added = true
                }
            }
            }
        }
        
        for num in 0..<fields.count {
            let field = fields[num]
            constructedString.append("\(field.field.rawValue):\(field.value)")
            
            if returnsAfter.contains(num) {
                constructedString.append("\n")
            } else if field != fields.last! {
                constructedString.append(" ")
            }
        }
        
        return constructedString
    }
    
}
