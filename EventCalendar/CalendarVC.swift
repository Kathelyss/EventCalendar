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
    @IBOutlet var monthNameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addEventButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40)) // hidden when observe friend's calendar
        addEventButton.setTitle("⊕", for: .normal)
        addEventButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        addEventButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        addEventButton.contentHorizontalAlignment = .left
        addEventButton.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addEventButton)
        let futureEventsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        futureEventsButton.setTitle("≡", for: .normal)
        futureEventsButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        futureEventsButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        futureEventsButton.contentHorizontalAlignment = .right
        futureEventsButton.addTarget(self, action: #selector(tapFutureEvents), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: futureEventsButton)
    }

    @objc
    func addEvent() {
        performSegue(withIdentifier: "ToEventVC", sender: self)
    }
    
    @objc
    func tapFutureEvents() {
        performSegue(withIdentifier: "ToFutureEventsVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EventVC {
            vc.isMyEvent = false
        }
    }
    
    @IBAction func tapPreviousMonthButton(_ sender: UIButton) {
    }
    
    @IBAction func tapNextMonthButton(_ sender: UIButton) {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToFutureEventsVC", sender: self)
    }
}
