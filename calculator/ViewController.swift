//
//  ViewController.swift
//  calculator
//
//  Created by Admin on 4.10.22.
import UIKit

// MARK: IBOutlets
class ViewController: UIViewController {
    var accountOnScreen:Double = 0
    var firstValue: Double = 0
    var sign: Int = 0
    var signPresence:Bool = false
    @IBOutlet weak var fieldContainer: UIView!
    @IBOutlet weak var resultArea: UILabel!
    @IBOutlet var everyButton: [UIButton]!
    
    
    // MARK: - IBActions
    @IBAction func buttons(_ sender: Any) {
        if signPresence == true {
            resultArea.text = String((sender as AnyObject).tag )
            signPresence = false
        } else {
            resultArea.text = (resultArea.text ?? "") + String((sender as AnyObject).tag)
        }
        accountOnScreen = Double(resultArea.text ?? "")!
    }
    
    @IBAction func calculatingButtons(_ sender: UIButton) {
        if resultArea.text != ""
            && resultArea.text != "-"
            && resultArea.text != "+"
            && resultArea.text != "×"
            && resultArea.text != "÷"
            && sender.tag != 10
            && sender.tag != 15 {
            firstValue = Double(resultArea.text ?? "")!
            if sender.tag == 11
            { //деление
                resultArea.text = "÷"
                
            }
            if sender.tag == 12 { //умножение
                resultArea.text = "×"
            }
            if sender.tag == 13 { //вычитание
                resultArea.text = "-"
            }
            if sender.tag == 14 { //сложение
                resultArea.text = "+"
            }
            sign = sender.tag
            signPresence = true
        }
        else if sender.tag == 15 {
            if sign == 11 {
                resultArea.text = String(firstValue / accountOnScreen)
            }
            if sign == 12 {
                resultArea.text = String(firstValue * accountOnScreen)
            }
            if sign == 13 {
                resultArea.text = String(firstValue - accountOnScreen)
            }
            if sign == 14 {
                resultArea.text = String(firstValue + accountOnScreen)
            }
        }
        else if sender.tag == 10 {
            resultArea.text = ""
            firstValue = 0
            accountOnScreen = 0
            sign = 0
        }
    }
    
    @IBAction func polarityChangingButton(_ sender: UIButton) {
        if resultArea.text != ""
            && resultArea.text != "-"
            && resultArea.text != "+"
            && resultArea.text != "×"
            && resultArea.text != "÷"
            && sender.tag != 11
            && sender.tag != 15
            && sender.tag != 12
            && sender.tag != 13
            && sender.tag != 14 {
            resultArea.text = String (Double(resultArea.text ?? "")!  * -1 )
        }
    }
    
    @IBAction func precentageButton(_ sender: UIButton) {
        if resultArea.text != ""{
            resultArea.text = String(Double(resultArea.text ?? "")! / 100 )
            
        }
    }

    @IBAction func decimalPointButton(_ sender: UIButton) {
        if resultArea.text != ""
            && sender.tag != 11
            && sender.tag != 12
            && sender.tag != 13
            && sender.tag != 14
            && sender.tag != 15 {
            resultArea.text = String(Double(resultArea.text ?? "")!)
            var label = resultArea.text
            if (label ?? "").count > 1 {
                label?.removeLast()
                resultArea.text = label
            }
        }
    }
    
    // MARK: Private methods
    private func addSwipeGesture(direction: UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(erase))
        swipeGesture.direction = direction
        fieldContainer.addGestureRecognizer(swipeGesture)
    }
    @objc private func erase(_ gestureRecognizer: UISwipeGestureRecognizer) {
        var label = resultArea.text
        if label!.count > 1 {
            label?.removeLast()
            resultArea.text = label
        } else {
            resultArea.text = "0"
        }    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeGesture(direction: .left)
        addSwipeGesture(direction: .right)
        resultArea.text = "0"
        
    }
    override func viewWillLayoutSubviews(){
        view.layoutIfNeeded()
        // не работает чёт(
        everyButton.forEach {
            $0.layer.cornerRadius = $0.frame.height / 2
        }
        
    }
}
