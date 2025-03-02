Hi there, this project is an architecture showcase iOS application.

## Tech stack

* UIKit-ViewCode
* MVVM
* Combine
* Swift Concurrency
* Swinject
* RxFlow
* GRDB
* Clean Architecture variation

## UI Layer

The UI layer of this project is constructed using UIKit-ViewCode, following the MVVM pattern using the Combine as the rective framework to work with observable data.

## Domain Layer

The domain layer uses a simplified variation of Clean Architecture, where we have:
* Feature modules: modules that will contain UI, and may contain feature-specific domain logic;
* Shared domain modules: modules responsible to implement logic that may be shared across multiple feature modules, those modules will contain both domain and data logic, separated logically by folder groups;
* Common modules: Usual behavior sharing modules, as Common (extensions and utilitary behaviors), Components (DesignSystem), and Core (required behavior sharing related to application business rule, as RxFlow steps)

The structure for a Feature module will look like:

<img width="251" alt="image" src="https://github.com/user-attachments/assets/3ccaa74e-cbe9-46dc-a07a-4bc69d3a718b" />

The structure for a Shared Domain module will look like:

<img width="337" alt="image" src="https://github.com/user-attachments/assets/427f90d3-fc8a-4db8-b7fd-1c6a1f7ec53a" />

