//
//  TheHoleViewController.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class TheHoleViewController: UIViewController, PuzzleDelegate {
    
    fileprivate var flowController: TheHoleFlowController!
    fileprivate var viewModel: TheHoleViewModel!
    
    private var completePuzzle = UIImageView()
    //    private var additionalTime = 11.0
    //set seconds for timer
    private var seconds = 11
    //declare NSObject Timer
    private var timer = Timer()
    var gridSize = Int()
    var dragView = UIImageView()
    //create empty array for cell locations
    var cellCoordinatesArray = [CGPoint]()
    var halfCellHypotenuse = CGFloat()
    
    @IBOutlet weak var puzzleGrid: Grid!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var puzzleCollectionView: PuzzleCollectionView!
    
    func assignDependancies(flowController: TheHoleFlowController, viewModel: TheHoleViewModel) {
        self.viewModel = viewModel
        self.flowController = flowController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        puzzleSetup()
        buttonSetup()
        
        backgroundSetup(image: UIImage(named: "solitary")!)
        
        //ensure only one puzzletile is moved at a time
        UIView.appearance().isExclusiveTouch = true
    }
    
    //Puts tab for control panel when pulled down rather than going straight there
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return [.all]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(true)
        
        //loop through grid and assign coordinates of each cell to array
        for row in 0...(gridSize - 1) {
            for col in 0...gridSize - 1 {
                let puzzleCellSize = puzzleGrid.frame.width / CGFloat(gridSize)
                let arrayItem = CGPoint(x: puzzleGrid.frame.minX + (puzzleCellSize * CGFloat(col)) + (puzzleCellSize / 2), y: puzzleGrid.frame.minY + (puzzleCellSize * CGFloat(row)) + (puzzleCellSize / 2))
                cellCoordinatesArray.append(arrayItem)
            }
        }
        halfCellHypotenuse = (CGFloat(sqrt(pow(Double(Int(puzzleGrid.frame.width) / gridSize), 2.00) + pow(Double(Int(puzzleGrid.frame.width) / gridSize), 2.00)))) / 2
    }
    
    func puzzleSetup() {
        puzzleGrid.gridSize = CGFloat(viewModel.gridSize)
        gridSize = viewModel.gridSize
        puzzleCollectionView.puzzleImages = viewModel.images
        puzzleCollectionView.theHoleViewController = self
        puzzleCollectionView.puzzleDelegate = self
        puzzleGrid.backgroundColor = UIColor(patternImage: UIImage(named: "barGrid")!)
        puzzleCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "stone")!)
        
    }
    
    func buttonSetup() {
        completionButton.speachButtonSetup()
        completionButton.setTitle("???", for: .normal)
        hintButton.speachButtonSetup()
        hintButton.setTitle("Please I really need some help. What should this picture look like?", for: .normal)
    }

    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        //declare puzzlepiece
        let puzzlePiece = sender.view as! UIImageView
        let location = sender.location(in: view)
        
        //set currently pressed puzzlepiece to be on top
        self.view.bringSubviewToFront(puzzlePiece)
        sender.view?.center = location
        if sender.state == .ended {
            if puzzleGrid.frame.contains(location) {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    
                    //check if the cell already contains a puzzlepiece
                    if (self!.view.subviews.filter{ $0.center == (self!.cellCoordinatesArray.closestCell(nonFixedLocation: location, hyp: self!.halfCellHypotenuse)) }).count == 0 {
                    
                        //loop to see where puzzle piece is and snap to closest cell
                        sender.view?.center = self!.cellCoordinatesArray.closestCell(nonFixedLocation: location, hyp: self!.halfCellHypotenuse) } else {
                        
                        //add image from puzzlePiece back to array
                        self?.puzzleCollectionView.puzzleImages.append(puzzlePiece.image!)
                        
                        //reload UICollectionView to show added cell
                        self?.puzzleCollectionView.reloadData()
                        
                        //delete dragView
                        puzzlePiece.removeFromSuperview()
                    }
                }
            } else {
                
                //add image from puzzlePiece back to array
                puzzleCollectionView.puzzleImages.append(puzzlePiece.image!)
                
                //reload UICollectionView to show added cell
                puzzleCollectionView.reloadData()
                
                //delete dragView
                puzzlePiece.removeFromSuperview()
            }
        }
    }
    
    private func indexOfPuzzles(with image: UIImage) -> Int? {
        guard let key = (viewModel.puzzleDictionary as NSDictionary).allKeys(for: image).first else
        {return nil}
        return key as? Int
    }
    
    func puzzleComplete() {
        if puzzleCollectionView.visibleCells.isEmpty {
            var correctPuzzlePiecePlacement = 0
            view.subviews.forEach { (puzzleFieldView) in
                guard let image = (puzzleFieldView as? UIImageView)?.image else {return}
                guard let fieldIndex = indexOfPuzzles(with: image) else {return}
                guard let fieldCenterIndex = cellCoordinatesArray.firstIndex(of: puzzleFieldView.center) else {return}
                if fieldCenterIndex == fieldIndex {
                    correctPuzzlePiecePlacement += 1
                }
            }
            if correctPuzzlePiecePlacement == (gridSize * gridSize) {
                //Alert title and message
                let alert = UIAlertController(title: "Puzzle Complete", message: "I hope you have learned your lesson. Any more insubordination and you will be back here, and next time things will be harder", preferredStyle: UIAlertController.Style.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "I am sorry Sir, I promis to behave", style: UIAlertAction.Style.default, handler: { [weak self] _ in
                    self?.popBack(2)
                    
                }))
                // show the alert
                self.present(alert, animated: true)
            } else {
                //Alert title and message
                let alert = UIAlertController(title: "Puzzle Incomplete", message: "You can't even complete a simple puzzle correctly. How do you expect to escape the most secure prison in the world?\nYou only have \(Int((Double(correctPuzzlePiecePlacement)/(Double(gridSize)*Double(gridSize)))*100))% correct.", preferredStyle: UIAlertController.Style.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Sorry Sir I shall complete it correctly", style: UIAlertAction.Style.cancel, handler: nil))
                // show the alert
                self.present(alert, animated: true)
            }
        }
    }
    func didEnd() {
        let panGesture = UIPanGestureRecognizer(target:self, action: #selector(handlePan(sender:)))
        view.subviews.last!.addGestureRecognizer(panGesture)
        puzzleCollectionView.reloadData()
    }
    
    //set timer to use seconds (timerinterval)
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updatedTimer)), userInfo: nil, repeats: true)
    }
    
    //Sets timer to countdown in intervals of 1
    @objc func updatedTimer() {
        seconds -= 1
        
        //        countDownTimer.text = "\(seconds)"
        if seconds == 0 {
            resetTimer()
        }
    }
    
    func resetTimer() {
        timer.invalidate()
        self.completePuzzle.removeFromSuperview()
        self.hintButton.enableButton()
        //        self.countDownTimer.alpha = 0
    }
    
    @IBAction func completionButton(_ sender: Any) {
        
    }
    @IBAction func hintButton(_ sender: Any) {
        
        //Start Timer
        runTimer()
        //start next piece of code after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            
            self?.view.isUserInteractionEnabled = false
            
            //            self?.countDownTimer.fadeIn()
            self?.hintButton.disableButton()
            //create size and location for hintView
            let hintImageView = UIImageView(image: self?.viewModel.photo)
            hintImageView.frame.size = CGSize(width: self!.puzzleGrid.frame.width, height: self!.puzzleGrid.frame.height)
            hintImageView.center = self!.puzzleGrid.center
            self?.completePuzzle = hintImageView
            self?.completePuzzle.alpha = 0
            self?.view.addSubview(self!.completePuzzle)
            self?.completePuzzle.fadeIn()
            //wait 2 seconds from code run to run fadeout
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.completePuzzle.fadeOut()
                self?.view.isUserInteractionEnabled = true
            }
        }
    }
}

