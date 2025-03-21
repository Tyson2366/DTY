//
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

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideFollowSymbol"]) {
        self.hidden = YES;
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

//隐藏右下音乐和取消静音
@interface AFDCancelMuteAwemeView : UIView
@end

%hook AFDCancelMuteAwemeView
- (void)layoutSubviews {
    %orig;

    UIView *superview = self.superview;

    if ([superview isKindOfClass:NSClassFromString(@"AWEBaseElementView")]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideMusicButton"]) {
            self.hidden = YES;
            superview.hidden = YES;
        }
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

//调整输入框透明度
static void *HasAdjustedAlphaKey = &HasAdjustedAlphaKey;

%hook UIView

- (void)layoutSubviews {
    %orig;

    NSString *className = NSStringFromClass([self class]);
    
    if ([className isEqualToString:@"AWECommentInputViewSwiftImpl.CommentInputViewMiddleContainer"]) {
        NSNumber *hasAdjusted = objc_getAssociatedObject(self, HasAdjustedAlphaKey);
        if (hasAdjusted && [hasAdjusted boolValue]) {
            return;
        }

        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:[UIView class]]) {
                if (![subview isKindOfClass:[UILabel class]] && 
                    ![subview isKindOfClass:[UIButton class]]) {
                    NSString *transparentValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"DYYYInputBoxTransparency"];
                    CGFloat transparency = 1.0;
                    
                    if (transparentValue && transparentValue.length > 0) {
                        transparency = [transparentValue floatValue];
                        transparency = MAX(0.0, MIN(1.0, transparency));
                    }
                    
                    NSLog(@"Found AWECommentInputViewSwiftImpl_CommentInputViewMiddleContainer, setting alpha to %f for first UIView: %@", transparency, subview);
                    subview.alpha = transparency;
                    objc_setAssociatedObject(self, HasAdjustedAlphaKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                    break;
                }
            }
        }
    }
}

%end
