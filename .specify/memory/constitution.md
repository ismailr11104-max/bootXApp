<!--
Sync Impact Report:
- Version change: 1.0.0 → 1.1.0
- Added sections: Clean Architecture & Layer Responsibilities, Dependency Inversion & Data Flow, Error Handling & Exception-to-Failure Mapping, Testing Standards (BLoC, Widget, Unit), Security, Token Handling, and Sensitive Logging Standards
- Modified sections: Core Principles, Technology Stack & Architecture Guidelines
- Follow-up TODOs: None
-->

# BootX App Constitution

## Core Principles

### I. Clean Architecture & Layer Separation (NON-NEGOTIABLE)
The codebase MUST strictly adhere to Clean Architecture principles, dividing every feature module into Data, Domain, and Presentation layers with strict boundary enforcement:
- **Domain Layer:** Contains pure business logic, Entities, abstract Repository interfaces, and UseCases. It MUST be 100% independent of Flutter framework specifics, UI libraries, and external packages (except pure utilities like `dartz`).
- **Data Layer:** Contains Remote Data Sources, Local Data Sources, Models/DTOs, and Repository implementations. It handles API requests, local database/storage access, and data mapping between DTOs and Domain Entities.
- **Presentation Layer:** Contains UI Screens, Pages, Widgets, and `flutter_bloc` (`Bloc` / `Cubit`) state management. It triggers UseCases, observes UI states, and handles user interactions without embedding business logic.

### II. Dependency Inversion & Data Flow
Dependency flow MUST strictly follow the rule `Presentation → Domain ← Data`:
- The Presentation layer depends solely on the Domain layer (invoking UseCases and observing Domain Entities/Failures).
- The Domain layer contains abstract Repository contracts and is completely unaware of the Data layer.
- The Data layer depends on the Domain layer by implementing its abstract Repository interfaces.
- Dependency injection via `get_it` MUST bind concrete data implementations to domain contracts at runtime.

### III. Strict Feature Isolation
Every feature module in `lib/features/` (such as auth, home, onboarding, and splash) MUST encapsulate its own data, domain, and presentation layers. Features MUST remain self-contained, avoiding tight coupling, circular dependencies, or direct cross-feature domain/data access. Shared logic and reusable components MUST reside in `lib/core/`.

### IV. State Management & Dependency Injection
State management MUST be handled exclusively via `flutter_bloc` (`Bloc` / `Cubit`). Direct use of `setState()` for business or feature state is strictly prohibited. All dependencies MUST be registered and resolved through `get_it` via the setup service locator configuration (`lib/core/services/service_locator/setup_service_locator.dart`), bypassing manual instantiation or service locator bypasses.

### V. Functional Error Handling & Exception Mapping
Errors and failures MUST be handled functionally using `dartz` (`Either<Failure, T>`). 
- **Exceptions (`AppException` and subclasses such as `ServerException`, `AuthException`, `ValidationException`, `NetworkException`, `CacheException`):** Thrown by data sources and repository implementations during runtime failures.
- **Failures (`Failure` and subclasses such as `ServerFailure`, `AuthFailure`, `ValidationFailure`, `NetworkFailure`, `CacheFailure`):** Returned to the presentation layer wrapped in `Left<Failure, T>`.
- Repository implementations MUST catch specific `AppException` types and map them to their corresponding `Failure` types. Catching generic `Exception` without mapping or propagating unhandled exceptions to the presentation layer is strictly prohibited.

### VI. Security, Token Handling, & Sensitive Logging
- **Token Handling:** Authentication tokens, sensitive credentials, and session keys MUST be stored securely using encrypted local storage or managed securely via `shared_preferences` / secure storage wrappers. Tokens MUST be injected securely into network requests (e.g., via Dio interceptors).
- **Sensitive Logging:** Logging MUST NEVER expose sensitive user data, passwords, authorization tokens, or personally identifiable information (PII). `print()` is strictly prohibited; authorized logging wrappers MUST be used.

### VII. Comprehensive Testing Standards
- **Unit Tests:** Mandatory for all UseCases and Repositories using `flutter_test`, mockito/mocktail, and `dartz` matchers.
- **BLoC / Cubit Tests:** Mandatory for all `Bloc` and `Cubit` classes using `bloc_test` to verify correct state transitions emitted in response to events.
- **Widget Tests:** Mandatory for critical UI features and reusable components to ensure correct rendering, user interaction handling, and state reaction.
- All modified Dart files MUST be formatted with `dart format` and successfully pass `flutter analyze` static analysis.

## Technology Stack & Architecture Guidelines

- **Language & Framework:** Dart (`^3.13.5`) and Flutter.
- **Networking:** `dio` for API communication.
- **Local Storage:** `shared_preferences`.
- **Approved Packages:** `flutter_bloc`, `get_it`, `dartz`, `flutter_svg`, `smooth_page_indicator`, `device_preview`, `equatable`. No new packages may be added without explicit approval.
- **Logging & Debugging:** `print()` is strictly prohibited; logging mechanisms must be used instead.

## Development Workflow & Quality Gates

- **Pre-Implementation:** Before implementing any feature, developers MUST read `AGENTS.md` and inspect relevant existing code to follow the closest matching implementation.
- **Code Reviews & Verification:** Every change MUST verify compliance with Clean Architecture, dependency injection rules, and BLoC state management standards.
- **Analysis & Tests:** Run `flutter analyze` and `flutter test` to validate code integrity before submission.

## Governance

- The Constitution supersedes all other practices and informal guidelines within the project.
- Amendments to this constitution require explicit documentation, version updates, and migration paths where applicable.
- All pull requests and code reviews MUST verify compliance with these core principles and architecture guidelines.
- Runtime development guidance is maintained in `AGENTS.md` and related Spec Kit memory assets.

**Version**: 1.1.0 | **Ratified**: 2026-11-05 | **Last Amended**: 2026-11-05
