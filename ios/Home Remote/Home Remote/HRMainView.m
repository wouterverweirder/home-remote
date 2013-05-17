//
//  HRMainView.m
//  Home Remote
//
//  Created by Wouter Verweirder on 17/05/13.
//  Copyright (c) 2013 aboutme. All rights reserved.
//

#import "HRMainView.h"

@interface HRMainView()

- (UIButton *)addButtonWithTitle:(NSString *)title andYPos:(NSInteger)yPos;
- (void)buttonTapped:(id) sender;

@end

@implementation HRMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.ip = @"192.168.1.177";
        self.port = 8888;
        self.udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        //self.allOnButton = [self addButtonWithTitle:@"All On" andYPos:10];
        //self.allOffButton = [self addButtonWithTitle:@"All Off" andYPos:60];
        
        self.samsungOnOffButton = [self addButtonWithTitle:@"Samsung On/Off" andYPos:10];
        self.samsungVolUpButton = [self addButtonWithTitle:@"Samsung Vol Up" andYPos:60];
        self.samsungVolDownButton = [self addButtonWithTitle:@"Samsung Vol Down" andYPos:110];
        self.samsungSourceButton = [self addButtonWithTitle:@"Samsung Source" andYPos:160];
        
        self.tvOffButton = [self addButtonWithTitle:@"TV Off" andYPos:230];
        self.tvNextButton = [self addButtonWithTitle:@"TV Next" andYPos:280];
        self.tvPreviousButton = [self addButtonWithTitle:@"TV Previous" andYPos:330];
        
        self.belgacomOnOffButton = [self addButtonWithTitle:@"Belgacom On/off" andYPos:400];
        self.belgacomNextButton = [self addButtonWithTitle:@"Belgacom Next" andYPos:450];
        self.belgacomPreviousButton = [self addButtonWithTitle:@"Belgacom Previous" andYPos:500];
    }
    return self;
}

- (UIButton *)addButtonWithTitle:(NSString *)title andYPos:(NSInteger)yPos {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, yPos, self.frame.size.width - 20, 40);
    [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;
}

- (void)buttonTapped:(id)sender
{
    if(sender == self.allOnButton) {
        [self.udpSocket sendData:[@"Samsung;1;1" dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self.udpSocket sendData:[[NSString stringWithFormat:@"RC6;20;%i", 0x10020] dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:1];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self.udpSocket sendData:[[NSString stringWithFormat:@"RCMM;32;%i", 0x22c0260c] dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:2];
        });
    } else if(sender == self.allOffButton) {
        [self.udpSocket sendData:[@"Samsung;1;1" dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:8888 withTimeout:-1 tag:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self.udpSocket sendData:[[NSString stringWithFormat:@"RC6;20;%i", 0x1000C] dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:1];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self.udpSocket sendData:[[NSString stringWithFormat:@"RCMM;32;%i", 0x22c0260c] dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:2];
        });
    } else if(sender == self.samsungOnOffButton) {
        [self.udpSocket sendData:[@"Samsung;1;1" dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
    } else if(sender == self.samsungSourceButton) {
        [self.udpSocket sendData:[@"Samsung;1;2" dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
    } else if(sender == self.samsungVolUpButton) {
        [self.udpSocket sendData:[@"Samsung;1;3" dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
    } else if(sender == self.samsungVolDownButton) {
        [self.udpSocket sendData:[@"Samsung;1;4" dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
    } else if(sender == self.tvOffButton) {
        [self.udpSocket sendData:[[NSString stringWithFormat:@"RC6;20;%i", 0x1000C] dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
    } else if(sender == self.tvNextButton) {
        [self.udpSocket sendData:[[NSString stringWithFormat:@"RC6;20;%i", 0x10020] dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
    } else if(sender == self.tvPreviousButton) {
        [self.udpSocket sendData:[[NSString stringWithFormat:@"RC6;20;%i", 0x10021] dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
    } else if(sender == self.belgacomOnOffButton) {
        [self.udpSocket sendData:[[NSString stringWithFormat:@"RCMM;32;%i", 0x22c0260c] dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
    } else if(sender == self.belgacomNextButton) {
        [self.udpSocket sendData:[[NSString stringWithFormat:@"RCMM;32;%i", 0x22c02620] dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
    } else if(sender == self.belgacomPreviousButton) {
        [self.udpSocket sendData:[[NSString stringWithFormat:@"RCMM;32;%i", 0x22c02621] dataUsingEncoding:NSUTF8StringEncoding] toHost:self.ip port:self.port withTimeout:-1 tag:0];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
