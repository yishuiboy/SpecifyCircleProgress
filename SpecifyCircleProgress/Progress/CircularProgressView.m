//
//  CircularProgressView.m
//  CircularProgressView
//
//  Created by wangzzh on 14/11/1.
//  Copyright (c) 2014年 wangzzh. All rights reserved.
//
#import "CircularProgressView.h"

@interface CircularProgressView ()<AVAudioPlayerDelegate>

@property (nonatomic) NSTimer *timer;

@property (assign, nonatomic) float progress;


@end

@implementation CircularProgressView

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth
          audioPath:(NSString *)path {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _backColor = backColor;
        _progressColor = progressColor;
        _lineWidth = lineWidth;
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    
    //draw background circle
    UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2)
                                                              radius:(CGRectGetWidth(self.bounds) - self.lineWidth) / 2
                                                          startAngle:(CGFloat) - M_PI_2
                                                            endAngle:(CGFloat)(1.5 * M_PI)
                                                           clockwise:YES];
    [self.backColor setStroke];
    backCircle.lineWidth = self.lineWidth;
    [backCircle stroke];
    
    if (self.progress) {
        UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2,CGRectGetHeight(self.bounds) / 2)
                                                                      radius:(CGRectGetWidth(self.bounds) - self.lineWidth) / 2
                                                                  startAngle:(CGFloat) - M_PI_2
                                                                    endAngle:(CGFloat)(- M_PI_2 + self.progress * 2 * M_PI)
                                                                   clockwise:YES];
        [self.progressColor setStroke];
        progressCircle.lineWidth = self.lineWidth;
        [progressCircle stroke];
        
        UIBezierPath *progressCircle2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2,CGRectGetHeight(self.bounds) / 2)
                                                                      radius:(CGRectGetWidth(self.bounds) - self.lineWidth-12) / 2
                                                                  startAngle:(CGFloat) - M_PI_2
                                                                    endAngle:(CGFloat)(- M_PI_2 + self.progress * 2 * M_PI)
                                                                   clockwise:YES];
        [[UIColor colorWithRed:203/255.0 green:232/255.0 blue:227/255.0 alpha:1.0] setStroke];
        progressCircle2.lineWidth = 12;
        [progressCircle2 stroke];
        
        
        
        UIBezierPath *inLineCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2)
                                                                    radius:(CGRectGetWidth(self.bounds)/2 - self.lineWidth-1)
                                                                startAngle:(CGFloat) - M_PI_2
                                                                  endAngle:(CGFloat)(1.5 * M_PI)
                                                                 clockwise:YES];
        [self.progressColor setStroke];
        inLineCircle.lineWidth = 1;
        [inLineCircle stroke];
    }
}

- (void)updateProgressCircle{
    self.progress +=0.01 ;
    [self setNeedsDisplay];
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(CircularProgressViewDelegate)]) {
        if (self.progress>=1.0) {
            [self.delegate progressDidFinish];
        }else{
            [self.delegate updateProgressView:[NSString stringWithFormat:@"%.2f",self.progress]];
        }
    }
    
    if (self.progress<=1.0) {
        [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateProgressCircle) userInfo:nil repeats:NO];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_HIDDEN_PROGRESS" object:self userInfo:nil];
    }
}

- (void)play{
    self.progress=0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateProgressCircle) userInfo:nil repeats:NO];
}

//calculate angle between start to point
- (CGFloat)angleFromStartToPoint:(CGPoint)point{
    CGFloat angle = [self angleBetweenLinesWithLine1Start:CGPointMake(CGRectGetWidth(self.bounds) / 2,CGRectGetHeight(self.bounds) / 2) Line1End:CGPointMake(CGRectGetWidth(self.bounds) / 2,CGRectGetHeight(self.bounds) / 2 - 1) Line2Start:CGPointMake(CGRectGetWidth(self.bounds) / 2,CGRectGetHeight(self.bounds) / 2) Line2End:point];
    if (CGRectContainsPoint(CGRectMake(0, 0, CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)), point)) {
        angle = 2 * M_PI - angle;
    }
    return angle;
}
//calculate angle between 2 lines
- (CGFloat)angleBetweenLinesWithLine1Start:(CGPoint)line1Start
                                  Line1End:(CGPoint)line1End
                                Line2Start:(CGPoint)line2Start
                                  Line2End:(CGPoint)line2End{
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    return acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
}
@end
