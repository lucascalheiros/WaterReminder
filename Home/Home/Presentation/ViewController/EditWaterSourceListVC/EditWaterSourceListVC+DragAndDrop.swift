//
//  EditWaterSourceListVC+DragAndDrop.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 15/10/23.
//

import UIKit

extension EditWaterSourceListVC: UITableViewDragDelegate, UITableViewDropDelegate {

	func configureDragAndDrop() {
		tableView.dragInteractionEnabled = true
		tableView.dragDelegate = self
		tableView.dropDelegate = self
	}

	func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
		guard let coordinatorFirstItem = coordinator.items.first,
			  let destinationIndexPath = coordinator.destinationIndexPath,
			  let sourceIndexPath = coordinatorFirstItem.sourceIndexPath else { return }
		swapDataPositions(sourceIndexPath, destinationIndexPath)
		tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
		coordinator.drop(coordinatorFirstItem.dragItem, toRowAt: destinationIndexPath)
	}

	func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
		return true
	}

	func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
		let cancelProposal = UITableViewDropProposal(operation: .cancel)
		guard session.items.count == 1 else { return cancelProposal }
		if tableView.hasActiveDrag {
			return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
		}
		return cancelProposal
	}

	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		switch getItemForIndexPath(indexPath) {
		case .waterSourceItem:
			return true
		default:
			return false
		}
	}

	override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
		switch getItemForIndexPath(proposedDestinationIndexPath) {
		case .waterSourceItem:
			return proposedDestinationIndexPath
		default:
			return sourceIndexPath
		}
	}

	func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		switch getItemForIndexPath(indexPath) {
		case .waterSourceItem(let waterSource):
			let dragItem = UIDragItem(itemProvider: NSItemProvider())
			dragItem.localObject = waterSource.id
			return [ dragItem ]
		default:
			return []
		}
	}

}
