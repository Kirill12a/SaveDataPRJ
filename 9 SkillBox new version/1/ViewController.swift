//
//  ViewController.swift
//  9 SkillBox new version
//
//  Created by Kirill Drozdov on 20.03.2021.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var SurnameTF: UITextField!
    
    let defualts = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameTF.text = defualts.string(forKey: KeyDefualts.keyName)
        SurnameTF.text = defualts.string(forKey: KeyDefualts.keySurname)
    }
        @IBAction func PushDataDB(_ sender: Any) {
            var name = NameTF.text!
            var surname = SurnameTF.text!
        
            if (!name.isEmpty && !surname.isEmpty){
                defualts.set(name, forKey: KeyDefualts.keyName)
                defualts.set(surname, forKey: KeyDefualts.keySurname)
            }
    }
    //Убрать клаву
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          view.endEditing(true)
      }
}

