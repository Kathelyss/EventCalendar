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
    
    let monthArray = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
                      "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    
    let currentMonth: [CalendarCellModel] = []
    var currentMonthIndex: Int = 0
    var currentYearIndex: Int = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtons()
        collectionView.allowsMultipleSelection = false
//        setupCalendar()
        dataSource.createModels(date: Date())
//        monthNameLabel.text = "\(monthArray[currentMonthIndex]) \(currentYearIndex)"
    }

    private func setupCalendar() {
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        currentYearIndex = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
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
        performSegue(withIdentifier: "ToFutureEventsVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EventVC {
            vc.isMyEvent = true
            vc.isNewEvent = true
            vc.navigationTitle = "Новое событие"
        } else if let vc = segue.destination as? FutureEventsVC {
            vc.navigationController?.title = "Все будущие события" // события в выбранную дату ?
        }
    }
    
    @IBAction func tapPreviousMonthButton(_ sender: UIButton) {
        dataSource.decrementMonth()
//        monthNameLabel.text = "\(monthArray[currentMonthIndex]) \(currentYearIndex)"
        collectionView.reloadData()
    }
    
    @IBAction func tapNextMonthButton(_ sender: UIButton) {
        dataSource.incrementMonth()
//        monthNameLabel.text = "\(monthArray[currentMonthIndex]) \(currentYearIndex)"
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
        cell.layer.cornerRadius = 5

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
        performSegue(withIdentifier: "ToFutureEventsVC", sender: self)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = #colorLiteral(red: 0.1101291651, green: 0.8944641674, blue: 0.9030175209, alpha: 0.1)
    }
}
