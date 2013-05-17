//
//  HRMainView.h
//  Home Remote
//
//  Created by Wouter Verweirder on 17/05/13.
//  Copyright (c) 2013 aboutme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncUdpSocket.h"

@interface HRMainView : UIView

@property (nonatomic, strong) GCDAsyncUdpSocket *udpSocket;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic) NSInteger port;

@property (nonatomic, strong) UIButton *allOnButton;
@property (nonatomic, strong) UIButton *allOffButton;

@property (nonatomic, strong) UIButton *samsungOnOffButton;
@property (nonatomic, strong) UIButton *samsungSourceButton;
@property (nonatomic, strong) UIButton *samsungVolUpButton;
@property (nonatomic, strong) UIButton *samsungVolDownButton;

@property (nonatomic, strong) UIButton *tvOffButton;
@property (nonatomic, strong) UIButton *tvNextButton;
@property (nonatomic, strong) UIButton *tvPreviousButton;

@property (nonatomic, strong) UIButton *belgacomOnOffButton;
@property (nonatomic, strong) UIButton *belgacomNextButton;
@property (nonatomic, strong) UIButton *belgacomPreviousButton;

@end
