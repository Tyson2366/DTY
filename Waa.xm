//Modified By @Waa
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface AWEBaseElementView : UIView
@end

//隐藏头像➕号
@interface LOTAnimationView : UIView
@end

%hook LOTAnimationView
- (void)layoutSubviews {
    %orig;

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideFollow+"]) {
        [self removeFromSuperview];
        return;
    }
}
%end

//隐藏弹幕按钮
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

//隐藏点击推荐
@interface AFDRecommendToFriendEntranceLabel : UIView
@end

%hook AFDRecommendToFriendEntranceLabel

- (void)layoutSubviews {
    %orig;

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideRecommend"]) {
        self.hidden = YES;
    }
}

%end

//隐藏商店物品
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

//隐藏商店预约
@interface AWEFeedAnchorContainerView : UIView
@end

%hook AWEFeedAnchorContainerView
- (void)layoutSubviews {
    %orig;

    UIView *superview = self.superview;

    if ([superview isKindOfClass:NSClassFromString(@"AWEBaseElementView")]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideStoreReservation"]) {
            self.hidden = YES;
            superview.hidden = YES;
        }
    }
}
%end

//hook UIView
static void *HasAdjustedAlphaKey = &HasAdjustedAlphaKey;

%hook UIView

- (void)layoutSubviews {
    %orig;

    NSString *className = NSStringFromClass([self class]);

    // 调整输入框透明度
    if ([className isEqualToString:@"AWECommentInputViewSwiftImpl.CommentInputViewMiddleContainer"]) {
        NSNumber *hasAdjusted = objc_getAssociatedObject(self, HasAdjustedAlphaKey);
        if (hasAdjusted && [hasAdjusted boolValue]) {
            return;
        }

        for (UIView *subview in self.subviews) {
            if (![subview isKindOfClass:[UILabel class]] && ![subview isKindOfClass:[UIButton class]]) {
                NSString *transparentValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"DYYYInputBoxTransparency"];
                CGFloat transparency = 1.0;
                
                if (transparentValue && transparentValue.length > 0) {
                    transparency = [transparentValue floatValue];
                    transparency = MAX(0.0, MIN(1.0, transparency));
                }
                
                subview.alpha = transparency;
                objc_setAssociatedObject(self, HasAdjustedAlphaKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                break;
            }
        }
    }

    // 隐藏输入框上方的横线
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYisEnableCommentBlur"]) {
        return;
    }

    for (UIView *subview in self.subviews) {
        CGRect frame = subview.frame;

        // 判断 frame 是否符合目标横线的特征
        if (frame.size.width == 430 && frame.size.height == 0.6666666666666666) {
            subview.hidden = YES;
        }
    }
}

%end

//调整评论区透明度
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


//隐藏右下音乐
@interface AFDCancelMuteAwemeView : UIView
@end

%hook AFDCancelMuteAwemeView
- (void)willMoveToSuperview:(UIView *)newSuperview {
    %orig;

    if (newSuperview == nil && [[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideMusicButton"]) {

        UIView *superview = self.superview;
        if ([superview isKindOfClass:NSClassFromString(@"AWEBaseElementView")]) {
            [superview removeFromSuperview];
            return;

        }

    }
}
%end