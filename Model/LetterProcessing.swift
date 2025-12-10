//
//  LetterProcessing.swift
//
//  Created by leena almusharraf on 07/12/2025.
//


import Foundation

struct LetterProcessing {
    
    // MARK: - 1. قاموس التحويل من حرف → اسم صورة
    static let map: [String: String] = [
        "ع": "aeen",
        "ال": "al",
        "ا": "alf",
        "أ": "alfHamza",
        "آ": "alfMd",
        "ب": "ba",
        "د": "dal",
        "ف": "fa",
        "ق": "gaf",
        "غ": "ghen",
        "ح": "ha",
        "ه": "haa",
        "ء": "Hamza",
        "ئ": "HamzaMaqsora",
        "إ": "hamzaTahtAlsater",
        "ؤ": "hamzaWow",
        "ج": "jeem",
        "ك": "kaf",
        "خ": "kha",
        "لا": "la",
        "ل": "lam",
        "م": "meem",
        "ن": "noon",
        "ر": "ra",
        "ص": "sad",
        "س": "seen",
        "ش": "sheen",
        "ت": "ta",
        "ط": "taa",
        "ة": "taMarbota",
        "ث": "tha",
        "ظ": "thaad",
        "ض": "thad",
        "ذ": "thal",
        "و": "wow",
        "ي": "ya",
        "ز": "za"
    ]
    
    // MARK: - استخراج اسم الصورة
    static func imageName(for letter: String) -> String? {
        return map[letter]
    }
    
    
    // MARK: - 2. تقسيم النص إلى حروف مع دعم "لا"
    static func splitText(_ text: String) -> [String] {
        var letters: [String] = []
        let arr = Array(text)
        
        var index = 0
        while index < arr.count {
            
            // دعم "لا"
            if index < arr.count - 1 {
                let pair = String(arr[index]) + String(arr[index + 1])
                if pair == "لا" {
                    letters.append(pair)
                    index += 2
                    continue
                }
            }
            
            // حرف واحد
            letters.append(String(arr[index]))
            index += 1
        }
        
        return letters
    }
}
