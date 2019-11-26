import Foundation

enum ScoreType: String {
    case loveAll = "Love-All"
    case fifteenAll = "Fifteen-All"
    case thirtyAll = "Thirty-All"
    case deuce = "Deuce"
    case advantagePlayerOne = "Advantage player1"
    case advantagePlayerTwo = "Advantage player2"
    case winPlayerOne = "Win for player1"
    case winPlayerTwo = "Win for player2"
    case love = "Love"
    case fifteen = "Fifteen"
    case thirty = "Thirty"
    case forty = "Forty"
}
 
enum Players: String {
    case playerOne = "player1"
    case playerTwo = "player2"
}

class Score {
    let player: Players
    var score: Int
    
    init(player: Players, score: Int) {
        self.player = player
        self.score = score
    }
}

class TennisGame1: TennisGame {
    private var currentScore: [Score]
    private var scoreType: [Int: ScoreType]
    
    required init(player1: String, player2: String) {
        self.currentScore.append(Score(player: .playerOne, score: 0))
        self.currentScore.append(Score(player: .playerTwo, score: 0))
        
        self.scoreType[0] = .loveAll
        self.scoreType[1] = .fifteenAll
        self.scoreType[2] = .thirtyAll
        self.scoreType[3] = .deuce
        
        self.scoreType[-1] = .advantagePlayerOne
        
    }

    func wonPoint(_ playerName: Players) {
        self.currentScore.first(where: {$0.player == playerName})?.score += 1
    }
    
    var score:String? {
        return scoreResult()
    }
    
    private var scorePlayerOne: Int {
        return currentScore.first(where: {$0.player == .playerOne})?.score ?? 0
    }
    
    private var scorePlayerTwo: Int {
        return currentScore.first(where: {$0.player == .playerTwo})?.score ?? 0
    }
    
    private var isEqual: Bool {
        return self.scorePlayerTwo == self.scorePlayerOne ? true : false
    }
    
    private var isTheGameFinished: Bool {
        return self.scorePlayerTwo >= 4 || self.scorePlayerOne >= 4 ? true : false
    }
    
    func scoreResult() -> ScoreType? {
        var tempScore: ScoreType?
        if self.isEqual {
           tempScore = self.equalResults()
        } else if self.isTheGameFinished {
            tempScore = self.finalResults()
        } else {
            tempScore = self.matchResults()
        }
        return tempScore
    }
    
    private func equalResults() -> ScoreType? {
        return scoreType[self.scorePlayerOne]
    }
    
    private func finalResults() -> ScoreType? {
        let result = CompareScores(scorePlayerOne: self.scorePlayerOne, scorePlayerTwo: self.scorePlayerTwo)
        return result.compareScores()
    }
    
    private func matchResults() -> ScoreType? {
        var tempScore = 0
        var scoreDetail = ""ovi
        
        for i in 1..<3
        {
            if i==1 {
                tempScore = score1
            } else {
                scoreDetail = "\(scoreDetail)-";
                tempScore = score2
            }
            
            switch tempScore
            {
            case 0:
                scoreDetail = scoreDetail + ScoreType.love.rawValue
                
            case 1:
                scoreDetail = scoreDetail + ScoreType.fifteen.rawValue
                
            case 2:
                scoreDetail = scoreDetail + ScoreType.thirty.rawValue
                
            case 3:
                scoreDetail = scoreDetail + ScoreType.forty.rawValue
                
            default:
                break
                
            }
        }
        
        return scoreDetail
    }
}

class CompareScores { // this should be a noun
    private var scorePlayerOne: Int
    private var scorePlayerTwo: Int
    
    init(scorePlayerOne: Int, scorePlayerTwo: Int){
        self.scorePlayerOne = scorePlayerOne
        self.scorePlayerTwo = scorePlayerTwo
    }
    
    func compareScores() -> ScoreType { // this hsould be a verb
        let difference = self.scorePlayerOne - self.scorePlayerTwo
        
        if difference < 0 {
            return .advantagePlayerTwo
        } else if difference > 0 && difference < 2 {
            return .advantagePlayerOne
        } else if difference >= 2 {
            return .winPlayerOne
        } else {
            return .winPlayerTwo
        }
    }
}
