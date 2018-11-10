//
//  Game.swift
//  Apple Pie
//
//  Created by Nick Wen on 2018/10/4.
//  Copyright © 2018 Nick Wen. All rights reserved.
//

import Foundation

struct Game {
    var word: String//被猜的詞彙
    var incorrectMovesRemaining: Int//剩餘猜測次數
    var guessedLetters: [Character]
    var formattedWord: String {//格式化被猜的詞彙,若猜對就將字元加入,否則以_取代
        var guessedWord = ""
        for letter in word{
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            }else{
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        
        if !word.contains(letter) {//被猜詞彙中沒有該字元,可猜次數-1
            incorrectMovesRemaining -= 1
        }
    }
}
