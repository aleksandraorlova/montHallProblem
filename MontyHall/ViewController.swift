import UIKit

enum Strategy {
    case change
    case notChange
}

class ViewController: UIViewController {
    var winsCount = 0
    private var strategy: Strategy?
    @IBOutlet private var choice: UISegmentedControl!
    @IBOutlet private var playButton: UIButton!
    @IBOutlet private var winLabel: UILabel!
    @IBOutlet private var gamesNumber: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        strategy = .change
    }

    @IBAction func choiceDone(_ sender: UISegmentedControl) {
        switch choice.selectedSegmentIndex {
        case 0:
            strategy = .change
            print(1)
        case 1:
            strategy = .notChange
            print(2)
        default: break
        }
    }

    @IBAction func playTapped(_ sender: UIButton) {
        guard let number = Int(gamesNumber.text ?? "") else { return }
        
        let result = play(repeats: number, strategy: strategy)
        winLabel.text = "Wins count: " + String(result)
    }
    
    private func play(repeats: Int, strategy: Strategy?) -> Int {
        var winsCount = 0
        
        for _ in 0..<repeats {
            let doorsCount = 3
            let winDoor = Int(arc4random_uniform(UInt32(doorsCount)))
            var playerChoice = Int(arc4random_uniform(UInt32(doorsCount)))
            
            if strategy == Strategy.change {
                if playerChoice == winDoor {
                    var doors = [0, 1, 2]
                    doors.remove(at: playerChoice)
                    playerChoice = doors[Int(arc4random_uniform(UInt32(doorsCount - 1)))]
                } else {
                    playerChoice = winDoor
                }
            }
            
            if playerChoice == winDoor {
                winsCount += 1
            }
        }

        return winsCount
    }
}

