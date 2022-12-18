import 'dart:async';

import 'package:counter/domain/usecase/login_usecase.dart';
import 'package:counter/presentation/base/baseviewmodel.dart';
import 'package:counter/presentation/common/freezed_data_classes.dart';
import 'package:counter/presentation/common/state_renderer/state_renderer.dart';
import 'package:counter/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  StreamController<bool> isUserLoggedInSuccessfullyController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyController.close();
  }

  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  // inputs
  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    final result = await _loginUseCase
        .execute(LoginUseCaseInput(loginObject.username, loginObject.password));
    result.fold((failure) {
      // left -> failure
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.popUpErrorState,
          message: failure.message));
      print(failure.message);
    }, (data) {
      // right -> success (data)
      inputState.add(ContentState());

      // navigate to main screen after the login
      isUserLoggedInSuccessfullyController.add(true);
    });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
    loginObject = loginObject.copyWith(username: username);
    _validate();
  }

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  // outputs
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  // private functions
  _validate() {
    inputIsAllInputValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.username);
  }
}

abstract class LoginViewModelInputs {
  // three functions
  setUserName(String username);
  setPassword(String password);
  login();
  // two sinks

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputsValid;
}
