//
//  MapFilterViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/11/25.
//

import UIKit
import Combine

import CombineCocoa

final class MapFilterViewController: BaseViewController {
    
    // MARK: - Property

    private let rootView = MapFilterView()
    
    private let viewModel: MapFilterViewModel
    
    private let cancelBag = CancelBag()
    
    private let depositMinTextSubject = PassthroughSubject<Int, Never>()
    private let depositMaxTextSubject = PassthroughSubject<Int, Never>()
    
    private let monthlyRentMinTextSubject = PassthroughSubject<Int, Never>()
    private let monthlyRentMaxTextSubject = PassthroughSubject<Int, Never>()
    private let monthlyRentMinRangeSubject = PassthroughSubject<Int, Never>()
    private let monthlyRentMaxRangeSubject = PassthroughSubject<Int, Never>()
    
    private let maleButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let femaleButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let genderDivisionButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let genderFreeButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    private let singleButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let doubleButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let tripleButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let quadButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let quintButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let sextButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    private let preferredDateSubject = PassthroughSubject<String, Never>()
    
    private let threeMonthButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let sixMonthButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let oneYearButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    private let resetButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let applyButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Initializer

    init(viewModel: MapFilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    // MARK: - Functions

    override func setView() {
        setNavigationBar(with: "필터", isBorderHidden: true)
    }
    
    override func setAction() {
        hideKeyboardWhenDidTap()
        
        rootView.filterSegmentedControl
            .publisher(for: \.selectedSegmentIndex)
            .sink { [weak self] selectedIndex in
                guard let self = self else { return }
                self.updateFilterViews(for: selectedIndex)
            }
            .store(in: cancelBag)
        
        rootView.filterPriceView.depositMinTextField
            .textPublisher
            .compactMap { $0 }
            .compactMap { Int($0) }
            .sink { [weak self] depositMinText in
                guard let self = self else { return }
                self.depositMinTextSubject.send(depositMinText)
            }
            .store(in: cancelBag)
        
        rootView.filterPriceView.depositMaxTextField
            .textPublisher
            .compactMap { $0 }
            .compactMap { Int($0) }
            .sink { [weak self] depositMaxText in
                guard let self = self else { return }
                self.depositMaxTextSubject.send(depositMaxText)
            }
            .store(in: cancelBag)
        
        rootView.filterPriceView.monthlyRentMinTextField
            .textPublisher
            .compactMap { $0 }
            .compactMap { Int($0) }
            .sink { [weak self] monthlyRentMinText in
                guard let self = self else { return }
                self.monthlyRentMinTextSubject.send(monthlyRentMinText)
            }
            .store(in: cancelBag)
        
        rootView.filterPriceView.monthlyRentMaxTextField
            .textPublisher
            .compactMap { $0 }
            .compactMap { Int($0) }
            .sink { [weak self] monthlyRentMaxText in
                guard let self = self else { return }
                self.monthlyRentMaxTextSubject.send(monthlyRentMaxText)
            }
            .store(in: cancelBag)
        
        rootView.filterRoomView.maleButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.maleButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterRoomView.femaleButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.femaleButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterRoomView.genderDivisionButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.genderDivisionButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterRoomView.genderFreeButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.genderFreeButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterRoomView.singleButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.singleButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterRoomView.doubleButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.doubleButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterRoomView.tripleButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.tripleButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterRoomView.quadButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.quadButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterRoomView.quintButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.quintButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterRoomView.sextButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.sextButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterPeriodView.threeMonthButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.threeMonthButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterPeriodView.sixMonthButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.sixMonthButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.filterPeriodView.oneYearButton.optionButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.oneYearButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.resetButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.resetButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.applyButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            }
            .store(in: cancelBag)
    }
}

private extension MapFilterViewController {
    func bindViewModel() {
        let input = MapFilterViewModel.Input(
            depositMinText: depositMinTextSubject.eraseToAnyPublisher(),
            depositMaxText: depositMaxTextSubject.eraseToAnyPublisher(),
            monthlyRentMinText: monthlyRentMinTextSubject.eraseToAnyPublisher(),
            monthlyRentMaxText: monthlyRentMaxTextSubject.eraseToAnyPublisher(),
            maleButtonDidTap: maleButtonDidTapSubject.eraseToAnyPublisher(),
            femaleButtonDidTap: femaleButtonDidTapSubject.eraseToAnyPublisher(),
            genderDivisionButtonDidTap: genderDivisionButtonDidTapSubject.eraseToAnyPublisher(),
            genderFreeButtonDidTap: genderFreeButtonDidTapSubject.eraseToAnyPublisher(),
            singleButtonDidTap: singleButtonDidTapSubject.eraseToAnyPublisher(),
            doubleButtonDidTap: doubleButtonDidTapSubject.eraseToAnyPublisher(),
            tripleButtonDidTap: tripleButtonDidTapSubject.eraseToAnyPublisher(),
            quadButtonDidTap: quadButtonDidTapSubject.eraseToAnyPublisher(),
            quintButtonDidTap: quintButtonDidTapSubject.eraseToAnyPublisher(),
            sextButtonDidTap: sextButtonDidTapSubject.eraseToAnyPublisher(),
            preferredDate: preferredDateSubject.eraseToAnyPublisher(),
            threeMonthButtonDidTap: threeMonthButtonDidTapSubject.eraseToAnyPublisher(),
            sixMonthButtonDidTap: sixMonthButtonDidTapSubject.eraseToAnyPublisher(),
            oneYearButtonDidTap: oneYearButtonDidTapSubject.eraseToAnyPublisher(),
            resetButtonDidTap: resetButtonDidTapSubject.eraseToAnyPublisher(),
            applyButtonDidTap: applyButtonDidTapSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.depositMaxText
            .map { String($0) }
            .sink { [weak self] depositMax in
                guard let self = self else { return }
                self.rootView.filterPriceView.depositMaxTextField.text = depositMax
            }
            .store(in: cancelBag)
        
        output.monthlyRentMaxText
            .map { String($0) }
            .sink { [weak self] monthlyRentMax in
                guard let self = self else { return }
                self.rootView.filterPriceView.monthlyRentMaxTextField.text = monthlyRentMax
            }
            .store(in: cancelBag)
        
        output.isGenderEmpty
            .sink { [weak self] isEmpty in
                guard let self = self else { return }
                
                let buttons = [
                    self.rootView.filterRoomView.maleButton,
                    self.rootView.filterRoomView.femaleButton,
                    self.rootView.filterRoomView.genderDivisionButton,
                    self.rootView.filterRoomView.genderFreeButton
                ]
                
                if isEmpty {
                    buttons.forEach { $0.isSelected = false }
                }
            }
            .store(in: cancelBag)
        
        output.isOccupancyTypeEmpty
            .sink { [weak self] isEmpty in
                guard let self = self else { return }
                
                let buttons = [
                    self.rootView.filterRoomView.singleButton,
                    self.rootView.filterRoomView.doubleButton,
                    self.rootView.filterRoomView.tripleButton,
                    self.rootView.filterRoomView.quadButton,
                    self.rootView.filterRoomView.quintButton,
                    self.rootView.filterRoomView.sextButton
                ]
                
                if isEmpty {
                    buttons.forEach { $0.isSelected = false }
                }
            }
            .store(in: cancelBag)
        
        output.isContractPeriodEmpty
            .sink { [weak self] isEmpty in
                guard let self = self else { return }
                
                let buttons = [
                    self.rootView.filterPeriodView.threeMonthButton,
                    self.rootView.filterPeriodView.sixMonthButton,
                    self.rootView.filterPeriodView.oneYearButton
                ]
                
                if isEmpty {
                    buttons.forEach { $0.isSelected = false }
                }
            }
            .store(in: cancelBag)
        
        output.isPreferredDateEmpty
            .sink { [weak self] isEmpty in
                guard let self = self else { return }
                
                if isEmpty {
                    self.rootView.filterPeriodView.preferredDatePickerView.dateLabel.setText(
                        String.formattedDate(date: Date()),
                        style: .body1,
                        color: .grayscale6
                    )
                }
            }
            .store(in: cancelBag)
    }
    
    func updateFilterViews(for selectedIndex: Int) {
        switch selectedIndex {
        case 0:
            rootView.filterPriceView.isHidden = false
            rootView.filterRoomView.isHidden = true
            rootView.filterPeriodView.isHidden = true
        case 1:
            rootView.filterPriceView.isHidden = true
            rootView.filterRoomView.isHidden = false
            rootView.filterPeriodView.isHidden = true
        default:
            rootView.filterPriceView.isHidden = true
            rootView.filterRoomView.isHidden = true
            rootView.filterPeriodView.isHidden = false
        }
    }
}

extension MapFilterViewController: DatePickerViewDelegate {
    func dateDidPick(date: String) {
        preferredDateSubject.send(date)
    }
}
