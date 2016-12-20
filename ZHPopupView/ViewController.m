//
//  ViewController.m
//  ZHPopupView
//
//  Created by zhhlmr on 16/4/26.
//  Copyright © 2016年 zhhlmr. All rights reserved.
//

#import "ViewController.h"
#import "ZHPopupView.h"

#define kRandomText @"\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\""

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pressed Events

- (IBAction)pressedOnAlertViewPopup:(id)sender {

    ZHPopupView *popupView = [ZHPopupView popupNormalAlertViewInView:nil
                                                     backgroundStyle:ZHPopupViewBackgroundType_SimpleOpacity
                                                               title:@"Tips"
                                                             content:@"Confirm to delete/remove?"
                                                        buttonTitles:@[@"Cancel", @"Confirm"]
                                                 confirmBtnTextColor:nil otherBtnTextColor:nil
                                                  buttonPressedBlock:^(NSInteger btnIdx) {


                                                  }];
    [popupView present];

}

- (IBAction)pressedOnDialogViewPopup:(id)sender {


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


}

- (IBAction)pressedOnBlurAlertViewPopup:(id)sender {

    ZHPopupView *popupView = [ZHPopupView popupNormalAlertViewInView:nil
                                                     backgroundStyle:ZHPopupViewBackgroundType_Blur
                                                               title:@"Tips"
                                                             content:@"Confirm to delete/remove?"
                                                        buttonTitles:@[@"Cancel", @"Confirm"]
                                                 confirmBtnTextColor:nil otherBtnTextColor:nil
                                                  buttonPressedBlock:^(NSInteger btnIdx) {


                                                  }];
    [popupView present];


}

- (IBAction)pressedOnBlurDialogViewPopup:(id)sender {
    ZHPopupView *popupView = [ZHPopupView popUpDialogViewInView:nil
                                                        iconImg:[UIImage imageNamed:@"correct_icon"]
                                                backgroundStyle:ZHPopupViewBackgroundType_Blur
                                                          title:@"Lorem Ipsum"
                                                        content:kRandomText
                                                   buttonTitles:@[@"Cancel", @"Confirm"]
                                            confirmBtnTextColor:nil otherBtnTextColor:nil
                                             buttonPressedBlock:^(NSInteger btnIdx) {


                                             }];
    [popupView present];
}

- (IBAction)pressedOnCustomButtonFontDialogViewPopup:(id)sender {
    UIFont *titleFont = [UIFont fontWithName:@"ComicSansMS" size:15];
    UIFont *buttonFont = [UIFont fontWithName:@"ComicSansMS" size:13];
    UIFont *contentFont = [UIFont fontWithName:@"ComicSansMS" size:14];
    
    ZHPopupView *popupView = [ZHPopupView popUpDialogWithCustomFontViewInView:nil
                                                        iconImg:[UIImage imageNamed:@"correct_icon"]
                                                backgroundStyle:ZHPopupViewBackgroundType_Blur
                                                                        title:@"Lorem Ipsum" titleFont:titleFont
                                                                      content:kRandomText contentFont:contentFont
                                                   buttonTitles:@[@"Cancel", @"Confirm"]
                                                          confirmBtnTextColor:nil confirmTitleFont:buttonFont otherBtnTextColor:nil otherBtnFont:buttonFont buttonPressedBlock:nil];
    [popupView present];
}

@end
