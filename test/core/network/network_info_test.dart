import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/network/network_info.dart';

// Generate a MockConnectivity using the mockito package
@GenerateMocks([Connectivity])
import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(connectionChecker: mockConnectivity);
  });

  group('isConnected', () {
    test('should forward the call to Connectivity.checkConnectivity', () async {
      // arrange
      final tHasConnectionFuture = Future.value([ConnectivityResult.wifi]);

      // Mock the connectivity check result
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) => tHasConnectionFuture);

      // act
      final result = networkInfo.isConnected;

      // assert
      verify(mockConnectivity.checkConnectivity());
      expect(await result, true);
    });

    test('should return false when there is no connectivity', () async {
      // arrange
      final tNoConnectionFuture = Future.value([ConnectivityResult.none]);

      // Mock the connectivity check result
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) => tNoConnectionFuture);

      // act
      final result = networkInfo.isConnected;

      // assert
      verify(mockConnectivity.checkConnectivity());
      expect(await result, false);
    });
  });
}
