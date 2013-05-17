//
//  HRMainViewController.m
//  Home Remote
//
//  Created by Wouter Verweirder on 17/05/13.
//  Copyright (c) 2013 aboutme. All rights reserved.
//

#import "HRMainViewController.h"
#import "HRMainView.h"

@interface HRMainViewController ()

@end

@implementation HRMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view = [[HRMainView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
