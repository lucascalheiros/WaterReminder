//
//  HistoryChart.swift
//  History
//
//  Created by Lucas Calheiros on 21/12/23.
//

import SwiftUI
import Charts
import Components
import Common
import WaterManagementDomain
import UIKit
import Combine

struct HistoryChart: View {
    @ObservedObject var viewModel: HistoryChartViewModel

    var header: some View {
        VStack {
            HStack {
                Text("Water Intake History").padding(.all, 8)
                    .font(Font(DefaultComponentsTheme.current.sectionTitle))
                    .foregroundStyle(DefaultComponentsTheme.current.background.onColor.suColor)
                Spacer()
            }
            Picker("Period time", selection: $viewModel.historyPeriod) {
                Text("Year").tag(HistoryChartViewModel.HistoryPeriod.year)
                Text("Month").tag(HistoryChartViewModel.HistoryPeriod.month)
                Text("Week").tag(HistoryChartViewModel.HistoryPeriod.week)
            }.pickerStyle(.segmented)
        }
    }

    var chart: some View {
        Chart {
            ForEach(viewModel.waterIntakeList) {
                BarMark(
                    x: .value(String(localized: "Date"), Calendar.current.date(from: $0.date)!),
                    y: .value(String(localized: "Water Volume"), $0.volume)
                ).foregroundStyle($0.drinkInfo.color.suColor)
            }

            RuleMark(y: .value(String(localized: "Daily Goal"), viewModel.expectedWaterVolumeFormatted))
                .foregroundStyle(Color.secondary)
                .lineStyle(StrokeStyle(lineWidth: 0.8, dash: [10]))
                .annotation(alignment: .topTrailing) {
                    Text(String(localized: "Daily Goal"))
                        .font(.subheadline).bold()
                        .padding(.trailing, 32)
                        .foregroundStyle(DefaultComponentsTheme.current.surface.onColor.suColor)
                }
        }.chartXScale(domain: .automatic(dataType: Date.self) { dates in
            dates = viewModel.datesShown
        })

    }

    var body: some View {
        VStack {
            header
            VStack {
                chart
            }.padding(.all, 16).background(DefaultComponentsTheme.current.surface.color.suColor).cornerRadius(8)
        }.background(DefaultComponentsTheme.current.background.color.suColor).frame(maxWidth: 400, maxHeight: 300)
    }

    init(viewModel: HistoryChartViewModel) {
        self.viewModel = viewModel
        prepareConfiguration()
    }

    private func prepareConfiguration() {
        let attributesSelected = [
            NSAttributedString.Key.foregroundColor:  DefaultComponentsTheme.current.primary.onColor,
            NSAttributedString.Key.font: DefaultComponentsTheme.current.body
        ]
        let attributesUnselected = [
            NSAttributedString.Key.foregroundColor:  DefaultComponentsTheme.current.surface.onColor,
            NSAttributedString.Key.font: DefaultComponentsTheme.current.body
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributesUnselected, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
        UISegmentedControl.appearance().selectedSegmentTintColor = DefaultComponentsTheme.current.primary.color
        UISegmentedControl.appearance().backgroundColor = DefaultComponentsTheme.current.surface.color
    }
}
