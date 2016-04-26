//
//  ZHPopupView.h
//  TestPopUpView
//
//  Created by heyz3a on 16/4/25.
//  Copyright © 2016年 heyz3a. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    ZHPopupViewBackgroundType_SimpleOpacity = 0,
    ZHPopupViewBackgroundType_Blur = 1

} ZHPopupViewBackgroundType;

@interface ZHPopupView : UIView


@property(nonatomic, strong) NSString *headTitle;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) UIImage *headIconImg;

@property(nonatomic, strong) UIColor *headTitleColor;
@property(nonatomic, strong) UIColor *contentTextColor;

@property(nonatomic, assign) CGFloat headTitleFontSize;
@property(nonatomic, assign) CGFloat contentTextFontSize;

@property(nonatomic, assign) NSTextAlignment contentTextAlignment;
@property(nonatomic, assign) NSTextAlignment headTextAlignment;

@property(nonatomic, copy) void (^buttonPressedBlock)(NSInteger btnIdx);


+ (instancetype)popupViewInView:(UIView *)view;

+ (instancetype)popupBlurViewInView:(UIView *)view;

+ (instancetype)popupViewOnKeyWindow;

+ (instancetype)popupBlurViewOnKeyWindow;

+ (instancetype)popupNomralAlertViewInView:(UIView *)view backgroundStyle:(ZHPopupViewBackgroundType)backgroundType title:(NSString *)title content:(NSString *)content buttonTitles:(NSArray *)titles confirmBtnTextColor:(UIColor *)confirmBtnTextColor otherBtnTextColor:(UIColor *)otherBtnTextColor buttonPressedBlock:(void (^)(NSInteger btnIdx))buttonPressedBlock;

+ (instancetype)popUpDialogViewInView:(UIView *)view iconImg:(UIImage *)iconImg backgroundStyle:(ZHPopupViewBackgroundType)backgroundType title:(NSString *)title content:(NSString *)content buttonTitles:(NSArray *)titles confirmBtnTextColor:(UIColor *)confirmBtnTextColor otherBtnTextColor:(UIColor *)otherBtnTextColor buttonPressedBlock:(void (^)(NSInteger btnIdx))buttonPressedBlock;

- (void)configureButtonWithTitles:(NSArray *)titles confirmTitleColor:(UIColor *)confirmTitleColor otherTitleColor:(UIColor *)otherTitleColor;

- (void)present;

- (void)disappear;
@end
