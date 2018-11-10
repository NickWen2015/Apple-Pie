//
//  ViewController.swift
//  Apple Pie
//
//  Created by Nick Wen on 2018/10/4.
//  Copyright © 2018 Nick Wen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var listOfWords = ["apple", "banana", "cherry", "strawberry", "pineapple", "orange", "peach"]//定義須被猜的詞彙
    let incorrectMovesAllowed = 7//題目能猜幾次,圖片中有7顆蘋果所以定義7,越少次玩家越難猜
    var totalWins = 0{//每輪結束統計勝次數
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{//每輪結束統計負次數
        didSet{
            newRound()
        }
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!//創建按鈕集合取代每個按鈕都要定義一個oullet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()//app每次啟動時為新的一輪
    }
    var currentGame: Game!//宣告一場遊戲,!表示currentGame再啟動app及開始遊戲前會短暫沒有值,因此宣告成optional
    func newRound() {
        if !listOfWords.isEmpty {
            //let newWord = listOfWords.removeFirst()
            guard let newWord = listOfWords.randomElement() else { return }
            print("目前要猜的詞彙為：" + newWord)
            currentGame = Game(word:newWord, incorrectMovesRemaining:incorrectMovesAllowed, guessedLetters:[])
            enableLetterButtons(true)
            updateUI()//更新UI介面
        }else{
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {//傳入enable狀態是否去啓用或暫停所有button集合
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {//對應到每個按鈕會觸發此方法,等等需要取得button的title屬性,所以sender型別定義為UIButton而非Any
        sender.isEnabled = false//同一輪遊戲,當某字母被按下時,不可在被按第二次
    }
    
    @IBAction func buttonTapped(_ sender: UIButton){
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!//取得按鈕上的文字
        let letter = Character(letterString.lowercased())//轉成小寫文字等等比較要用到
        currentGame.playerGuessed(letter: letter)//若猜錯會讓incorrectMovesRemaining次數-1
        updateGameState()
    }
    
    func updateUI() {//更新畫面
        var letters = [String]()
//        print("currentGame.formattedWord：" + currentGame.formattedWord)
        for letter in currentGame.formattedWord{//將被猜詞彙拆成字元陣列
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
//        print("wordWithSpacing：" + wordWithSpacing)
        correctWordLabel.text = wordWithSpacing
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "答對：\(totalWins)次, 答錯：\(totalLosses)次"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {//猜到最後要更新遊戲狀態用
        if currentGame.incorrectMovesRemaining == 0 {//每一輪猜超過7次就負局數+1
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }else{
            updateUI()
        }
    }
}

