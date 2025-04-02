// Modified By @Waa
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface DYYYBottomSheetView : UIView
@property (nonatomic, copy) void (^confirmAction)(void);
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle;
- (void)show;
@end

@implementation DYYYBottomSheetView {
    UIView *containerView;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];

        CGFloat height = 230;
        containerView = [[UIView alloc] initWithFrame:CGRectMake(6, self.frame.size.height, self.frame.size.width - 12, height)];
        containerView.backgroundColor = [UIColor whiteColor];
        containerView.layer.cornerRadius = 50;
        containerView.clipsToBounds = YES;

        // 添加拖拽手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [containerView addGestureRecognizer:panGesture];

        // 标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, containerView.frame.size.width - 60, 24)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.center = CGPointMake(containerView.frame.size.width / 2, titleLabel.center.y);

        // 内容
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 20, containerView.frame.size.width - 60, 60)];
        messageLabel.text = message;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont systemFontOfSize:17];
        messageLabel.textColor = [UIColor darkGrayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.center = CGPointMake(containerView.frame.size.width / 2, messageLabel.center.y);

        // 确定按钮
        UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width * 0.52, containerView.frame.size.height - 75, containerView.frame.size.width * 0.4, 50)];
        // confirmButton.center = CGPointMake(containerView.frame.size.width / 2, confirmButton.center.y);
        [confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirmButton.backgroundColor = [UIColor colorWithRed:254/255.0 green:47/255.0 blue:85/255.0 alpha:1.0];
        confirmButton.layer.cornerRadius = 14;
        confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [confirmButton addTarget:self action:@selector(confirmTapped) forControlEvents:UIControlEventTouchUpInside];

        // 取消按钮
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width * 0.08, CGRectGetMaxY(confirmButton.frame) - 50, containerView.frame.size.width * 0.4, 50)];
        // cancelButton.center = CGPointMake(containerView.frame.size.width / 2, cancelButton.center.y);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        cancelButton.layer.cornerRadius = 14;
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];

        [containerView addSubview:titleLabel];
        [containerView addSubview:messageLabel];
        [containerView addSubview:confirmButton];
        [containerView addSubview:cancelButton];
        [self addSubview:containerView];
    }
    return self;
}

// 显示动画
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        containerView.frame = CGRectMake(6, self.frame.size.height - containerView.frame.size.height - 6, self.frame.size.width - 12, containerView.frame.size.height);
    }];
}

// 关闭动画
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        containerView.frame = CGRectMake(6, self.frame.size.height, self.frame.size.width - 12, containerView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 拖拽手势
- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:containerView];
    if (translation.y > 0) {
        containerView.frame = CGRectMake(6, self.frame.size.height - containerView.frame.size.height + translation.y, self.frame.size.width - 12, containerView.frame.size.height);
    }

    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (translation.y > 100) {
            [self dismiss];
        } else {
            [UIView animateWithDuration:0.2 animations:^{
                containerView.frame = CGRectMake(6, self.frame.size.height - containerView.frame.size.height - 6, self.frame.size.width - 12, containerView.frame.size.height);
            }];
        }
    }
}

// 确定按钮点击
- (void)confirmTapped {
    if (self.confirmAction) {
        self.confirmAction();
    }
    [self dismiss];
}

@end

%hook UITapGestureRecognizer

- (void)setState:(UIGestureRecognizerState)state {
    if (state == UIGestureRecognizerStateEnded) {
        UIView *targetView = self.view;
        if ([targetView isKindOfClass:NSClassFromString(@"AWEPlayInteractionFollowPromptView")] || 
            [targetView.superview isKindOfClass:NSClassFromString(@"AWEPlayInteractionFollowPromptView")]) {
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYfollowTips"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    DYYYBottomSheetView *alertView = [[DYYYBottomSheetView alloc] initWithTitle:@"关注确认"
                                                                                        message:@"是否确认关注？"
                                                                                   confirmTitle:@"确定"];
                    alertView.confirmAction = ^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            %orig(state);
                        });
                    };
                    [alertView show];
                });
                return;
            }
        }
    }
    %orig(state);
}

%end

@interface AWEFeedVideoButton : UIButton
@property (nonatomic, strong) NSString *accessibilityLabel;
@end

%hook AWEFeedVideoButton
- (id)touchUpInsideBlock {
    id r = %orig;

    NSString *label = [self valueForKey:@"accessibilityLabel"];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYcollectTips"] && [label isEqualToString:@"收藏"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            DYYYBottomSheetView *alertView = [[DYYYBottomSheetView alloc] initWithTitle:@"收藏确认"
                                                                                message:@"是否[确认/取消]收藏？"
                                                                           confirmTitle:@"确定"];
            alertView.confirmAction = ^{
                if (r && [r isKindOfClass:NSClassFromString(@"NSBlock")]) {
                    ((void(^)(void))r)();
                }
            };
            [alertView show];
        });

        return nil;
    }

    return r;
}
%end

@interface AWEBaseElementView : UIView
@end

// 隐藏汽水音乐
@interface AWEAwemeMusicInfoView : UIButton
@end

%hook AWEAwemeMusicInfoView
- (void)layoutSubviews {
    %orig;

    UIView *superview = self.superview;

    if ([superview isKindOfClass:NSClassFromString(@"AWEBaseElementView")]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideQuqishuiting"]) {
            self.hidden = YES;
            superview.hidden = YES;
        }
    }
}
%end

// 隐藏头像➕号
@interface LOTAnimationView : UIView
@end

%hook LOTAnimationView
- (void)layoutSubviews {
    %orig;

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideFollow+"] &&
        [self.superview isKindOfClass:%c(AWEPlayInteractionFollowPromptView)]) {
        [self removeFromSuperview];
    }
}
%end

// 隐藏弹幕按钮
@interface AWEPlayDanmakuInputContainView : UIView
@end

%hook AWEPlayDanmakuInputContainView

- (void)layoutSubviews {
    %orig;

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideDanmuButton"]) {
        self.hidden = YES;
    }
}

%end

// 隐藏点击推荐
@interface AFDRecommendToFriendEntranceLabel : UIView
@end

%hook AFDRecommendToFriendEntranceLabel

- (void)layoutSubviews {
    %orig;

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideRecommend"]) {
        [self removeFromSuperview];
    }
}

%end

// 隐藏商店物品
@interface AWEECommerceEntryView : UIView
@end

%hook AWEECommerceEntryView
- (void)layoutSubviews {
    %orig;

    UIView *superview = self.superview;

    if ([superview isKindOfClass:NSClassFromString(@"AWEBaseElementView")]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideStoreItems"]) {
            self.hidden = YES;
            superview.hidden = YES;
        }
    }
}
%end

// 隐藏视频定位/商店预约
@interface AWEFeedAnchorContainerView : UIView
@end

%hook AWEFeedAnchorContainerView
- (void)layoutSubviews {
    %orig;

    UIView *superview = self.superview;

    if ([superview isKindOfClass:NSClassFromString(@"AWEBaseElementView")]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideLocation"]) {
            self.hidden = YES;
            superview.hidden = YES;
        }
    }
}
%end

// 隐藏右下音乐
@interface AWEMusicCoverButton : UIButton
@end

%hook AWEMusicCoverButton
- (void)layoutSubviews {
    %orig;

    NSString *accessibilityLabel = self.accessibilityLabel;

    if ([accessibilityLabel isEqualToString:@"音乐详情"]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideMusicButton"]) {
            self.alpha = 0;
        }
    }
}
%end

@interface AFDCancelMuteAwemeView : UIView
@end

%hook AFDCancelMuteAwemeView
- (void)willMoveToSuperview:(UIView *)newSuperview {
    %orig;

    if (newSuperview == nil && [[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideMusicButton"]) {

        UIView *superview = self.superview;
        if ([superview isKindOfClass:NSClassFromString(@"AWEBaseElementView")]) {
            [superview removeFromSuperview];
        }

    }
}
%end

// 隐藏挑战同款
@interface ACCGestureResponsibleStickerView : UIView
@end

%hook ACCGestureResponsibleStickerView

- (void)layoutSubviews {
    %orig;

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideChallenge"]) {
        self.hidden = YES;
    }
}

%end

// 调整评论区透明度
@interface AWEBaseListViewController : UIViewController
@end

%hook AWEBaseListViewController
- (void)viewDidLayoutSubviews {
    %orig;
    if ([self isKindOfClass:NSClassFromString(@"AWECommentPanelContainerSwiftImpl.CommentContainerInnerViewController")]) {
        NSString *transparencyStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"DYYYCommentTransparency"];
        CGFloat transparency = 1.0;
        
        if (transparencyStr && transparencyStr.length > 0) {
            transparency = [transparencyStr floatValue];
            transparency = MAX(0.0, MIN(1.0, transparency));
        }
        
        for (UIView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIVisualEffectView class]]) {
                subview.alpha = transparency;
            }
        }
    }
}
%end

// 输入框透明度
static void *HasAdjustedAlphaKey = &HasAdjustedAlphaKey;

// 计算颜色的更深版本
UIColor *darkerColorForColor(UIColor *color) {
    CGFloat hue, saturation, brightness, alpha;
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness * 0.9 alpha:alpha];
    }
    return color;
}

@interface UIView (CustomColor)
- (void)traverseSubviews:(UIView *)view customColor:(UIColor *)customColor;
- (void)recursiveModifyImageViewsInView:(UIView *)view;
@end

@implementation UIView (CustomColor)

- (void)traverseSubviews:(UIView *)view customColor:(UIColor *)customColor {
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)view;
        if ([label.text containsString:@"条评论"]) {
            label.textColor = customColor;
        }
    }

    for (UIView *subview in view.subviews) {
        [self traverseSubviews:subview customColor:customColor];
    }
}

- (void)recursiveModifyImageViewsInView:(UIView *)view {
    BOOL isCommentColorEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYEnableCommentColor"];
    NSString *customHexColor = [[NSUserDefaults standardUserDefaults] stringForKey:@"DYYYCommentColor"];
    UIColor *customColor = nil;

    if (customHexColor.length > 0) {
        unsigned int hexValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:[customHexColor hasPrefix:@"#"] ? [customHexColor substringFromIndex:1] : customHexColor];
        if ([scanner scanHexInt:&hexValue]) {
            customColor = [UIColor colorWithRed:((hexValue >> 16) & 0xFF) / 255.0
                                          green:((hexValue >> 8) & 0xFF) / 255.0
                                           blue:(hexValue & 0xFF) / 255.0
                                          alpha:0.9];
        }
    }

    UIColor *targetColor = isCommentColorEnabled && customColor ? customColor : [UIColor redColor];

    for (UIView *subview in view.subviews) {
        if ([NSStringFromClass([subview class]) containsString:@"Image"] || 
            [subview isKindOfClass:[UIImageView class]]) {
            
            UIImageView *imgView = (UIImageView *)subview;
            if (imgView.image) {
                imgView.image = [imgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }
            imgView.tintColor = targetColor;
        }
        [self recursiveModifyImageViewsInView:subview];
    }
}

@end

@interface UIView (FullScreenPlus)
- (BOOL)fs_isQuickReplayView;
@end

@implementation UIView (FullScreenPlus)
- (BOOL)fs_isQuickReplayView {
    UIResponder *responder = self;
    while (responder) {
        if ([NSStringFromClass([responder class]) containsString:@"AWEIMFeedVideoQuickReplay"]) {
            return YES;
        }
        responder = [responder nextResponder];
    }
    return NO;
}

@end

%hook UIView

- (void)layoutSubviews {
    %orig;

    NSString *className = NSStringFromClass([self class]);

    BOOL isCommentBlurEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYisEnableCommentBlur"];
    BOOL isFullScreenEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYisEnableFullScreen"];
    BOOL isCommentColorEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYEnableCommentColor"];

    if ([className isEqualToString:@"AWECommentInputViewSwiftImpl.CommentInputViewMiddleContainer"]) {
        NSNumber *hasAdjusted = objc_getAssociatedObject(self, HasAdjustedAlphaKey);
        if (!hasAdjusted || ![hasAdjusted boolValue]) { 
            CGFloat transparency = 1.0;
            NSString *transparentValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"DYYYInputBoxTransparency"];
            if (transparentValue.length > 0) {
                transparency = [transparentValue floatValue];
                transparency = MAX(0.0, MIN(1.0, transparency));
            }
            for (UIView *subview in self.subviews) {
                if (![subview isKindOfClass:[UILabel class]] && ![subview isKindOfClass:[UIButton class]]) {
                    subview.alpha = transparency;
                    break;
                }
            }
            objc_setAssociatedObject(self, HasAdjustedAlphaKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }

    if (isCommentBlurEnabled) {
        for (UIView *subview in self.subviews) {
            CGRect frame = subview.frame;
            if (frame.size.width == 430 && frame.size.height == 0.6666666666666666) {
                subview.hidden = YES;
            }
        }
    }

    if (isCommentColorEnabled) {
        NSString *customHexColor = [[NSUserDefaults standardUserDefaults] stringForKey:@"DYYYCommentColor"];
        UIColor *customColor = nil;

        if (customHexColor.length > 0) {
            unsigned int hexValue = 0;
            NSScanner *scanner = [NSScanner scannerWithString:[customHexColor hasPrefix:@"#"] ? [customHexColor substringFromIndex:1] : customHexColor];
            if ([scanner scanHexInt:&hexValue]) {
                customColor = [UIColor colorWithRed:((hexValue >> 16) & 0xFF) / 255.0
                                              green:((hexValue >> 8) & 0xFF) / 255.0
                                               blue:(hexValue & 0xFF) / 255.0
                                              alpha:1.0];
            }
        }

        if (customColor) {
            UIColor *darkerColor = darkerColorForColor(customColor);
            Class YYLabelClass = NSClassFromString(@"YYLabel");

            for (UIView *subview in self.subviews) {
                NSString *subviewClassName = NSStringFromClass([subview class]);

                // 修改评论区文字颜色
                if ([subview isKindOfClass:[UILabel class]] &&
                    [subviewClassName isEqualToString:@"AWECommentSwiftBizUI.CommentInteractionBaseLabel"]) {
                    ((UILabel *)subview).textColor = darkerColor;
                } else if (YYLabelClass && [subview isKindOfClass:YYLabelClass] &&
                           [subviewClassName isEqualToString:@"AWECommentPanelListSwiftImpl.BaseCellCommentLabel"]) {
                    ((UILabel *)subview).textColor = customColor;
                } else if ([subview isKindOfClass:[UILabel class]] &&
                           [subviewClassName isEqualToString:@"AWECommentPanelHeaderSwiftImpl.CommentHeaderCell"]) {
                    ((UILabel *)subview).textColor = customColor;
                }
            }

            Class targetClass = objc_getClass("AWECommentPanelListSwiftImpl.CommentFooterView");
            if (targetClass && [self isKindOfClass:targetClass]) {
                [self recursiveModifyImageViewsInView:self];
            }

            for (UIView *subview in self.subviews) {
                if ([subview isKindOfClass:[UIButton class]]) {
                    UIButton *button = (UIButton *)subview;
                    NSString *buttonText = [button titleForState:UIControlStateNormal];
                    if ([buttonText containsString:@"展开"] && [buttonText containsString:@"条回复"]) {
                        [button setTitleColor:darkerColor forState:UIControlStateNormal]; 
                    }
                }
            }

            [self traverseSubviews:self customColor:customColor];
        }
    }

    if (isFullScreenEnabled && [self fs_isQuickReplayView]) {
        if (![NSStringFromClass([self class]) containsString:@"AWEIMFeedBottomQuickEmojiInputBar"]) {
            self.backgroundColor = [UIColor clearColor];
            self.layer.backgroundColor = [UIColor clearColor].CGColor;
        }
    }

}

%end