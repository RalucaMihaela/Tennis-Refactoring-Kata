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

class TennisGame1: TennisGame {
    private let player1: String
    private let player2: String
    private var score1: Int
    private var score2: Int
    private var currentScore: [Players:Int]
    
    required init(player1: String, player2: String) {
        self.player1 = player1
        self.player2 = player2
        self.score1 = 0
        self.score2 = 0
        self.currentScore[.playerOne] = 0
        self.currentScore[.playerTwo] = 0
    }

    func wonPoint(_ playerName: Players) {
        self.currentScore[playerName] = 1
    }
    
    var score:String? {
        return scoreResult()
    }
    
    
    func scoreResult() -> String {
        var tempScore = ""
        if score1 == score2 {
           tempScore = self.equalResults()
        } else if score1>=4 || score2>=4 {
            tempScore = self.finalResults()
        } else {
            tempScore = self.matchResults()
        }
        return tempScore
    }
    
    private func equalResults() -> String {
        var scoreDetail = ""
        switch score1
        {
        case 0:
            //we should use an enum to set the score, so that if we want to change something, we can easily find where to modify
            scoreDetail = ScoreType.loveAll.rawValue
            
        case 1:
            scoreDetail = ScoreType.fifteenAll.rawValue
            
        case 2:
            scoreDetail = ScoreType.thirtyAll.rawValue
            
        default:
            scoreDetail = ScoreType.deuce.rawValue
            
        }
        return scoreDetail
    }
    
    private func finalResults() -> String {
        var scoreDetail = ""
        let minusResult = score1-score2
        
        switch minusResult {
        case -1:
            scoreDetail = ScoreType.advantagePlayerTwo.rawValue
        case 1:
            scoreDetail = ScoreType.advantagePlayerOne.rawValue
        default:
            scoreDetail = minusResult >= 2 ? ScoreType.winPlayerOne.rawValue : ScoreType.winPlayerTwo.rawValue
        }
        
        return scoreDetail
    }
    
    private func matchResults() -> String {
        var tempScore = 0
        var scoreDetail = ""
        
        tempScore = 1
        scoreDetail = nil + 'fifteen'
        
        scoreDetail= "fifteen-"
        tempScore = 2
        scoreDetail = 'fifteen-' + 'thirty' -> 'fifteen-thirty'
        
        
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
