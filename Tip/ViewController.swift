//  ViewController.swift
//  Tip
//
//  Created by rezra on 18.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
//    MARK: - Properties
    var billTotal = " "
    var sumTextField = UITextField()
    var peopleCountLable = UILabel()
    var people: Int = 1
    var peopleCountStepper = UIStepper()
    var peopleCount = UITextField()
    var tipDecimal: Double = 0
    var tipLabel = UILabel()
    var zeroTipButton = UIButton()
    var tenTipButton = UIButton()
    var twentyTipButton = UIButton()
    var toCountButton = UIButton()
     
//     MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup view
        view.backgroundColor = .systemMint
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.magenta.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.layer.insertSublayer(gradient, at: 0)
         
        // Setup sum label
        sumTextField = UITextField(frame: CGRect(x: 70, y: 130, width: 250, height: 100))
        sumTextField.textAlignment = .center
        sumTextField.font = .boldSystemFont(ofSize: 30)
        sumTextField.placeholder = "Введите сумму"
        
        // Setup people count label
        peopleCountLable = UILabel(frame: CGRect(x: 70, y: 270, width: 250, height: 50))
        peopleCountLable.text = "Введите колличество персон"
        peopleCountLable.textAlignment = .center
        peopleCountLable.textColor = .darkGray
        
        // Setup people сount stepper
        peopleCountStepper = UIStepper(frame: CGRect(x: 200, y: 348, width: 150, height: 150))
        peopleCountStepper.addTarget(self, action: #selector(stepperChanged), for: .touchUpInside)
        
        // Setup people count
        peopleCount = UITextField(frame: CGRect(x: 95, y: 330, width: 70, height: 70))
        peopleCount.textAlignment = .center
        peopleCount.text = String(people)
        peopleCount.font = .boldSystemFont(ofSize: 30)
        
        // Setup tip label
        tipLabel = UILabel(frame: CGRect(x: 65, y: 430, width: 250, height: 50))
        tipLabel.text = "Введите чаевые"
        tipLabel.textAlignment = .center
        tipLabel.textColor = .darkGray
        
        // Setup zero tip button
        zeroTipButton = UIButton(frame: CGRect(x: 20, y: 480, width: 90, height: 90))
        zeroTipButton.tintColor = .black
        zeroTipButton.setTitle("0%", for: .normal)
        zeroTipButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        zeroTipButton.setTitleColor(.black, for: .normal)
        zeroTipButton.setTitleColor(.darkGray, for: .highlighted)
        zeroTipButton.titleLabel?.textAlignment = .center
        zeroTipButton.addTarget(self, action: #selector(tipButtonsPressed), for: .touchUpInside)
        zeroTipButton.layer.cornerRadius = 15
        zeroTipButton.layer.borderWidth = 1
        zeroTipButton.layer.borderColor = UIColor.black.cgColor
        
        // Setup ten tip button
        tenTipButton = UIButton(frame: CGRect(x: 150, y: 480, width: 90, height: 90))
        tenTipButton.setTitle("10%", for: .normal)
        tenTipButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        tenTipButton.setTitleColor(.black, for: .normal)
        tenTipButton.setTitleColor(.darkGray, for: .highlighted)
        tenTipButton.titleLabel?.textAlignment = .center
        tenTipButton.addTarget(self, action: #selector(tipButtonsPressed), for: .touchUpInside)
        tenTipButton.layer.cornerRadius = 15
        tenTipButton.layer.borderWidth = 1
        tenTipButton.layer.borderColor = UIColor.black.cgColor
        
        // Setup twenty tip button
        twentyTipButton = UIButton(frame: CGRect(x: 280, y: 480, width: 90, height: 90))
        twentyTipButton.setTitle("20%", for: .normal)
        twentyTipButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        twentyTipButton.setTitleColor(.black, for: .normal)
        twentyTipButton.setTitleColor(.darkGray, for: .highlighted)
        twentyTipButton.titleLabel?.textAlignment = .center
        twentyTipButton.addTarget(self, action: #selector(tipButtonsPressed), for: .touchUpInside)
        twentyTipButton.layer.cornerRadius = 15
        twentyTipButton.layer.borderWidth = 1
        twentyTipButton.layer.borderColor = UIColor.black.cgColor

        // Setup to count button
        toCountButton = UIButton(frame: CGRect(x: 90, y: 600, width: 200, height: 50))
        toCountButton.setTitle("Посчитать", for: .normal)
        toCountButton.setTitleColor(.black, for: .normal)
        toCountButton.titleLabel?.textAlignment = .center
        toCountButton.layer.cornerRadius = 15
        toCountButton.layer.borderWidth = 1
        toCountButton.layer.borderColor = UIColor.black.cgColor
        toCountButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
        
        // Activation of other methods
        addSubView()
    }
    
    func addSubView() {
        view.addSubview(sumTextField)
        view.addSubview(peopleCountLable)
        view.addSubview(peopleCountStepper)
        view.addSubview(peopleCount)
        view.addSubview(tipLabel)
        view.addSubview(zeroTipButton)
        view.addSubview(tenTipButton)
        view.addSubview(twentyTipButton)
        view.addSubview(toCountButton)
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        peopleCount.text = String(format: "%.0f", sender.value)
        self.people = Int(String(format: "%.0f", sender.value))!
    }
    
    @objc func tipButtonsPressed(_ sender: UIButton) {
        sumTextField.endEditing(true)
        zeroTipButton.isSelected = false
        tenTipButton.isSelected = false
        twentyTipButton.isSelected = false
        zeroTipButton.isHighlighted = false
        sender.isSelected = true
        sender.isHighlighted = true
        
        let title = String(sender.currentTitle!)
        let tip = Double(title.dropLast())! / 100
        self.tipDecimal = tip
    }
    
       
    @objc func calculate() {
        let sum = Double(sumTextField.text!)! * (1 + self.tipDecimal) / Double(people)
        billTotal = String(sum)
        allertController()
    }
    
    func allertController() {
        let message = UIAlertController(title: "Расчитано", message: "С каждого по \(billTotal)₽", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Отлично", style: .cancel, handler: nil)
        message.addAction(okButton)
        present(message, animated: true, completion: nil)
    }
}
