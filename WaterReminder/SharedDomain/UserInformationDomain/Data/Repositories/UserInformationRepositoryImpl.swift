//
//  UserInformationRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 04/06/23.
//

import Foundation
import RxSwift

class UserInformationRepostoryImpl: BaseRepository<UserInformationObject>, UserInformationRepositoryProtocol {

	init() {
		super.init(UserInformationRealmProvider())
	}

	func getUserInformationList() -> Observable<[UserInformation]> {
		list()
	}

	func saveUserInformation(userInformation: UserInformation) -> Completable {
		save(UserInformationObject(userInformation: userInformation))
	}
}
