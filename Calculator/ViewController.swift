import UIKit

class ViewController: UIViewController {

    var userIsTyping = false
    var negative = true
    var userOperation = ""
    var left:Double=0
    var right:Double=0
    var last=""
    var horizo = false
    
    
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { context in
            
            if UIDevice.current.orientation.isLandscape {
                
                self.top.constant = 0
                self.bottom.constant = 0
            } else {
               
                self.top.constant = 170
                self.bottom.constant = 40
            }
            
            
            self.view.layoutIfNeeded()
        }, completion: { context in
            // 屏幕旋转完成后的操作
        })
    }

    
    func eq()
    {
        if(userOperation==""){}
        else{
            right=displayValue
            switch userOperation{
            case "+":
                displayValue=displayValue+left
            case "-":
                displayValue=left-displayValue
            case "✕":
                displayValue=left*displayValue
            case "÷":
                if(displayValue==0){
                    displayValue=0
                    display.text="Error"
                }else{
                    displayValue=left/displayValue
                }
            default:
                break
            }
            print(String(left)+userOperation+String(right)+"="+String(displayValue))
        }
        userIsTyping=false
        userOperation=""
        negative=false
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!

        if userIsTyping {
            let textInDisplay = display.text!
            display.text=textInDisplay+digit
        }
        else {
            if digit != "0"
            {
                userIsTyping = true
                negative=false
            }
            display.text=digit
        }
        last="1"
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if let mathematicalSymbol = sender.currentTitle{
            switch mathematicalSymbol{
            case "π":
                displayValue=3.141593
                userIsTyping=false
                last="1"
            case "%":
                displayValue=displayValue/100
                userIsTyping=false
                last="N"
            case "√":
                if(displayValue<0){
                    display.text="Error"
                }else{
                displayValue=sqrt(displayValue)
                    userIsTyping=false}
                last="N"
            case "+":
                display2.text="+"
                last="N"
            case "-":
                display2.text="-"
                last="N"
            case "✕":
                display2.text="✕"
                last="N"
            case "÷":
                display2.text="÷"
                last="N"
            case "=":
                display2.text="="
                last="N"
            default:
                break
            }
        }
    }
    
    
    @IBAction func Operation(_ sender: UIButton) {
        if(sender.currentTitle!=="-"&&display.text=="0"){
            display.text="-"
            negative=false
            userIsTyping=true
        }else if(sender.currentTitle!=="-"&&display2.text=="✕"){
            display.text="-"
            negative=false
            userIsTyping=true
        }
        else{
            eq()
            if(display.text=="Error"){}
            else{
                left = displayValue
                userIsTyping=false
                userOperation = sender.currentTitle!
                negative=true
                
            }
        }
    }
    
    @IBAction func dot(_ sender: UIButton) {
        if(display.text!.contains(".")){}
        else{
            if(userIsTyping){
                display.text=display.text!+"."
            }
            else{
                display.text="0."
                userIsTyping=true
            }
            negative=false
        }
        last="N"
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        displayValue=0
        display2.text=""
        userIsTyping=false
        userOperation=""
        negative=true
    }
    
    @IBAction func clearerror(_ sender: UIButton) {
        if(display.text=="Error"){
            displayValue=0
            display2.text=""
            userIsTyping=false
            userOperation=""
            negative=true
        }else{}
    }
    
    @IBAction func equal(_ sender: UIButton) {
        eq()
        userIsTyping=false
    }
    
    
    var displayValue:Double{
        get{
            if(display.text=="-"||display.text=="Error"){
                return 0
            }
            else{
                //print(display.text)
                return Double(display.text!)!
            }
        }
        
        set{
            if abs(newValue-Double(Int(newValue)))<0.0000001{
                print(newValue)
                display.text = String(Int(newValue))
            }
            else{
                display.text = String(Double(Int(newValue*1000000))/1000000)
            }
        }
    }
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var display2: UILabel!
}

