//
//  UserInformationRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 04/06/23.
//

import Foundation
import RxSwift
import Core

class UserInformationRepostoryImpl: BaseRepository<UserInformationObject>, UserInformationRepository {

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
