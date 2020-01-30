//
//  GamePlayCollectionView.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 30/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

protocol PuzzleDelegate {
    func didEnd()
}

class PuzzleCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var theHoleViewController: TheHoleViewController!
    var puzzleDelegate: PuzzleDelegate?
    //create empty array fo puzzleImages
    var puzzleImages: [UIImage] = []

    //initial location of touch to allow removal of cell
    private var initialTouchLocation: CGPoint!
    
    override func awakeFromNib() {
        delegate = self
        dataSource = self
    }
    //calculate the location of the inital touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print ("touch began")
        initialTouchLocation = touches.first!.location(in: theHoleViewController.puzzleCollectionView)
    }
    //number of cells for collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return puzzleImages.count
    }
    //Declare what is in cells and add gesture
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! PuzzleCollectionViewCell
        cell.config(puzzleImages: puzzleImages[indexPath.row])
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureHandler(sender:)))
        
        //Shortest time required for touchsbegan to register
        longPressGesture.minimumPressDuration = 0.151
        cell.userImageView.addGestureRecognizer(longPressGesture)
        return cell
    }
    //Declare handler
    @objc func longPressGestureHandler(sender:UILongPressGestureRecognizer) {
        
        let initialTouch = initialTouchLocation

        //capture image of the cell
        if let cellView = sender.view {
            let cellImageView = cellView as? UIImageView
            //create new Image of the image chosen
            let newImageView = UIImageView(image: cellImageView?.image)
            //look at state of gesture
            switch sender.state {
            case .began:
                
                //Hide the cell in collectionView
                cellView.isHidden = true
                //set size for newImage and place on top of hidden cellView to allow drag
                newImageView.frame.size = CGSize(width: theHoleViewController.puzzleGrid.frame.width / CGFloat(theHoleViewController.gridSize), height: theHoleViewController.puzzleGrid.frame.height / CGFloat(theHoleViewController.gridSize))
                newImageView.center = sender.location(in: theHoleViewController.view)
                theHoleViewController.dragView = newImageView
                theHoleViewController.view.addSubview(theHoleViewController.dragView)
                theHoleViewController.dragView.isUserInteractionEnabled = true
            case .changed:
                //define cell and location to allow dragging
                let dragViewCell = theHoleViewController.dragView
                let location = sender.location(in: theHoleViewController.view)
                dragViewCell.center = CGPoint (x: dragViewCell.center.x + (location.x - dragViewCell.center.x), y: dragViewCell.center.y + (location.y - dragViewCell.center.y))
            case .ended:
                let puzzleCellLocation = sender.location(in: theHoleViewController.view)
                //check if puzzle piece is within the puzzleGrid
                if theHoleViewController.puzzleGrid.frame.contains(puzzleCellLocation) {
                    UIView.animate(withDuration: 0.3) {
                        //check if cell is empty
                        if (self.theHoleViewController.view.subviews.filter{ $0.center == (self.theHoleViewController.cellCoordinatesArray.closestCell(nonFixedLocation: puzzleCellLocation, hyp: self.theHoleViewController.halfCellHypotenuse)) }).count == 0 {
                            self.theHoleViewController.dragView.center = self.theHoleViewController.cellCoordinatesArray.closestCell(nonFixedLocation: puzzleCellLocation, hyp: self.theHoleViewController.halfCellHypotenuse)

                            //use initialTouchLocation coordinates to work out which cell was pressed and remove from the puzzleImages array
                            if let indexPath = self.theHoleViewController.puzzleCollectionView.indexPathForItem(at: self.initialTouchLocation) {
                                self.puzzleImages.remove(at: indexPath.item)
                                self.theHoleViewController.puzzleCollectionView.deleteItems(at: [indexPath])
                                self.puzzleDelegate?.didEnd()
                            }
                        } else {
                            //if cell not empty remove piece that has been draged
                            self.theHoleViewController.dragView.removeFromSuperview()
                        }
                    }
                }
                    // if puzzlePiece location outside of puzzleGrid area then remove the created piece and unhide cell in collectionView
                else {
                    theHoleViewController.dragView.removeFromSuperview()
                }
                cellView.isHidden = false
                theHoleViewController.scoreCount += 1
                self.theHoleViewController.puzzleComplete()
            default : break
            }
        }
    }
}
