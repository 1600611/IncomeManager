//
//  MainViewModelTests.swift
//  IncomeManagerTests
//
//  Created by Joel Angles Roca on 6/6/24.
//

import XCTest
@testable import IncomeManager

final class MainViewModelTests: XCTestCase {

    var viewModel: MainViewModel!
    var mockCategoryRepository: MockCategoryRepository!
    var mockIncomeRepository: MockIncomeRepository!

    @MainActor
    override func setUp() {
        super.setUp()
        mockCategoryRepository = MockCategoryRepository()
        mockIncomeRepository = MockIncomeRepository()
        viewModel = MainViewModel(categoryRepository: mockCategoryRepository, incomeRepository: mockIncomeRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockCategoryRepository = nil
        mockIncomeRepository = nil
        super.tearDown()
    }

    @MainActor
    func testIncomeSetProperlyWhenDateChangedAndUserHasNotSetIncome() {
        
        // Given
        let expectedIncome: Decimal = 0

        // When
        viewModel.actionDateChanged(Date())

        // Then
        XCTAssertEqual(viewModel.income, expectedIncome, "Income should be set to 0 when the date is changed and user has not set an income")
    }

    @MainActor
    func testCategoriesLoadedAndMappedCorrectlyWhenDateChanged() {
        
        // Given
        let categories = mockCategoryRepository.fetchCategories(date: Date())

        // When
        viewModel.actionDateChanged(Date())

        // Then
        XCTAssertEqual(viewModel.categoriesInformation.count, categories.count, "Categories should be loaded and mapped correctly when date is changed")
        XCTAssertEqual(viewModel.categoriesInformation[3].getCategoryType(), categories[3].getCategoryType(), "Categories should be loaded and mapped correctly when date is changed")
        XCTAssertEqual(viewModel.categoriesInformation[3].getPercentage(), 20, "Categories should be loaded and mapped correctly when date is changed")
    }

    @MainActor
    func testMonthBenefitCalculatedCorrectlyWhenDateChanged() {
        
        // Given
        let expectedMonthBenefit: Decimal = -60

        // When
        viewModel.actionDateChanged(Date())

        // Then
        XCTAssertEqual(viewModel.monthBenefit, expectedMonthBenefit, "Month benefit should be calculated correctly when date is changed")
    }
    
    @MainActor
    func testIncomeSetProperlyWithComasInTheString() {
        
        // Given
        let incomeWhitComa: String = "1,000"
        viewModel.actionDateChanged(Date())

        // When
        viewModel.actionIncomeSetted(incomeWhitComa)

        // Then
        XCTAssertEqual(viewModel.income, 1.0, "Income should be set to 1.0 when the input string contains commas")
    }
    
    @MainActor
    func testIncomeSetProperlyWithDotsInTheString() {
        
        // Given
        let incomeWhitDot: String = "1.000"
        viewModel.actionDateChanged(Date())

        // When
        viewModel.actionIncomeSetted(incomeWhitDot)

        // Then
        XCTAssertEqual(viewModel.income, 1.0, "Income should be set to 1.0 when the input string contains dots")
    }
    
    @MainActor
    func testIncomeHasToBeNillIfThereIsMoreThanOneComa() {
        
        // Given
        let incomeWhitComas: String = ",1,0,00"

        // When
        viewModel.actionIncomeSetted(incomeWhitComas)

        // Then
        XCTAssertNil(viewModel.income, "Income should be nil when the input string contains more than one comma")
    }
    
    @MainActor
    func testIncomeShouldBeNilIfThereIsMoreThanOneDot() {
        
        // Given
        let incomeWithDots: String = ".1.0.00"

        // When
        viewModel.actionIncomeSetted(incomeWithDots)

        // Then
        XCTAssertNil(viewModel.income, "Income should be nil when the input string contains more than one dot")
    }
    
    @MainActor
    func testIncomeShouldBeNilIfCommaIsAtTheStartOrAtTheEnd() {
        
        // Given
        let incomeWithCommaAtStart: String = ",1000"

        // When
        viewModel.actionIncomeSetted(incomeWithCommaAtStart)

        // Then
        XCTAssertNil(viewModel.income, "Income should be nil when the input string starts or ends with a comma")
    }
    
    @MainActor
    func testIncomeShouldBeNilIfDotIsAtTheStartOrAtTheEnd() {
        
        // Given
        let incomeWithDotAtFinal: String = "1000."

        // When
        viewModel.actionIncomeSetted(incomeWithDotAtFinal)

        // Then
        XCTAssertNil(viewModel.income, "Income should be nil when the input string starts or ends with a dot")
    }

}
