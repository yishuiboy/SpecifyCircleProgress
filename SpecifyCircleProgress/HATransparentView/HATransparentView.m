//
//  HATransparentView.h
//  HATransparentView
//
//  Created by wangzzh on 14/11/1.
//  Copyright (c) 2014年 wangzzh. All rights reserved.
//

#import "HATransparentView.h"

#define kDefaultBackground [UIColor colorWithWhite:0.0 alpha:0.5];

@interface HATransparentView ()

@property(nonatomic, assign) NSInteger statusBarStyle;

@end

@implementation HATransparentView

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.frame = [[UIScreen mainScreen] bounds];
    self.opaque = NO;
    self.backgroundColor = kDefaultBackground;
    self.hideCloseButton = NO;
    self.tapBackgroundToClose = NO;
    [self setHidden:YES];
  }

  return self;
}

//- (void)tapBackgroundToClose:(BOOL)close {
//  if (close) {
//    [self addTapGestureRecognizer];
//  }
//}


#pragma mark - Open Transparent View

- (void)open {
  // Get main window reference
    [self setHidden:NO];
  UIWindow *window = [UIApplication sharedApplication].keyWindow;
  if (!window)
    window = [[UIApplication sharedApplication].windows objectAtIndex:0];

  // Get current statusBarStyle
  self.statusBarStyle = [[UIApplication sharedApplication] statusBarStyle];

  // Close button
  if (!self.hideCloseButton) {
//    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
//    close.frame = CGRectMake(self.frame.size.width - 60, 26, 60, 30);
//    [close addTarget:self
//                  action:@selector(close)
//        forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:close];

    switch (self.style) {
    case HAStyleLight: {
//      [close setImage:[UIImage imageNamed:@"btn-close"]
//             forState:UIControlStateNormal];
      [[UIApplication sharedApplication]
          setStatusBarStyle:UIStatusBarStyleLightContent];
      break;
    }
    case HAStyleBlack: {
       [[UIApplication sharedApplication]
          setStatusBarStyle:UIStatusBarStyleDefault];
      break;
    }
    }
  }

  // Animation
  CATransition *viewIn = [CATransition animation];
  [viewIn setDuration:0.4];
  [viewIn setType:kCATransitionReveal];
  [viewIn
      setTimingFunction:[CAMediaTimingFunction
                            functionWithName:kCAMediaTimingFunctionEaseOut]];
  [[self layer] addAnimation:viewIn forKey:kCATransitionReveal];

  [[[window subviews] objectAtIndex:0] addSubview:self];
}

#pragma mark - Close Transparent View

- (void)close {
  // Animation
    [self setHidden:YES];
  CATransition *viewOut = [CATransition animation];
  [viewOut setDuration:0.3];
  [viewOut setType:kCATransitionFade];
  [viewOut setTimingFunction:
               [CAMediaTimingFunction
                   functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  [[self.superview layer] addAnimation:viewOut forKey:kCATransitionFade];

  [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle];
  [self removeFromSuperview];

  [self.delegate HATransparentViewDidClosed];
}

//#pragma mark - UITapGestureRecognizer

//- (void)addTapGestureRecognizer {
//  UITapGestureRecognizer *tapGesture =
//      [[UITapGestureRecognizer alloc] initWithTarget:self
//                                              action:@selector(close:)];
//  [self addGestureRecognizer:tapGesture];
//}

//- (void)close:(UITapGestureRecognizer *)sender {
//  [self close];
//}

@end