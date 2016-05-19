# ZHPopupView


[![CI Status](http://img.shields.io/travis/zhhlmr/ZHPopupView.svg?style=flat)](https://travis-ci.org/zhhlmr/ZHPopupView)
[![Version](https://img.shields.io/cocoapods/v/ZHPopupView.svg?style=flat)](http://cocoapods.org/pods/ZHPopupView)
[![License](https://img.shields.io/cocoapods/l/ZHPopupView.svg?style=flat)](http://cocoapods.org/pods/ZHPopupView)
[![Platform](https://img.shields.io/cocoapods/p/ZHPopupView.svg?style=flat)](http://cocoapods.org/pods/ZHPopupView)


A simple iOS Pop up View to display alert or dialog


![Alt text](/screen.png)



### Usage


###### Alert View

```
ZHPopupView *popupView = [ZHPopupView popupNomralAlertViewInView:nil
                                                 backgroundStyle:ZHPopupViewBackgroundType_SimpleOpacity
                                                           title:@"Tips"
                                                         content:@"Confirm to delete/remove?"
                                                    buttonTitles:@[@"Cancel", @"Confirm"]
                                             confirmBtnTextColor:nil otherBtnTextColor:nil
                                              buttonPressedBlock:^(NSInteger btnIdx) {


                                              }];
[popupView present];
```

###### Dialog View

```
ZHPopupView *popupView = [ZHPopupView popUpDialogViewInView:nil
                                                    iconImg:[UIImage imageNamed:@"correct_icon"]
                                            backgroundStyle:ZHPopupViewBackgroundType_SimpleOpacity
                                                      title:@"Lorem Ipsum"
                                                    content:kRandomText
                                               buttonTitles:@[@"Cancel", @"Confirm"]
                                        confirmBtnTextColor:nil otherBtnTextColor:nil
                                         buttonPressedBlock:^(NSInteger btnIdx) {


                                         }];
[popupView present];

```


### Properties

```
@property(nonatomic, strong) NSString *headTitle;// Title string
@property(nonatomic, strong) NSString *content; // Content String
@property(nonatomic, strong) UIImage *headIconImg; // head Icon Img

@property(nonatomic, strong) UIColor *headTitleColor; // Title Color
@property(nonatomic, strong) UIColor *contentTextColor; // Content Text Color

@property(nonatomic, assign) CGFloat headTitleFontSize;// Title font size
@property(nonatomic, assign) CGFloat contentTextFontSize;// Content font size

@property(nonatomic, assign) NSTextAlignment contentTextAlignment;// Content text Alignment
@property(nonatomic, assign) NSTextAlignment headTextAlignment; // Title Text Alignment



```

### Callback

```

@property(nonatomic, copy) void (^buttonPressedBlock)(NSInteger btnIdx); // Button Click/Pressed callback
```

### Background Display Type


```

typedef enum {

    ZHPopupViewBackgroundType_SimpleOpacity = 0, // Default
    ZHPopupViewBackgroundType_Blur = 1 // With Radius 10.0f , will adding setting property about blur effect

} ZHPopupViewBackgroundType;

```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ZHPopupView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZHPopupView"
```

## Author

[zhhlmr](https://github.com/zhhlmr), zhouhan199132@gmail.com

## License

ZHPopupView is available under the MIT license. See the LICENSE file for more info.
