//
//  AnimationDemoUITests.swift
//  AnimationDemoUITests
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
import Animation
import Easing

class AnimationDemoUITests: XCTestCase {
        
    override func setUp()
    {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_animation_completion()
    {
        let expectation = self.expectation(description: "animation did finish")
        
        var counter = 0

        Animator.animate(duration: 2, delay: 0, timingFunction: TimingFunction(), closure: { (t) in
            
            counter += 1
            
            })
        { (completed) in
                
                if completed { expectation.fulfill() }
        }
        
        waitForExpectations(timeout: 5) { error in
            
            if let error = error
            {
                XCTFail("Error: \(error.localizedDescription)")
            }
            
            XCTAssertGreaterThan(counter, 60)
        }
    }
    
    func test_animation()
    {
        let expectation = self.expectation(description: "animation did finish")
        
        var counter = 0

        Animator.animate(duration: 2, closure: { (t) in
          
            counter += 1
            
            if t >= 1
            {
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5) { error in
            
            if let error = error
            {
                XCTFail("Error: \(error.localizedDescription)")
            }
            
            XCTAssertGreaterThan(counter, 60)
        }
        
    }

}
