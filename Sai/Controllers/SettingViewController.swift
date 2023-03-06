//
//  SettingViewController.swift
//  Sai
//
//  Created by 保坂篤志 on 2023/03/06.
//

import UIKit

class SettingViewController: UIViewController {
    
    let colorDataManager = ColorDataManager.shared
    
    @IBOutlet weak var redPercentLabel: UILabel!
    @IBOutlet weak var greenPercentLabel: UILabel!
    @IBOutlet weak var bluePercentLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveValues()
    }

    func setupUI() {
        
        let red = Float(colorDataManager.redFilterValue ?? 1) * 100
        let green = Float(colorDataManager.greenFilterValue ?? 1) * 100
        let blue = Float(colorDataManager.blueFilterValue ?? 1) * 100
        
        redPercentLabel.text = String(format: "%.1f", red) + "%"
        greenPercentLabel.text = String(format: "%.1f", green) + "%"
        bluePercentLabel.text = String(format: "%.1f", blue) + "%"
        
        redSlider.setValue(red, animated: false)
        greenSlider.setValue(green, animated: false)
        blueSlider.setValue(blue, animated: false)
    }
    
    func saveValues() {
        
        colorDataManager.setRGBFilterValue(red: redSlider.value, green: greenSlider.value, blue: blueSlider.value)
    }
    
    @IBAction func moveRedSlider(_ sender: UISlider) {
        redPercentLabel.text = String(format: "%.1f", (sender.value * 100)) + "%"
    }
    
    @IBAction func moveGreenSlider(_ sender: UISlider) {
        greenPercentLabel.text = String(format: "%.1f", (sender.value * 100)) + "%"
    }
    
    @IBAction func moveBlueSlider(_ sender: UISlider) {
        bluePercentLabel.text = String(format: "%.1f", (sender.value * 100)) + "%"
    }
    
    @IBAction func back() {
        dismiss(animated: true)
    }
}
