//
//  ZHPopupView.h
//  ZHPopupView
//
//  Created by zhhlmr on 16/4/25.
//  Copyright © 2016年 zhhlmr. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    ZHPopupViewBackgroundType_SimpleOpacity = 0,
    ZHPopupViewBackgroundType_Blur = 1

} ZHPopupViewBackgroundType;

@interface ZHPopupView : UIView


@property(nonatomic, strong) NSString *headTitle;// Title string
@property(nonatomic, strong) NSString *content; // Content String
@property(nonatomic, strong) UIImage *headIconImg; // head Icon Img

@property(nonatomic, strong) UIColor *headTitleColor; // Title Color
@property(nonatomic, strong) UIColor *contentTextColor; // Content Text Color

@property(nonatomic, assign) CGFloat headTitleFontSize;// Title font size
@property (nonatomic, strong) UIFont *headTitleFont; // Title custom font

@property(nonatomic, assign) CGFloat contentTextFontSize;// Content font size
@property (nonatomic, strong) UIFont *contentTextFont; // Content custom font

@property(nonatomic, assign) NSTextAlignment contentTextAlignment;// Content text Alignment
@property(nonatomic, assign) NSTextAlignment headTextAlignment; // Title Text Alignment

@property(nonatomic, copy) void (^buttonPressedBlock)(NSInteger btnIdx); // Button Click/Pressed callback


+ (instancetype)popupViewInView:(UIView *)view;

+ (instancetype)popupBlurViewInView:(UIView *)view;

+ (instancetype)popupViewOnKeyWindow;

+ (instancetype)popupBlurViewOnKeyWindow;

+ (instancetype)popupNormalAlertViewInView:(UIView *)view backgroundStyle:(ZHPopupViewBackgroundType)backgroundType title:(NSString *)title content:(NSString *)content buttonTitles:(NSArray *)titles confirmBtnTextColor:(UIColor *)confirmBtnTextColor otherBtnTextColor:(UIColor *)otherBtnTextColor buttonPressedBlock:(void (^)(NSInteger btnIdx))buttonPressedBlock;

+ (instancetype)popUpDialogViewInView:(UIView *)view iconImg:(UIImage *)iconImg backgroundStyle:(ZHPopupViewBackgroundType)backgroundType title:(NSString *)title content:(NSString *)content buttonTitles:(NSArray *)titles confirmBtnTextColor:(UIColor *)confirmBtnTextColor otherBtnTextColor:(UIColor *)otherBtnTextColor buttonPressedBlock:(void (^)(NSInteger btnIdx))buttonPressedBlock;

+ (instancetype)popUpDialogWithCustomFontViewInView:(UIView *)view iconImg:(UIImage *)iconImg backgroundStyle:(ZHPopupViewBackgroundType)backgroundType title:(NSString *)title titleFont:(UIFont *)titleFont content:(NSString *)content contentFont:(UIFont *)contentFont buttonTitles:(NSArray *)titles confirmBtnTextColor:(UIColor *)confirmBtnTextColor confirmTitleFont:(UIFont *)confirmTitleFont otherBtnTextColor:(UIColor *)otherBtnTextColor otherBtnFont:(UIFont *)otherBtnFont buttonPressedBlock:(void (^)(NSInteger btnIdx))buttonPressedBlock;

- (void)configureButtonWithTitles:(NSArray *)titles confirmTitleColor:(UIColor *)confirmTitleColor otherTitleColor:(UIColor *)otherTitleColor;

- (void)configureButtonWithTitles:(NSArray *)titles confirmTitleColor:(UIColor *)confirmTitleColor confirmTitleFont:(UIFont *)confirmTitleFont otherTitleColor:(UIColor *)otherTitleColor otherTitleFont:(UIFont *)otherTitleFont;

- (void)present;

- (void)disappear;
@end
