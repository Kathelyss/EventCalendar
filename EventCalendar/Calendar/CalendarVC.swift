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
    
    let dataSource = CalendarDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Services.shared.dao.requestTest(success: { testModel in
            print(String(describing: testModel))
        }) { error in
            print(String(describing: error))
        }
        
        addButtons()
        collectionView.allowsMultipleSelection = false
        dataSource.createModels(date: Date())
        monthNameLabel.text = dataSource.getMonthAndYear()
    }
    
    func addButtons() {
        let addEventButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) // hidden when observe friend's calendar
        addEventButton.setTitle("⊕", for: .normal)
        addEventButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        addEventButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        addEventButton.contentHorizontalAlignment = .left
        addEventButton.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addEventButton)
        
        let futureEventsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
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
        performSegue(withIdentifier: "ToFutureEventsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EventVC {
            vc.isMyEvent = true
            vc.isNewEvent = true
            vc.navigationTitle = "Новое событие"
        } else if let vc = segue.destination as? FutureEventsVC {
            if let indexPath = sender as? IndexPath {
                vc.date = dataSource.dateAt(indexPath)
            }
        }
    }
    
    @IBAction func tapPreviousMonthButton(_ sender: UIButton) {
        dataSource.decrementMonth()
        monthNameLabel.text = dataSource.getMonthAndYear()
        collectionView.reloadData()
    }
    
    @IBAction func tapNextMonthButton(_ sender: UIButton) {
        dataSource.incrementMonth()
        monthNameLabel.text = dataSource.getMonthAndYear()
        collectionView.reloadData()
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
        return 7 * 6 // 7 days * 6 weeks (max in 1 month)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthDayCell",
                                                      for: indexPath) as! MonthDayCell
        cell.layer.cornerRadius = cell.layer.bounds.width / 2
        cell.backgroundColor = #colorLiteral(red: 0.1101291651, green: 0.8944641674, blue: 0.9030175209, alpha: 0.1)
        let model = dataSource.models[indexPath.row]
        cell.dayNumberLabel.text = model.title
        cell.isHidden = model.title == ""
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                               withReuseIdentifier: "CalendarHeader",
                                                               for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = #colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 0.5)
        performSegue(withIdentifier: "ToFutureEventsVC", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = #colorLiteral(red: 0.1101291651, green: 0.8944641674, blue: 0.9030175209, alpha: 0.1)
    }
}
