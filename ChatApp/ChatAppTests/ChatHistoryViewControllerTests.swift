//
//  ChatHistoryViewControllerTests.swift
//  ChatApp
//
//  Created by James Klitzke on 5/20/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import XCTest
@testable import ChatApp

class ChatHistoryViewControllerTests: XCTestCase {
    
    let storyboard = UIStoryboard(name: "ChatStoryboard", bundle: nil)
    var viewController : ChatHistoryViewController!
    var mockViewModel : MockChatHistoryViewModel!
    
    override func setUp() {
        super.setUp()
        viewController = storyboard.instantiateViewController(withIdentifier: "ChatHistoryViewController") as! ChatHistoryViewController
        viewController.loadView()
        mockViewModel = MockChatHistoryViewModel()
        viewController.viewModel = mockViewModel
    }
    

    func testNumberOfSections() {
        XCTAssertEqual(viewController.numberOfSections(in: viewController.chatHistoryTableView), 5)
    }
    
    func testTitleForHeaderInSection() {
        let result = mockViewModel.dataTextForChat(0)
        XCTAssertEqual(viewController.tableView(viewController.chatHistoryTableView, titleForHeaderInSection: 0), result)
    }
    
    func testHeightForRowAtIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertEqual(viewController.tableView(viewController.chatHistoryTableView, heightForRowAt: indexPath), 96.0)
    }

    
    func testCellForRowAtIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewController.tableView(viewController.chatHistoryTableView, cellForRowAt: indexPath)
    
        guard let testCell = cell as? ChatHistoryTableViewCell else {
            XCTFail("Invalid cell type returned!")
            return
        }
        
        testCell.configureFor(viewModel: mockViewModel, indexPath: indexPath)
        
        XCTAssertEqual(testCell.chatByLabel.text, "A Chat by John Doe")
        XCTAssertEqual(testCell.lastChatSummaryLabel.text, "Jane Smith - 23 Min Ago")
        XCTAssertEqual(testCell.lastChatMessageLabel.text, "Last Chat Message")
    }
}

class MockChatHistoryViewModel : ChatHistoryViewModel {
    override var numberOfChats : Int {
        return 5
    }
    
    override func chatIdForChat(_ section : Int) -> Int? {
        return 100
    }
    
    override func lastChatMessageTextForChat(_ section : Int) -> String {
        return "Last Chat Message"
    }
    
    override func chatByTextForChat(_ section : Int) -> String {
        return "A Chat by John Doe"
    }
    
    override func lastChatSummaryTextForChat(_ section : Int) -> String {
        return "Jane Smith - 23 Min Ago"
    }
    
    override func dataTextForChat(_ section: Int) -> String {
        return "Data Text"
    }
}
