//
//  FISwitch.m
//  e-friends
//
//  Created by janven on 16/2/5.
//  Copyright © 2016年 上海帜讯信息技术股份有限公司. All rights reserved.
//

#import "FISwitch.h"
#import "MIADefine.h"

#define ZJSwitchMaxHeight 32.0f
#define ZJSwitchMinHeight 31.0f

#define ZJSwitchMinWidth 51.0f

#define ZJSwitchKnobSize 29.0f

@interface FISwitch ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *onContentView;
@property (nonatomic, strong) UIView *offContentView;
@property (nonatomic, strong) UIView *knobView;
@property (nonatomic, strong) UILabel *onLabel;
@property (nonatomic, strong) UILabel *offLabel;
@property (nonatomic, strong) UILabel *thumbLabel;

- (void)commonInit;

- (CGRect)roundRect:(CGRect)frameOrBounds;

- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer;

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)recognizer;

@end

@implementation FISwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[self roundRect:frame]];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:[self roundRect:bounds]];
    
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:[self roundRect:frame]];
    
    [self setNeedsLayout];
}

- (void)setOnText:(NSString *)onText
{
    if (_onText != onText) {
        _onText = onText;
        
        _onLabel.text = onText;
    }
}

- (void)setOnTextColor:(UIColor *)onTextColor {
    [_onLabel setTextColor:onTextColor];
}

- (void)setOnTextFont:(UIFont *)onTextFont {
    [_onLabel setFont:onTextFont];
}

- (void)setTextColor:(UIColor *)textColor {
    [_offLabel setTextColor:textColor];
}

-(void)setTextFont:(UIFont *)textFont {
    [_offLabel setFont:textFont];
}

- (void)setThumbTextFont:(UIFont *)thumbTextFont {
    [_thumbLabel setFont:thumbTextFont];
}

-(void)setThumbTextColor:(UIColor *)thumbTextColor {
    [_thumbLabel setTextColor:thumbTextColor];
}

- (void)setOffText:(NSString *)offText
{
    if (_offText != offText) {
        _offText = offText;
        
        _offLabel.text = offText;
    }
}

- (void)setOnTintColor:(UIColor *)onTintColor
{
    if (_onTintColor != onTintColor) {
        _onTintColor = onTintColor;
        
        _onContentView.backgroundColor = onTintColor;
    }
}

- (void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
        
        _offContentView.backgroundColor = tintColor;
    }
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor
{
    if (_thumbTintColor != thumbTintColor) {
        _thumbTintColor = thumbTintColor;
        
        _knobView.backgroundColor = _thumbTintColor;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.containerView.frame = self.bounds;
    
    CGFloat r = CGRectGetHeight(self.containerView.bounds) / 2.0;
    
    self.containerView.layer.cornerRadius = r;
    self.containerView.layer.masksToBounds = YES;
    
    CGFloat margin = (CGRectGetHeight(self.bounds) - ZJSwitchKnobSize) / 2.0;
    
    if (!self.isOn) {
        // frame of off status
        self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(0,
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(margin,
                                         margin,
                                         ZJSwitchKnobSize,
                                         ZJSwitchKnobSize);
    } else {
        // frame of on status
        self.onContentView.frame = CGRectMake(0,
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - ZJSwitchKnobSize,
                                         margin,
                                         ZJSwitchKnobSize,
                                         ZJSwitchKnobSize);
    }
    
    CGFloat lHeight = 20.0f;
    CGFloat lMargin = r - (sqrtf(powf(r, 2) - powf(lHeight / 2.0, 2))) + margin;
    
    self.onLabel.frame = CGRectMake(lMargin,
                                    r - lHeight / 2.0,
                                    CGRectGetWidth(self.onContentView.bounds) - lMargin - ZJSwitchKnobSize - 2 * margin,
                                    lHeight);
    
    self.offLabel.frame = CGRectMake(ZJSwitchKnobSize + 2 * margin,
                                     r - lHeight / 2.0,
                                     CGRectGetWidth(self.onContentView.bounds) - lMargin - ZJSwitchKnobSize - 2 * margin,
                                     lHeight);
    
    self.thumbLabel.frame = CGRectMake(0, 0, ZJSwitchKnobSize, ZJSwitchKnobSize);
}

- (void)setOn:(BOOL)on
{
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    /*if (_on == on) {
        return;
    }*/
    
    _on = on;
    
    CGFloat margin = (CGRectGetHeight(self.bounds) - ZJSwitchKnobSize) / 2.0;
    
    if (!animated) {
        if (!self.isOn) {
            // frame of off status
            self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                                  0,
                                                  CGRectGetWidth(self.containerView.bounds),
                                                  CGRectGetHeight(self.containerView.bounds));
            
            self.offContentView.frame = CGRectMake(0,
                                                   0,
                                                   CGRectGetWidth(self.containerView.bounds),
                                                   CGRectGetHeight(self.containerView.bounds));
            
            self.knobView.frame = CGRectMake(margin,
                                             margin,
                                             ZJSwitchKnobSize,
                                             ZJSwitchKnobSize);
            [_thumbLabel setText:_offText];
            [_onLabel setText:_onText];
            [_offLabel setText:_onText];
        } else {
            // frame of on status
            self.onContentView.frame = CGRectMake(0,
                                                  0,
                                                  CGRectGetWidth(self.containerView.bounds),
                                                  CGRectGetHeight(self.containerView.bounds));
            
            self.offContentView.frame = CGRectMake(0,
                                                   CGRectGetWidth(self.containerView.bounds),
                                                   CGRectGetWidth(self.containerView.bounds),
                                                   CGRectGetHeight(self.containerView.bounds));
            
            self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - ZJSwitchKnobSize,
                                             margin,
                                             ZJSwitchKnobSize,
                                             ZJSwitchKnobSize);
            
            [_thumbLabel setText:_onText];
            [_offLabel setText:_offText];
            [_onLabel setText:_offText];
        }
    } else {
        if (self.isOn) {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - ZJSwitchKnobSize,
                                                                  margin,
                                                                  ZJSwitchKnobSize,
                                                                  ZJSwitchKnobSize);
                             }
                             completion:^(BOOL finished){
                                 self.onContentView.frame = CGRectMake(0,
                                                                       0,
                                                                       CGRectGetWidth(self.containerView.bounds),
                                                                       CGRectGetHeight(self.containerView.bounds));
                                 
                                 self.offContentView.frame = CGRectMake(0,
                                                                        CGRectGetWidth(self.containerView.bounds),
                                                                        CGRectGetWidth(self.containerView.bounds),
                                                                        CGRectGetHeight(self.containerView.bounds));
                             }];
            [_thumbLabel setText:_onText];
            [_offLabel setText:_offText];
            [_onLabel setText:_offText];

        } else {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.knobView.frame = CGRectMake(margin,
                                                                  margin,
                                                                  ZJSwitchKnobSize,
                                                                  ZJSwitchKnobSize);
                             }
                             completion:^(BOOL finished){
                                 self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                                                       0,
                                                                       CGRectGetWidth(self.containerView.bounds),
                                                                       CGRectGetHeight(self.containerView.bounds));
                                 
                                 self.offContentView.frame = CGRectMake(0,
                                                                        0,
                                                                        CGRectGetWidth(self.containerView.bounds),
                                                                        CGRectGetHeight(self.containerView.bounds));
                             }];
            [_thumbLabel setText:_offText];
            [_onLabel setText:_onText];
            [_offLabel setText:_onText];
        }
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - Private API

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    
    _onTintColor = [UIColor colorWithRed:130 / 255.0 green:200 / 255.0 blue:90 / 255.0 alpha:1.0];
    _tintColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    _thumbTintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    
    _textFont = [UIFont systemFontOfSize:autoFontSizeScale(10)];
    _textColor = [UIColor whiteColor];
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    _containerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_containerView];
    
    _onContentView = [[UIView alloc] initWithFrame:self.bounds];
    _onContentView.backgroundColor = _onTintColor;
    [_containerView addSubview:_onContentView];
    
    _offContentView = [[UIView alloc] initWithFrame:self.bounds];
    _offContentView.backgroundColor = _tintColor;
    [_containerView addSubview:_offContentView];
    
    _knobView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJSwitchKnobSize, ZJSwitchKnobSize)];
    _knobView.backgroundColor = _thumbTintColor;
    _knobView.layer.cornerRadius = ZJSwitchKnobSize / 2.0;
    [_containerView addSubview:_knobView];
    
    _onLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _onLabel.backgroundColor = [UIColor clearColor];
    _onLabel.textAlignment = NSTextAlignmentCenter;
    _onLabel.textColor = _textColor;
    _onLabel.font = _textFont;
    _onLabel.text = _onText;
    [_onContentView addSubview:_onLabel];
    
    _offLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _offLabel.backgroundColor = [UIColor clearColor];
    _offLabel.textAlignment = NSTextAlignmentCenter;
    _offLabel.textColor = _textColor;
    _offLabel.font = _textFont;
    _offLabel.text = _offText;
    [_offContentView addSubview:_offLabel];
    
    _thumbLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _thumbLabel.backgroundColor = [UIColor clearColor];
    _thumbLabel.textAlignment = NSTextAlignmentCenter;
    _thumbLabel.textColor = _thumbTextColor;
    _thumbLabel.font = _thumbTextFont;
    [_knobView addSubview:_thumbLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTapTapGestureRecognizerEvent:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePanGestureRecognizerEvent:)];
    [self addGestureRecognizer:panGesture];
}

- (CGRect)roundRect:(CGRect)frameOrBounds
{
    CGRect newRect = frameOrBounds;
    
    if (newRect.size.height > ZJSwitchMaxHeight) {
        newRect.size.height = ZJSwitchMaxHeight;
    }
    
    if (newRect.size.height < ZJSwitchMinHeight) {
        newRect.size.height = ZJSwitchMinHeight;
    }
    
    if (newRect.size.width < ZJSwitchMinWidth) {
        newRect.size.width = ZJSwitchMinWidth;
    }
    
    return newRect;
}

- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self setOn:!self.isOn animated:NO];
    }
}

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)recognizer
{
    CGFloat margin = (CGRectGetHeight(self.bounds) - ZJSwitchKnobSize) / 2.0;
    CGFloat offset = 6.0f;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            if (!self.isOn) {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.knobView.frame = CGRectMake(margin,
                                                                      margin,
                                                                      ZJSwitchKnobSize + offset,
                                                                      ZJSwitchKnobSize);
                                 }];
            } else {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - (ZJSwitchKnobSize + offset),
                                                                      margin,
                                                                      ZJSwitchKnobSize + offset,
                                                                      ZJSwitchKnobSize);
                                 }];
            }
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            if (!self.isOn) {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.knobView.frame = CGRectMake(margin,
                                                                      margin,
                                                                      ZJSwitchKnobSize,
                                                                      ZJSwitchKnobSize);
                                 }];
            } else {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - ZJSwitchKnobSize,
                                                                      margin,
                                                                      ZJSwitchKnobSize,
                                                                      ZJSwitchKnobSize);
                                 }];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            break;
        }
        case UIGestureRecognizerStateEnded:
            [self setOn:!self.isOn animated:YES];
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}

@end
