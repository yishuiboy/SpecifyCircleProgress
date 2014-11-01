//
//  CircularProgressView.h
//  CircularProgressView
//
//  Created by wangzzh on 14/11/1.
//  Copyright (c) 2014年 wangzzh. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol CircularProgressViewDelegate <NSObject>

@optional

- (void)updateProgressView:(NSString*)progressStr;
- (void)progressDidFinish;

@end

@interface CircularProgressView : UIView

@property (nonatomic,retain) UIColor *backColor;
@property (nonatomic,retain) UIColor *progressColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) NSTimeInterval duration;
@property (assign, nonatomic) BOOL playOrPauseButtonIsPlaying;
@property (assign, nonatomic) id <CircularProgressViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth
          audioPath:(NSString *)path;

- (void)play;

@end