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
    private let depositMinRangeSubject = PassthroughSubject<Int, Never>()
    private let depositMaxRangeSubject = PassthroughSubject<Int, Never>()
    
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

    override func setupView() {
        setupNavigationBar(with: "필터", isBorderHidden: true)
    }
    
    override func setupAction() {
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
        
        rootView.filterPriceView.depositSlider
            .controlEventPublisher(for: .valueChanged)
            .sink { [weak self] in
                guard let self = self else { return }
                self.depositMinRangeSubject.send(Int(rootView.filterPriceView.depositSlider.min))
                self.depositMaxRangeSubject.send(Int(rootView.filterPriceView.depositSlider.max))
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
        
        rootView.filterPriceView.monthlyRentSlider
            .controlEventPublisher(for: .valueChanged)
            .sink { [weak self] in
                guard let self = self else { return }
                self.monthlyRentMinRangeSubject.send(Int(rootView.filterPriceView.monthlyRentSlider.min))
                self.monthlyRentMaxRangeSubject.send(Int(rootView.filterPriceView.monthlyRentSlider.max))
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
    }
}

private extension MapFilterViewController {
    func bindViewModel() {
        let input = MapFilterViewModel.Input(
            depositMinText: depositMinTextSubject.eraseToAnyPublisher(),
            depositMaxText: depositMaxTextSubject.eraseToAnyPublisher(),
            depositMinRange: depositMinRangeSubject.eraseToAnyPublisher(),
            depositMaxRange: depositMaxRangeSubject.eraseToAnyPublisher(),
            monthlyRentMinText: monthlyRentMinTextSubject.eraseToAnyPublisher(),
            monthlyRentMaxText: monthlyRentMaxTextSubject.eraseToAnyPublisher(),
            monthlyRentMinRange: monthlyRentMinRangeSubject.eraseToAnyPublisher(),
            monthlyRentMaxRange: monthlyRentMaxRangeSubject.eraseToAnyPublisher(),
            maleButtonDidTap: maleButtonDidTapSubject.eraseToAnyPublisher(),
            femaleButtonDidTap: femaleButtonDidTapSubject.eraseToAnyPublisher(),
            genderDivisionButtonDidTap: genderDivisionButtonDidTapSubject.eraseToAnyPublisher(),
            genderFreeButtonDidTap: genderFreeButtonDidTapSubject.eraseToAnyPublisher(),
            singleButtonDidTap: singleButtonDidTapSubject.eraseToAnyPublisher(),
            doubleButtonDidTap: doubleButtonDidTapSubject.eraseToAnyPublisher(),
            tripleButtonDidTap: tripleButtonDidTapSubject.eraseToAnyPublisher(),
            quadButtonDidTap: quadButtonDidTapSubject.eraseToAnyPublisher(),
            quintButtonDidTap: quintButtonDidTapSubject.eraseToAnyPublisher(),
            sextButtonDidTap: sextButtonDidTapSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.depositMinRange
            .map { Double($0) }
            .sink { [weak self] depositMin in
                guard let self = self else { return }
                self.rootView.filterPriceView.depositSlider.min = depositMin
            }
            .store(in: cancelBag)
        
        output.depositMaxRange
            .map { Double($0) }
            .sink { [weak self] depositMax in
                guard let self = self else { return }
                self.rootView.filterPriceView.depositSlider.max = depositMax
            }
            .store(in: cancelBag)
        
        output.depositMinText
            .map { String($0) }
            .sink { [weak self] depositMin in
                guard let self = self else { return }
                self.rootView.filterPriceView.depositMinTextField.text = depositMin
            }
            .store(in: cancelBag)
        
        output.depositMaxText
            .map { String($0) }
            .sink { [weak self] depositMax in
                guard let self = self else { return }
                self.rootView.filterPriceView.depositMaxTextField.text = depositMax
            }
            .store(in: cancelBag)
        
        output.monthlyRentMinRange
            .map { Double($0) }
            .sink { [weak self] monthlyRentMin in
                guard let self = self else { return }
                self.rootView.filterPriceView.monthlyRentSlider.min = monthlyRentMin
            }
            .store(in: cancelBag)
        
        output.monthlyRentMaxRange
            .map { Double($0) }
            .sink { [weak self] monthlyRentMax in
                guard let self = self else { return }
                self.rootView.filterPriceView.monthlyRentSlider.max = monthlyRentMax
            }
            .store(in: cancelBag)
        
        output.monthlyRentMinText
            .map { String($0) }
            .sink { [weak self] monthlyRentMin in
                guard let self = self else { return }
                self.rootView.filterPriceView.monthlyRentMinTextField.text = monthlyRentMin
            }
            .store(in: cancelBag)
        
        output.monthlyRentMaxText
            .map { String($0) }
            .sink { [weak self] monthlyRentMax in
                guard let self = self else { return }
                self.rootView.filterPriceView.monthlyRentMaxTextField.text = monthlyRentMax
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
