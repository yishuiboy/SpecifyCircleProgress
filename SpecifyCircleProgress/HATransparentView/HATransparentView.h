//
//  HATransparentView.h
//  HATransparentView
//
//  Created by wangzzh on 14/11/1.
//  Copyright (c) 2014年 wangzzh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HAStyle) { HAStyleLight = 0, HAStyleBlack, };

@protocol HATransparentViewDelegate <NSObject>
@optional
- (void)HATransparentViewDidClosed;
@end

@interface HATransparentView : UIView

@property(nonatomic, assign) HAStyle style;
@property(nonatomic, assign) id<HATransparentViewDelegate> delegate;
@property(nonatomic, assign) BOOL hideCloseButton;
@property(nonatomic, assign, setter=tapBackgroundToClose:) BOOL tapBackgroundToClose;

- (void)open;
- (void)close;

@end