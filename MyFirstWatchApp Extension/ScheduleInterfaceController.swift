//
//  ScheduleInterfaceController.swift
//  MyFirstWatchApp Extension
//
//  Created by mac on 14/09/18.
//  Copyright © 2018 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {
  
    var selectedIndex = 0
    @IBOutlet weak var flightsTable: WKInterfaceTable!
    var flights = Flight.allFlights()
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
      for index in 0..<flightsTable.numberOfRows {
        guard let controller = flightsTable.rowController(at: index) as? FlightRowController else { continue }
        
        controller.flight = flights[index]
      }

    }
  override func didAppear() {
    super.didAppear()
    // 1
    guard flights[selectedIndex].checkedIn,
      let controller = flightsTable.rowController(at: selectedIndex) as? FlightRowController else {
        return
    }
    
    // 2
    animate(withDuration: 0.35) {
      // 3
      controller.updateForCheckIn()
    }
  }

  override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
    let flight = flights[rowIndex]
    let controllers = ["Flight", "CheckIn"]
    presentController(withNames: controllers, contexts: [flight, flight])
    selectedIndex = rowIndex
  }
  
      
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
