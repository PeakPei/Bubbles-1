//
//  STSDerpyViewController.h
//  Bubbles
//
//  Created by Sophia Anopa on 7/8/14.
//  Copyright (c) 2014 STS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STSDerpyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITabBarItem *standardTab;

@property (nonatomic) NSTimer *timer;
@property (nonatomic) UILabel *timerLabel;
@end
