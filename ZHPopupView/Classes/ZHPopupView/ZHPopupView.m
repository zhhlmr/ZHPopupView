//
//  ZHPopupView.m
//  ZHPopupView
//
//  Created by zhhlmr on 16/4/25.
//  Copyright © 2016年 zhhlmr. All rights reserved.
//

#import "ZHPopupView.h"
#import "UIView+DropShadow.h"
#import "UIColor+HexString.h"
#import "UIImageEffects.h"

#define kZHPopupViewContainerLeftRightInterval 55.0f
#define kZHPopupView_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kZHPopupView_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define kZHPopupViewContainerDefaultHeight 243.0f

#define kZHPopupView_HeadInterval 20.0f
#define kZHPopupView_InsideLeftInterval 25.0f

#define kZHPopupView_buttonDefaultHeight 40.0f

#define COLOR_333333 [UIColor colorWithHexString:@"333333"]
#define COLOR_MAINRED [UIColor colorWithHexString:@"e31919"]
#define COLOR_MAINBLUE [UIColor colorWithHexString:@"1bb4df"]
#define COLOR_E5E5E5 [UIColor colorWithHexString:@"e5e5e5"]


@interface ZHPopupView () {
}

@property(nonatomic, strong) UIImageView *headIconImgView;
@property(nonatomic, strong) UILabel *headTitleLbl;

@property(nonatomic, strong) UITextView *contentTextView;
@property(nonatomic, strong) UIView *container;
@property(nonatomic, weak) UIView *parentView;
@property(nonatomic, assign) ZHPopupViewBackgroundType backgroundType;

@property(nonatomic, strong) UIView *buttonArea;


@end

@implementation ZHPopupView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialization];
        
        
    }
    return self;
}

- (instancetype)initPopUpViewInView:(UIView *)view backgroundType:(ZHPopupViewBackgroundType)backgroundType {
    self.parentView = view;
    self.backgroundType = backgroundType;
    self = [super initWithFrame:view.bounds];
    if (self) {
        [self _initialization];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"dealloc of %@", [self class]);
    if (nil != [self superview]) {
        [self removeFromSuperview];
    }
}

#pragma mark - Pubic Structure


+ (instancetype)popUpDialogViewInView:(UIView *)view iconImg:(UIImage *)iconImg backgroundStyle:(ZHPopupViewBackgroundType)backgroundType title:(NSString *)title content:(NSString *)content buttonTitles:(NSArray *)titles confirmBtnTextColor:(UIColor *)confirmBtnTextColor otherBtnTextColor:(UIColor *)otherBtnTextColor buttonPressedBlock:(void (^)(NSInteger btnIdx))buttonPressedBlock {
    view = (nil == view) ?[UIApplication sharedApplication].keyWindow : view;
    ZHPopupView *popView = [[ZHPopupView alloc] initPopUpViewInView:view backgroundType:backgroundType];
    
    
    [view addSubview:popView];
    
    [popView setHeadIconImg:iconImg];
    
    [popView setHeadTitle:(nil == title) ? @"" : title];
    
    [popView setContent:(nil == content) ? @"" : content];
    
    [popView configureButtonWithTitles:titles confirmTitleColor:confirmBtnTextColor otherTitleColor:otherBtnTextColor];
    
    [popView setButtonPressedBlock:buttonPressedBlock];
    
    
    return popView;
}

+ (instancetype)popUpDialogViewInView:(UIView *)view
                              iconImg:(UIImage *)iconImg
                      backgroundStyle:(ZHPopupViewBackgroundType)backgroundType
                                title:(NSString *)title
                              content:(NSString *)content
                         buttonTitles:(NSArray *)titles
                  confirmBtnTextColor:(UIColor *)confirmBtnTextColor
                    otherBtnTextColor:(UIColor *)otherBtnTextColor
                   buttonPressedBlock:(void (^)(NSInteger btnIdx))buttonPressedBlock
                   viewDismissedBlock:(void (^)())viewDismissedBlock
{
    ZHPopupView *popView = [ZHPopupView popUpDialogViewInView:view
                                                      iconImg:iconImg
                                              backgroundStyle:backgroundType
                                                        title:title
                                                      content:content
                                                 buttonTitles:titles
                                          confirmBtnTextColor:confirmBtnTextColor
                                            otherBtnTextColor:otherBtnTextColor
                                           buttonPressedBlock:buttonPressedBlock];
    
    [popView setViewDismissedBlock:viewDismissedBlock];
    
    return popView;
}

+ (instancetype)popupNomralAlertViewInView:(UIView *)view backgroundStyle:(ZHPopupViewBackgroundType)backgroundType title:(NSString *)title content:(NSString *)content buttonTitles:(NSArray *)titles confirmBtnTextColor:(UIColor *)confirmBtnTextColor otherBtnTextColor:(UIColor *)otherBtnTextColor buttonPressedBlock:(void (^)(NSInteger btnIdx))buttonPressedBlock {
    
    view = (nil == view) ?[UIApplication sharedApplication].keyWindow : view;
    ZHPopupView *popView = [[ZHPopupView alloc] initPopUpViewInView:view backgroundType:backgroundType];
    
    [view addSubview:popView];
    
    [popView setHeadTitle:(nil == title) ? @"" : title];
    [popView setHeadTitleFontSize:14.0f];
    
    [popView setContent:(nil == content) ? @"" : content];
    [popView setContentTextAlignment:NSTextAlignmentCenter];
    
    [popView configureButtonWithTitles:titles confirmTitleColor:confirmBtnTextColor otherTitleColor:otherBtnTextColor];
    
    [popView setButtonPressedBlock:buttonPressedBlock];
    
    
    return popView;
    
}

+ (instancetype)popupNomralAlertViewInView:(UIView *)view
                           backgroundStyle:(ZHPopupViewBackgroundType)backgroundType
                                     title:(NSString *)title
                                   content:(NSString *)content
                              buttonTitles:(NSArray *)titles
                       confirmBtnTextColor:(UIColor *)confirmBtnTextColor
                         otherBtnTextColor:(UIColor *)otherBtnTextColor
                        buttonPressedBlock:(void (^)(NSInteger btnIdx))buttonPressedBlock
                        viewDismissedBlock:(void (^)())viewDismissedBlock
{
    ZHPopupView *popView = [ZHPopupView popupNomralAlertViewInView:view
                                                   backgroundStyle:backgroundType
                                                             title:title
                                                           content:content
                                                      buttonTitles:titles
                                               confirmBtnTextColor:confirmBtnTextColor
                                                 otherBtnTextColor:otherBtnTextColor
                                                buttonPressedBlock:buttonPressedBlock];
    
    [popView setViewDismissedBlock:viewDismissedBlock];
    
    return popView;
}

+ (instancetype)popupViewOnKeyWindow {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    ZHPopupView *popView = [[ZHPopupView alloc] initPopUpViewInView:keyWindow backgroundType:ZHPopupViewBackgroundType_SimpleOpacity];
    [keyWindow addSubview:popView];
    
    return popView;
}


+ (instancetype)popupBlurViewOnKeyWindow {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    ZHPopupView *popView = [[ZHPopupView alloc] initPopUpViewInView:keyWindow backgroundType:ZHPopupViewBackgroundType_Blur];
    [keyWindow addSubview:popView];
    
    return popView;
}

+ (instancetype)popupViewInView:(UIView *)view {
    ZHPopupView *popView = [[ZHPopupView alloc] initPopUpViewInView:view backgroundType:ZHPopupViewBackgroundType_SimpleOpacity];
    
    [view addSubview:popView];
    
    return popView;
}

+ (instancetype)popupBlurViewInView:(UIView *)view {
    ZHPopupView *popView = [[ZHPopupView alloc] initPopUpViewInView:view backgroundType:ZHPopupViewBackgroundType_Blur];
    
    [view addSubview:popView];
    
    return popView;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat previousYPos = kZHPopupView_HeadInterval;
    CGRect frame;
    
    if (nil != _headIconImgView && nil != [_headIconImgView superview] && nil != _headIconImg) {
        
        frame = _headIconImgView.frame;
        frame.origin.y = kZHPopupView_HeadInterval;
        [_headIconImgView setFrame:frame];
        previousYPos = CGRectGetMaxY(_headIconImgView.frame);
    }
    
    if (nil != _headTitleLbl && nil != [_headTitleLbl superview]) {
        frame = _headTitleLbl.frame;
        if (nil == _headTitleLbl.text || _headTitleLbl.text.length <= 0) {
            //hide by height
            frame.size.height = 0.0f;
        } else {
            CGSize textSize = [_headTitleLbl.text sizeWithAttributes:@{
                                                                       NSFontAttributeName : _headTitleLbl.font
                                                                       }];
            frame.size.height = textSize.height;
            frame.origin.y = (previousYPos == kZHPopupView_HeadInterval) ? kZHPopupView_HeadInterval : previousYPos + 20.0f;
            
        }
        [_headTitleLbl setFrame:frame];
        previousYPos = CGRectGetMaxY(_headTitleLbl.frame);
        
        
        
    }
    
    [_contentTextView sizeToFit];
    frame = _contentTextView.frame;
    frame.origin.y = (previousYPos == kZHPopupView_HeadInterval) ? kZHPopupView_HeadInterval : previousYPos +25.0f;
    if (self.contentTextAlignment == NSTextAlignmentCenter) {
        frame.origin.x = self.container.frame.size.width / 2 - frame.size.width / 2;
    } else if (self.contentTextAlignment == NSTextAlignmentLeft) {
        frame.origin.x = kZHPopupView_InsideLeftInterval;
    } else {
        frame.origin.x = self.container.frame.size.width - kZHPopupView_InsideLeftInterval - frame.size.width;
    }
    [_contentTextView setFrame:frame];
    [_contentTextView setTextContainerInset:UIEdgeInsetsZero];
    
    //again adjust frame
    
    if (_contentTextView.text.length <= 0) {
        //there's no content displaying,need to trim the space
        
        frame = _headTitleLbl.frame;
        frame.origin.y = self.container.frame.size.height - kZHPopupView_buttonDefaultHeight - 25.0f - _headTitleLbl.frame.size.height;
        [_headTitleLbl setFrame:frame];
        
        frame = self.container.frame;
        frame.size.height = frame.size.height - CGRectGetMinY(_headTitleLbl.frame) + 20.0f;
        frame.origin.y = self.frame.size.height / 2 - frame.size.height / 2;
        [self.container setFrame:frame];
    } else {
        
        //adjust button Area
        
        if (nil != _buttonArea) {
            frame = _buttonArea.frame;
            frame.origin.y = CGRectGetMaxY(_contentTextView.frame) + 25.0f;
            [_buttonArea setFrame:frame];
        }
        
        
        frame = self.container.frame;
        frame.size.height = CGRectGetMaxY(_buttonArea.frame);
        frame.origin.y = self.frame.size.height / 2 - frame.size.height / 2;
        [self.container setFrame:frame];
    }
    
    
}

#pragma mark - Initialization

- (void)_initialization {
    [self _createView];
}

#pragma mark - Events

- (void)pressedOnTitleButton:(UIButton *)sender {
    
    NSInteger idx = sender.tag - 233;
    
    [self disappear];
    
    if (nil != self.buttonPressedBlock) {
        self.buttonPressedBlock(idx);
    }
    
    
}

- (void)configureButtonWithTitles:(NSArray *)titles confirmTitleColor:(UIColor *)confirmTitleColor otherTitleColor:(UIColor *)otherTitleColor {
    if (nil == titles || titles.count <= 0) {
        return;
    }
    [[self.buttonArea subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    
    confirmTitleColor = (nil == confirmTitleColor) ? COLOR_MAINBLUE : confirmTitleColor;
    otherTitleColor = (nil == otherTitleColor) ? COLOR_333333 : otherTitleColor;
    
    __block CGFloat perWidth = self.container.frame.size.width / titles.count;
    
    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        if (nil == title || title.length <= 0) {
            return;
        }
        
        UIButton *btn = [self buttonWithTitle:title textColor:(idx == titles.count - 1) ? confirmTitleColor : otherTitleColor width:perWidth xPos:idx * perWidth yPos:0];
        [btn setTag:idx + 233];
        [btn addTarget:self action:@selector(pressedOnTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArea addSubview:btn];
        
        if (idx != titles.count - 1) {
            UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), CGRectGetMinY(btn.frame), 0.5f, btn.frame.size.height)];
            [seperator setBackgroundColor:COLOR_E5E5E5];
            [self.buttonArea addSubview:seperator];
        }
        
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.container.frame.size.width, 0.5f)];
    [line setBackgroundColor:COLOR_E5E5E5];
    [self.buttonArea addSubview:line];
    
    if (nil == [self.buttonArea superview]) {
        [self.container addSubview:self.buttonArea];
    }
    
    [self layoutSubviews];
    
}

- (UIButton *)buttonWithTitle:(NSString *)title textColor:(UIColor *)textColor width:(CGFloat)width xPos:(CGFloat)xPos yPos:(CGFloat)yPos {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(xPos, yPos, width, 40.0f)];
    
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    
    return button;
}

#pragma mark - Properties


- (void)setHeadTextAlignment:(NSTextAlignment)headTextAlignment {
    _headTextAlignment = headTextAlignment;
    
    [self.headTitleLbl setTextAlignment:headTextAlignment];
    
}

- (void)setContentTextAlignment:(NSTextAlignment)contentTextAlignment {
    _contentTextAlignment = contentTextAlignment;
    
    [self.contentTextView setTextAlignment:contentTextAlignment];
}

- (void)setHeadTitleFontSize:(CGFloat)headTitleFontSize {
    _headTitleFontSize = headTitleFontSize;
    
    [self.headTitleLbl setFont:[UIFont systemFontOfSize:headTitleFontSize]];
    
    [self layoutSubviews];
}

- (void)setContentTextFontSize:(CGFloat)contentTextFontSize {
    _contentTextFontSize = contentTextFontSize;
    [self.contentTextView setFont:[UIFont systemFontOfSize:contentTextFontSize]];
    [self layoutSubviews];
}


- (void)setHeadTitleColor:(UIColor *)headTitleColor {
    _headTitleColor = headTitleColor;
    
    [self.headTitleLbl setTextColor:_headTitleColor];
}

- (void)setContentTextColor:(UIColor *)contentTextColor {
    _contentTextColor = contentTextColor;
    
    [self.contentTextView setTextColor:contentTextColor];
}

- (void)setHeadIconImg:(UIImage *)headIconImg {
    _headIconImg = headIconImg;
    [self.headIconImgView setImage:headIconImg];
    if (nil == [self.headIconImgView superview]) {
        [self.container addSubview:self.headIconImgView];
    }
    [self layoutSubviews];
}

- (void)setHeadTitle:(NSString *)headTitle {
    
    _headTitle = headTitle;
    [self.headTitleLbl setText:headTitle];
    if (nil == [self.headTitleLbl superview]) {
        [self.container addSubview:self.headTitleLbl];
    }
    
    [self layoutSubviews];
}

- (void)setContent:(NSString *)content {
    
    _content = content;
    [self.contentTextView setText:content];
    if (nil == [self.contentTextView superview]) {
        [self.container addSubview:self.contentTextView];
    }
    
    [self layoutSubviews];
}

- (UIView *)buttonArea {
    if (nil == _buttonArea) {
        
        _buttonArea = [[UIView alloc] initWithFrame:CGRectMake(0, self.container.frame.size.height - kZHPopupView_buttonDefaultHeight, self.container.frame.size.width, kZHPopupView_buttonDefaultHeight)];
        
    }
    return _buttonArea;
}

- (UIImageView *)headIconImgView {
    if (nil == _headIconImgView) {
        _headIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.container.frame.size.width / 2 - 17.5f, kZHPopupView_HeadInterval, 35.0f, 35.0f)];
        [_headIconImgView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _headIconImgView;
}

- (UILabel *)headTitleLbl {
    if (nil == _headTitleLbl) {
        _headTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(kZHPopupView_InsideLeftInterval, 0.0f, self.container.frame.size.width - 2 * kZHPopupView_InsideLeftInterval, 20.0f)];
        [_headTitleLbl setTextColor:[UIColor darkTextColor]];
        [_headTitleLbl setFont:[UIFont systemFontOfSize:20.0f]];
        [_headTitleLbl setTextAlignment:NSTextAlignmentCenter];
        
    }
    return _headTitleLbl;
}

- (UITextView *)contentTextView {
    if (nil == _contentTextView) {
        _contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(kZHPopupView_InsideLeftInterval, 0.0f, self.container.frame.size.width - 2 * kZHPopupView_InsideLeftInterval, 20.0f)];
        [_contentTextView setTextColor:[UIColor darkTextColor]];
        [_contentTextView setFont:[UIFont systemFontOfSize:14.0f]];
        [_contentTextView setBackgroundColor:[UIColor clearColor]];
        [_contentTextView setUserInteractionEnabled:NO];
        [_contentTextView setScrollEnabled:NO];
        [_contentTextView setEditable:NO];
    }
    return _contentTextView;
}

- (UIView *)container {
    if (nil == _container) {
        
        CGFloat xPos = kZHPopupViewContainerLeftRightInterval;
        CGFloat yPos = ((nil != self.parentView) ? self.parentView.bounds.size.height / 2 : kZHPopupView_ScreenHeight / 2) - kZHPopupViewContainerDefaultHeight / 2;
        CGFloat width = ((nil != self.parentView) ? self.parentView.bounds.size.width : kZHPopupView_ScreenWidth) - 2 * kZHPopupViewContainerLeftRightInterval;
        CGFloat height = kZHPopupViewContainerDefaultHeight;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [view.layer setCornerRadius:5.0f];
        [view.layer setMasksToBounds:YES];
        
        //        [view dropShadowWithShadowColor:[UIColor colorWithWhite:0.0f alpha:0.8f] offset:CGSizeMake(0, 3.0f) opacity:0.5f radius:10.0f];
        _container = view;
        view = nil;
    }
    
    return _container;
}


#pragma mark - Display Event


- (void)present {
    
    if (nil == self.parentView) {
        return;
    }
    if (nil == [self superview]) {
        
        [self.parentView addSubview:self];
    }
    
    [self.layer setOpacity:0.0f];
    [_container.layer setOpacity:0.0f];
    
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.layer setOpacity:1.0f];
        [_container.layer setOpacity:1.0f];
    }                completion:^(BOOL finished) {
        
        
        //        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //
        
        //        animation.duration = 0.08f;
        //        animation.autoreverses = YES;
        //
        
        //        animation.fromValue = [NSNumber numberWithFloat:1.0f];
        //        animation.toValue = [NSNumber numberWithFloat:1.03f];
        //
        
        //        [_container.layer addAnimation:animation forKey:@"scale-layer"];
        
    }];
    
}

- (void)disappear {
    
    [UIView animateWithDuration:0.1f animations:^{
        [self.layer setOpacity:0.0f];
    }                completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - Background Gesture

- (void)tappedOnBackground:(UITapGestureRecognizer *)tapGesture {
    
    CGPoint location = [tapGesture locationInView:self];
    if (CGRectContainsPoint(self.container.frame, location)) {
        return;
    }
    [self disappear];
    
    if (self.viewDismissedBlock != nil) {
        _viewDismissedBlock();
    }
}

#pragma mark - View


- (void)_configureBackgroundBlur {
    //structure view
    UIGraphicsBeginImageContext(self.parentView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.parentView.layer renderInContext:context];
    UIImage *clipImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIColor *tintColor = [UIColor colorWithWhite:0.10 alpha:0.3];
    
    UIImage *blurImg = [UIImageEffects imageByApplyingBlurToImage:clipImg withRadius:10 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:blurImg];
    
    [self addSubview:bgImgView];
    
    
}

- (void)_createView {
    
    [self.layer setOpacity:0.0f];
    
    if (self.backgroundType == ZHPopupViewBackgroundType_SimpleOpacity) {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    } else {
        [self _configureBackgroundBlur];
    }
    
    
    [self addSubview:[self container]];
    
    //Tap gesture
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnBackground:)];
    [self addGestureRecognizer:tapGesture];
    
    
}
@end
