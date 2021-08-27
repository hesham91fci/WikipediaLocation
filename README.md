# WikipediaLocation
- The architecture used in this application is MVVM using swiftUI and Combine, view models and managers uses AbstractIO class and work with input/output pattern, where this pattern gives great insights on what inputs should be tested and what outputs should be asserted on through unit tests.
- Inputs usually refers to passthrough subjects that causes viewmodels/managers to operate.
- Outputs usually refers to either signals used by other view models or `@Published var` used by the view
- Navigation between views is using coordinator pattern since it's great to make a whole component responsible for navigation and sometimes it's good that code is centralized in one place
- `ViewFactory` and `ViewModelFactory` used to get any view model in the code
- protocols are used in instantiating repo and viewModel as it will help in unit testing
