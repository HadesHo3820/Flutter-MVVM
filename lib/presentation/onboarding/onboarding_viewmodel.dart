import 'dart:async';

import 'package:counter/domain/model/model.dart';
import 'package:counter/presentation/base/baseviewmodel.dart';
import 'package:counter/presentation/resources/assets_manager.dart';
import 'package:counter/presentation/resources/string_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  //stream controller
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;

  int _currentIndex = 0;

  //inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    // send this slider data to our view
    _postDataToView();
  }

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        sliderObject: _list[_currentIndex],
        numOfSlides: _list.length,
        currentIndex: _currentIndex));
  }

  // private functions
  List<SliderObject> _getSliderData() => [
        const SliderObject(
            title: AppStrings.onBoardingTitle1,
            subTitle: AppStrings.onBoardingSubTitle1,
            image: ImageAssets.onboardingLogo1),
        const SliderObject(
            title: AppStrings.onBoardingTitle2,
            subTitle: AppStrings.onBoardingSubTitle2,
            image: ImageAssets.onboardingLogo2),
        const SliderObject(
            title: AppStrings.onBoardingTitle3,
            subTitle: AppStrings.onBoardingSubTitle3,
            image: ImageAssets.onboardingLogo3),
        const SliderObject(
            title: AppStrings.onBoardingTitle4,
            subTitle: AppStrings.onBoardingSubTitle4,
            image: ImageAssets.onboardingLogo4),
      ];

  @override
  int goNext() {
    _currentIndex++;
    if (_currentIndex >= _list.length) {
      // infinite loop to go to the first item
      _currentIndex = 0;
    }

    return _currentIndex;
  }

  @override
  int goPrevious() {
    _currentIndex--;
    if (_currentIndex == -1) {
      // infinite loop to go to the length of slider list
      _currentIndex = _list.length - 1;
    }

    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);
}

// inputs mean the orders that our view model will receive from our view
abstract class OnboardingViewModelInputs {
  void goNext(); // when user clicks on right arrow or swipe right

  void goPrevious(); // when user click on left arrow or swipe left

  void onPageChanged(int index);

  // this is the way to add data to the stream.. stream input
  Sink get inputSliderViewObject;
}

// outputs mean the data or results that will be sent from our view model to our view
abstract class OnboardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  final SliderObject sliderObject;
  final int numOfSlides;
  final int currentIndex;

  const SliderViewObject({
    required this.sliderObject,
    required this.numOfSlides,
    required this.currentIndex,
  });
}
