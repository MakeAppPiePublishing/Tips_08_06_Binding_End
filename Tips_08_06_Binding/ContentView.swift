//
//  ContentView.swift
//  Tips_08_06_Binding
//
//  Created by Steven Lipton on 8/17/19.
//  Copyright © 2019 Steven Lipton. All rights reserved.
//

import SwiftUI
import Combine

class Lights:ObservableObject{
    @Published var isOn:Bool = false{
        didSet{
            if isOn{
                self.timedShutOff()
            }
        }
    }
    
    func timedShutOff(){
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                self.isOn = false
        }
    }
    
}


struct ToggleButton: View{
    @Binding var isOn:Bool
    var body: some View{
        Button(action: {self.isOn = !self.isOn}) {
            Text(isOn ? "Is On":"Is Off")
        }
    }
    
}

struct ContentView: View {
    @ObservedObject var lights:Lights
    // @State var isToggleButtonOn:Bool = false
    var body: some View {
        ToggleButton(isOn:$lights.isOn)
            .font(.largeTitle)
            
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(lights:Lights())
    }
}
#endif
