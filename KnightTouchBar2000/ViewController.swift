
//
//  ViewController.swift
//  KnightTouchBar2000
//
//  Created by Anthony Da Mota on 08/11/2016.
//  Copyright © 2016 Anthony Da Mota. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var scannerCheckbox: NSButton!
    @IBOutlet weak var themesongCheckbox: NSButton!
    @IBOutlet weak var kittCar: NSImageView!
    
    var scannerSound: NSSound?
    var themeSong: NSSound?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        setBackground()
        
        setupImage()
        setupSounds()
        
        updateSoundState(for: scannerCheckbox)
        updateSoundState(for: themesongCheckbox)
    }
    
    @IBAction func setScannerMusic(_ sender: Any) {
        updateSoundState(for: scannerCheckbox)
    }
    
    @IBAction func setThemeSongMusic(_ sender: Any) {
        updateSoundState(for: themesongCheckbox)
    }
    
    private func setupImage() {
        if let image = NSImage(named: "kitt_car.gif") {
            kittCar.image = image
            kittCar.frame = CGRect(x: 0, y: 0, width: 400, height: 300)
            kittCar.animates = true
        } else {
            print("Error: Image kitt_car.gif not found.")
        }
    }
    
    private func setupSounds() {
        scannerSound = NSSound(named: "KITT_scanner")
        themeSong = NSSound(named: "KnightRiderThemeSong")
        
        scannerSound?.loops = true
        themeSong?.loops = true
        
        if scannerSound == nil { print("Error: Scanner sound not found.") }
        if themeSong == nil { print("Error: Theme song not found.") }
    }
    
    private func updateSoundState(for checkbox: NSButton) {
        let isOn = checkbox.state == .on
        
        switch checkbox {
        case scannerCheckbox:
            checkbox.title = isOn ? "Scanner on" : "Scanner off"
            playSound(scannerSound, play: isOn)
        case themesongCheckbox:
            checkbox.title = isOn ? "Theme Song on" : "Theme Song off"
            playSound(themeSong, play: isOn)
        default:
            break
        }
    }
    
    private func playSound(_ sound: NSSound?, play: Bool) {
        guard let sound = sound else { return }
        
        DispatchQueue.global(qos: .background).async {
            if play {
                sound.play()
            } else {
                sound.stop()
            }
        }
    }
    
    private func setBackground() {
        if let layer = self.view.layer {
            layer.backgroundColor = NSColor(red: 0.988, green: 0.296, blue: 0.312, alpha: 1).cgColor
        }
    }
}
