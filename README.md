# Dubai-App-Studio-Test

## Overview

This Flutter application was developed as a technical assessment for an interview with [DA Studio](https://dubaiappstudio.ae/).

- **CLEAN Architecture**: The project is structured following the CLEAN architecture principles, promoting separation of concerns and making the codebase scalable and maintainable.
- **BLoC State Management**: Utilizes the BLoC pattern to manage state effectively, ensuring a clear separation between business logic and UI components.
- **Local Server**: A Dart server is included in `lib/server` to simulate server responses, enabling easy testing and development without relying on a live backend.
- **Unit Testing**: Unit tests are implemented for the data and domain layers of each feature, as well as for blocs in the presentation layer, as well as core directory files. These tests cover core functionalities and ensure robustness using `flutter_test`, `bloc_test` and `mockito`.


## Project Structure

The project follows the CLEAN architecture, structured into distinct layers:

```
lib
├── core
│   ├── constants
│   │   ├── app_constants.dart
│   │   └── app_validation.dart
│   ├── error
│   │   ├── error.dart
│   │   ├── exceptions.dart
│   │   └── failure.dart
│   ├── network
│   │   └── network_info.dart
│   ├── services
│   │   └── app_storage.dart
│   ├── usecases
│   │   ├── add_beneficiary_params.dart
│   │   ├── delete_beneficiary_params.dart
│   │   ├── send_amount_params.dart
│   │   ├── send_otp_params.dart
│   │   ├── usecase.dart
│   │   └── verify_otp_params.dart
│   └── widgets
│       └── tap_twice_to_exit.dart
├── features
│   ├── account
│   │   ├── data
│   │   │   ├── data_sources
│   │   │   │   ├── account_data_source.dart
│   │   │   │   └── account_remote_data_source.dart
│   │   │   ├── models
│   │   │   │   └── account_model.dart
│   │   │   └── repositories
│   │   │       └── account_repository_impl.dart
│   │   ├── domain
│   │   │   ├── entities
│   │   │   │   └── account_info.dart
│   │   │   ├── repositories
│   │   │   │   └── account_repository.dart
│   │   │   └── usecases
│   │   │       └── get_account_info.dart
│   │   └── presentation
│   │       ├── blocs
│   │       │   └── account_bloc
│   │       │       ├── account_bloc.dart
│   │       │       ├── account_event.dart
│   │       │       └── account_state.dart
│   │       ├── pages
│   │       │   └── home_page.dart
│   │       └── widgets
│   │           ├── account_info_widget.dart
│   │           ├── history_item_card.dart
│   │           ├── history_tab.dart
│   │           ├── home_tab_bar.dart
│   │           └── short_account_info_widget.dart
│   ├── beneficiary
│   │   ├── data
│   │   │   ├── data_sources
│   │   │   │   ├── beneficiary_data_source.dart
│   │   │   │   └── beneficiary_remote_data_source.dart
│   │   │   ├── models
│   │   │   │   └── beneficiary_model.dart
│   │   │   └── repositories
│   │   │       └── beneficiary_repository_impl.dart
│   │   ├── domain
│   │   │   ├── entities
│   │   │   │   └── beneficiary.dart
│   │   │   ├── repositories
│   │   │   │   └── beneficiary_repository.dart
│   │   │   └── usecases
│   │   │       ├── add_beneficiary.dart
│   │   │       ├── delete_beneficiary.dart
│   │   │       ├── get_beneficiaries.dart
│   │   │       ├── send_otp.dart
│   │   │       └── verify_otp.dart
│   │   └── presentation
│   │       ├── blocs
│   │       │   └── beneficiaries_bloc
│   │       │       ├── beneficiaries_bloc.dart
│   │       │       ├── beneficiaries_event.dart
│   │       │       └── beneficiaries_state.dart
│   │       └── widgets
│   │           ├── add_beneficiary_button.dart
│   │           ├── add_beneficiary_dialog.dart
│   │           ├── beneficiaries_tab.dart
│   │           └── beneficiary_card.dart
│   └── recharge
│       ├── data
│       │   ├── data_sources
│       │   │   ├── recharge_data_source.dart
│       │   │   └── recharge_remote_data_source.dart
│       │   ├── models
│       │   │   └── history_item_model.dart
│       │   └── repositories
│       │       └── recharge_repository_impl.dart
│       ├── domain
│       │   ├── entities
│       │   │   └── history_item.dart
│       │   ├── repositories
│       │   │   └── recharge_repository.dart
│       │   └── usecases
│       │       ├── get_recharge_history.dart
│       │       └── send_amount.dart
│       └── presentation
│           ├── blocs
│           │   ├── history_bloc
│           │   │   ├── history_bloc.dart
│           │   │   ├── history_event.dart
│           │   │   └── history_state.dart
│           │   └── recharge_bloc
│           │       ├── recharge_bloc.dart
│           │       ├── recharge_event.dart
│           │       └── recharge_state.dart
│           ├── pages
│           │   └── recharge_page.dart
│           └── widgets
│               ├── cannot_recharge_dialog.dart
│               ├── confirm_recharge_dialog.dart
│               ├── delete_beneficiary_dialog.dart
│               ├── otp_button.dart
│               ├── otp_text_field.dart
│               ├── recharge_notes_widget.dart
│               └── recharge_option_bubbles.dart
├── injection_container.dart
├── main.dart
└── server
    ├── app_http_failure.dart
    ├── app_http_services
    │   ├── app_account_info_http_service.dart
    │   ├── app_beneficiary_http_service.dart
    │   ├── app_history_http_service.dart
    │   ├── app_http_services.dart
    │   ├── app_otp_http_service.dart
    │   └── app_recharge_http_service.dart
    └── app_server.dart
```


## Testing

Unit tests are implemented for the data and domain layers of each feature, as well as for blocs in the presentation layer and core files. These tests cover core functionalities and ensure robustness using `flutter_test`, `bloc_test` and `mockito`.

### Running Tests

To run the tests locally, follow these steps:

1. **Navigate to the project directory**:
    ```bash
    cd Dubai-App-Studio-Test
    ```

2. **Run all tests**:
    ```bash
    flutter test
    ```

### Test Directory Structure

The tests are organized into directories mirroring the project structure:

```
test
├── core
│   ├── constants
│   │   └── app_validation_test.dart
│   ├── error
│   │   ├── exceptions_test.dart
│   │   └── failure_test.dart
│   ├── network
│   │   ├── network_info_test.dart
│   │   └── network_info_test.mocks.dart
│   └── services
│       ├── app_storage_test.dart
│       └── app_storage_test.mocks.dart
├── features
│   ├── account
│   │   ├── data
│   │   │   ├── data_sources
│   │   │   │   └── account_remote_data_source_test.dart
│   │   │   ├── models
│   │   │   │   └── account_model_test.dart
│   │   │   └── repositories
│   │   │       ├── account_repository_impl_test.dart
│   │   │       └── account_repository_impl_test.mocks.dart
│   │   ├── domain
│   │   │   └── usecases
│   │   │       ├── get_account_info_test.dart
│   │   │       └── get_account_info_test.mocks.dart
│   │   └── presentation
│   │       └── blocs
│   │           └── account_bloc
│   │               ├── account_bloc_test.dart
│   │               └── account_bloc_test.mocks.dart
│   ├── beneficiary
│   │   ├── data
│   │   │   ├── data_sources
│   │   │   │   └── beneficiary_remote_data_source_test.dart
│   │   │   ├── models
│   │   │   │   └── beneficiary_model_test.dart
│   │   │   └── repositories
│   │   │       ├── beneficiary_repository_impl_test.dart
│   │   │       └── beneficiary_repository_impl_test.mocks.dart
│   │   ├── domain
│   │   │   └── usecases
│   │   │       ├── add_beneficiary_test.dart
│   │   │       ├── add_beneficiary_test.mocks.dart
│   │   │       ├── delete_beneficiary_test.dart
│   │   │       ├── delete_beneficiary_test.mocks.dart
│   │   │       ├── get_beneficiaries_test.dart
│   │   │       ├── get_beneficiaries_test.mocks.dart
│   │   │       ├── send_otp_test.dart
│   │   │       ├── send_otp_test.mocks.dart
│   │   │       ├── verify_otp_test.dart
│   │   │       └── verify_otp_test.mocks.dart
│   │   └── presentation
│   │       └── blocs
│   │           └── beneficiaries_bloc
│   │               ├── beneficiaries_bloc_test.dart
│   │               └── beneficiaries_bloc_test.mocks.dart
│   └── recharge
│       ├── data
│       │   ├── data_sources
│       │   │   └── recharge_remote_data_source_test.dart
│       │   ├── models
│       │   │   └── history_item_model_test.dart
│       │   └── repositories
│       │       ├── recharge_repository_impl_test.dart
│       │       └── recharge_repository_impl_test.mocks.dart
│       ├── domain
│       │   └── usecases
│       │       ├── get_recharge_history_test.dart
│       │       ├── get_recharge_history_test.mocks.dart
│       │       ├── send_amount_test.dart
│       │       └── send_amount_test.mocks.dart
│       └── presentation
│           └── blocs
│               ├── history_bloc
│               │   ├── history_bloc_test.dart
│               │   └── history_bloc_test.mocks.dart
│               └── recharge_bloc
│                   ├── recharge_bloc_test.dart
│                   └── recharge_bloc_test.mocks.dart
└── mocks
    ├── mock_app_storage.dart
    ├── mock_http_client.dart
    └── mock_network_info.dart
```

## Contributing

Contributions are welcome! Please follow the standard [GitHub flow](https://guides.github.com/introduction/flow/) for contributing to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
