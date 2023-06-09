//
//  UserInformationRepositoryProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 04/06/23.
//

import Foundation
import RxSwift

protocol UserInformationRepositoryProtocol {
	func getUserInformationList() -> Observable<[UserInformation]>
	func saveUserInformation(userInformation: UserInformation) -> Completable
}
