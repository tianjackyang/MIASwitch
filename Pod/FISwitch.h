//
//  FISwitch.h
//  e-friends
//
//  Created by janven on 16/2/5.
//  Copyright © 2016年 上海帜讯信息技术股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FISwitch : UIControl

@property (nonatomic, assign, getter = isOn) BOOL on;

@property (nonatomic, strong) UIColor *onTintColor;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *thumbTintColor;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont  *textFont;
@property (nonatomic, strong) UIColor *onTextColor;
@property (nonatomic, strong) UIFont  *onTextFont;
@property (nonatomic, strong) UIColor *thumbTextColor;
@property (nonatomic, strong) UIFont  *thumbTextFont;
@property (nonatomic, strong) NSString *onText;
@property (nonatomic, strong) NSString *offText;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end