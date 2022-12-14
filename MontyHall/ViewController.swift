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
        let doorsCount = 3

        for _ in 0..<repeats {
            if Int(arc4random_uniform(UInt32(doorsCount))) == Int(arc4random_uniform(UInt32(doorsCount))) {
                winsCount += 1
            }
        }

        return strategy == .change ? repeats - winsCount : winsCount
    }
}

