//
//  ChildPageProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

protocol ChildPageProtocol {
	var parentPageProvider: (ParentPageControllerProtocol & UIPageViewController)! { get set }
}
