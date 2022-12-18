import 'package:counter/data/mapper/mapper.dart';
import 'package:counter/presentation/common/state_renderer/state_renderer.dart';
import 'package:counter/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getmessage();
}

// Loading State (Popup, full screen)

class LoadingState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getmessage() => message;
}

// error state (Pop, full screen)
class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  ErrorState({required this.stateRendererType, required this.message});

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getmessage() => message;
}

//Content State
class ContentState extends FlowState {
  ContentState();

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;

  @override
  String getmessage() => empty;
}

//Empty State
class EmptyState extends FlowState {
  final String message;
  EmptyState({required this.message});

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.emptyScreenState;

  @override
  String getmessage() => message;
}

class SuccessState extends FlowState {
  final String message;

  SuccessState(this.message);

  @override
  StateRendererType getStateRendererType() => StateRendererType.popUpSuccess;

  @override
  String getmessage() => message;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popUpLoadingState) {
          // showing popup dialog
          showPopup(context, getStateRendererType(), getmessage());
          // return the content ui of the screen
          return contentScreenWidget;
        } else {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getmessage(),
              retryActionFunction: retryActionFunction);
        }
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popUpErrorState) {
          // showing popup dialog
          showPopup(context, getStateRendererType(), getmessage());
          // return the content ui of the screen
          return contentScreenWidget;
        } else {
          // StateRendererType.FULL_SCREEN_ERROR_STATE
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getmessage(),
              retryActionFunction: retryActionFunction);
        }
      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;
      case SuccessState:
        // We should check if we are showing loading popup to remove it before showing our content
        dismissDialog(context);

        // show pop up
        showPopup(context, StateRendererType.popUpSuccess, getmessage(),
            title: AppStrings.success);
        // return content ui of the screen
        return contentScreenWidget;
      case EmptyState:
        return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getmessage(),
            retryActionFunction: retryActionFunction);
      default:
        return contentScreenWidget;
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopup(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = empty}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              title: title,
              retryActionFunction: () {}),
        ));
  }
}
