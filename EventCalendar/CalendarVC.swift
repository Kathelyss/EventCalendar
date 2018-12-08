//
//  ViewController.swift
//  EventCalendar
//
//  Created by kathelyss on 11/11/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit
import Foundation

class CalendarVC: UIViewController {
    @IBOutlet var addEventButton: UIButton! // hidden when observe friend's calendar
    @IBOutlet var monthNameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func tapPreviousMonthButton(_ sender: UIButton) {
    }
    
    @IBAction func tapNextMonthButton(_ sender: UIButton) {
    }
    
    @IBAction func tapAddEventButton(_ sender: UIButton) {
    }

    @IBAction func tapFutureEventsButton(_ sender: UIButton) {
    }
    
    @IBAction func tapSearchButton(_ sender: UIButton) {
    }

}

extension CalendarVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGFloat(Int(collectionView.bounds.width / 7))
        return CGSize(width: size, height: size)
    }
}

extension CalendarVC: UICollectionViewDelegate {
    
}

extension CalendarVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "MonthDayCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                               withReuseIdentifier: "CalendarHeader",
                                                               for: indexPath)
    }
}
