//
//  AddExpenseViewModelTests.swift
//  IncomeManagerTests
//
//  Created by Joel Angles Roca on 6/6/24.
//

import XCTest
@testable import IncomeManager

final class AddExpenseViewModelTests: XCTestCase {
    
    var viewModel: AddExpenseViewModel!
    var mockCategoryRepository: MockCategoryRepository!
    var mockExpenseRepository: MockExpenseRepository!
    
    @MainActor
    override func setUp() {
        super.setUp()
        mockCategoryRepository = MockCategoryRepository()
        mockExpenseRepository = MockExpenseRepository()
        let categoryType = CategoryType.ENTERTAINMENT
        viewModel = AddExpenseViewModel(categoryType: categoryType, expense: nil, expenseRepository: mockExpenseRepository, categoryRepository: mockCategoryRepository)
    }
    
    @MainActor
    override func tearDown() {
        viewModel = nil
        mockCategoryRepository = nil
        mockExpenseRepository = nil
        super.tearDown()
    }
    
    @MainActor
    func testCostSetProperlyWithComasInTheString() {
        
        // Given
        let costWithComa: String = "1,000"

        // When
        viewModel.actionAddCost(costWithComa)

        // Then
        XCTAssertEqual(viewModel.cost, 1.0, "Cost should be set to 1.0 when the input string contains commas")
    }
    
    @MainActor
    func testCostSetProperlyWithDotsInTheString() {
        
        // Given
        let costWithDot: String = "1.000"

        // When
        viewModel.actionAddCost(costWithDot)

        // Then
        XCTAssertEqual(viewModel.cost, 1.0, "Cost should be set to 1.0 when the input string contains dots")
    }
    
    @MainActor
    func testCostHasToBeNillIfThereIsMoreThanOneComa() {
        
        // Given
        let incomeWhitComas: String = ",1,0,00"

        // When
        viewModel.actionAddCost(incomeWhitComas)

        // Then
        XCTAssertNil(viewModel.cost, "Cost should be nil when the input string contains more than one comma")
    }
    
    @MainActor
    func testCostShouldBeNilIfThereIsMoreThanOneDot() {
        
        // Given
        let incomeWithDots: String = ".1.0.00"

        // When
        viewModel.actionAddCost(incomeWithDots)

        // Then
        XCTAssertNil(viewModel.cost, "Cost should be nil when the input string contains more than one dot")
    }
    
    @MainActor
    func testCostShouldBeNilIfCommaIsAtTheStartOrAtTheEnd() {
        
        // Given
        let incomeWithCommaAtStart: String = ",1000"

        // When
        viewModel.actionAddCost(incomeWithCommaAtStart)

        // Then
        XCTAssertNil(viewModel.cost, "Cost should be nil when the input string starts or ends with a comma")
    }
    
    @MainActor
    func testCostShouldBeNilIfDotIsAtTheStartOrAtTheEnd() {
        
        // Given
        let incomeWithDotAtStart: String = "1000."

        // When
        viewModel.actionAddCost(incomeWithDotAtStart)

        // Then
        XCTAssertNil(viewModel.cost, "Cost should be nil when the input string starts or ends with a dot")
    }

}
