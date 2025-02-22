//
//  DrinkShortcutVC.swift
//  Home
//
//  Created by Lucas Calheiros on 12/02/25.
//

import UIKit
import WaterManagementDomain
import Components
import Combine

class DrinkShortcutVC: UIViewController {
    private var cancellableBag: Set<AnyCancellable> = []

    let viewModel: DrinkShortcutViewModel
    var volumeUnit: VolumeUnit?

    var indexValueForVolume: Double? {
        switch volumeUnit {
        case .liters:
            0.1
        case .milliliters:
            10
        case .oz_uk:
            0.5
        case .oz_us:
            0.5
        case .none:
            nil
        }
    }

    lazy var cupsHorizontalStack = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 8
        return view
    }()

    lazy var volumePicker: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        return view
    }()

    lazy var cancel = {
        let btn = UIBarButtonItem(title: String(localized: "generic.cancel"), primaryAction: .init(handler: { _ in
            self.dismiss(animated: true)
        }))
        btn.tintColor = DefaultComponentsTheme.current.background.onColor
        return btn
    }()

    lazy var confirm = {
        let btn = UIBarButtonItem(title: String(localized: "generic.confirm"), image: nil, primaryAction: .init(handler: { _ in
            Task { @MainActor in
                try? await self.viewModel.save()
                self.dismiss(animated: true)
            }
        }))
        btn.tintColor = DefaultComponentsTheme.current.background.onColor
        return btn
    }()

    init(drink: Drink, viewModel: DrinkShortcutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = drink.name
        viewModel.setDrink(drink)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareConfiguration()
        prepareConstraints()
        observeViewModel()
        viewModel.loadData()
    }

    func prepareConfiguration() {
        view.backgroundColor = DefaultComponentsTheme.current.background.color
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItem = confirm
    }

    func prepareConstraints() {
        view.addConstrainedSubviews(cupsHorizontalStack, volumePicker)

        NSLayoutConstraint.activate([
            cupsHorizontalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cupsHorizontalStack.heightAnchor.constraint(equalToConstant: 40),
            cupsHorizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            volumePicker.topAnchor.constraint(equalTo: cupsHorizontalStack.bottomAnchor),
            volumePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            volumePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            volumePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }

    func observeViewModel() {
        viewModel.$drinkShortcutDefaultInfo.compactMap {$0}.sinkUI { data in
            self.selectVolume(data.medium)
            self.cupsHorizontalStack.arrangedSubviews.forEach(self.cupsHorizontalStack.removeArrangedSubview)
            let smallest = DrinkChips()
            smallest.title = data.smallest.formattedValueAndUnit
            smallest.addTapListener {
                self.selectVolume(data.smallest)
            }
            let small = DrinkChips()
            small.title = data.small.formattedValueAndUnit
            small.addTapListener {
                self.selectVolume(data.small)
            }
            let medium = DrinkChips()
            medium.title = data.medium.formattedValueAndUnit
            medium.addTapListener {
                self.selectVolume(data.medium)
            }
            let large = DrinkChips()
            large.title = data.large.formattedValueAndUnit
            large.addTapListener {
                self.selectVolume(data.large)
            }
            self.cupsHorizontalStack.addConstrainedArrangedSubviews(smallest, small, medium, large)
        }.store(in: &cancellableBag)
        viewModel.volumeUnit.sinkUI {
            self.volumeUnit = $0
            self.volumePicker.reloadComponent(0)
        }.store(in: &cancellableBag)
    }

    private func selectVolume(_ volume: Volume) {
        guard let volumeUnit, let indexValueForVolume else {
            return
        }
        viewModel.setSelectedVolume(volume)
        let index = (volume.to(volumeUnit).value / indexValueForVolume).rounded().toInt()
        volumePicker.selectRow(index, inComponent: 0, animated: true)
    }

}


extension DrinkShortcutVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        5000
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let volumeUnit, let indexValueForVolume else {
            return nil
        }
        return Volume(Double(row) * indexValueForVolume, volumeUnit).formattedValueAndUnit
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let volumeUnit, let indexValueForVolume else {
            return
        }
        viewModel.setSelectedVolume(Volume(indexValueForVolume * Double(row), volumeUnit))
    }
}
