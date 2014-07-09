//
//  STSViewController.m
//  Bubbles
//
//  Created by Sophia Anopa on 7/8/14.
//  Copyright (c) 2014 STS. All rights reserved.
//

#import "STSViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "STSGameScene.h"

@interface STSViewController () <UIAlertViewDelegate>
@property (nonatomic, strong) STSGameScene *game;
@property float period;
@property (nonatomic, strong) NSTimer *displayTimer;
@property (nonatomic, strong) NSDate *pauseStart;
@property (nonatomic, strong) NSDate *previousFireDate;
@end

@implementation STSViewController
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    SKView *spriteView = (SKView *)self.view;
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view = [[SKView alloc] init];
       // self.tabBarItem.title = @"Standard";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.game) {
        self.game = [[STSGameScene alloc] initWithSize:self.view.frame.size];
        SKView *spriteView = (SKView *)self.view;
        [spriteView presentScene:self.game];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(gameOver:) userInfo:nil repeats:NO];
        self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 71, 300, 21)];
        
        //TIMER LABEL
        self.period = 30;
        self.displayTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                 target:self
                                                               selector:@selector(updateTime:)
                                                               userInfo:nil
                                                                repeats:YES];
        NSDate *myTimerDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(NSTimeInterval)self.period];
        NSTimeInterval timeLeft = [myTimerDate timeIntervalSinceNow];
        self.timerLabel.text = [NSString stringWithFormat:@"Time left: %.2f", timeLeft];
        [self.view addSubview:self.timerLabel];
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }

}

- (void)gameOver:(id)sender
{
    [self.displayTimer invalidate];
    self.displayTimer = nil;
    self.timer = nil;
    NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"];
    UIAlertView *alert;
    if (self.game.points > highScore)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:self.game.points forKey:@"highScore"];
        alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message:[NSString stringWithFormat:@"New High Score: %d!", self.game.points]
                                                       delegate:self
                                              cancelButtonTitle:@"Play Again"
                                              otherButtonTitles:@"Exit", nil];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message:[NSString stringWithFormat:@"Points: %d", self.game.points]
                                                       delegate:self
                                              cancelButtonTitle:@"Play Again"
                                              otherButtonTitles:@"Exit", nil];
    }
    [self.game.scoreLabel removeFromSuperview];
    [self.timerLabel removeFromSuperview];
    [self.game.highScoreLabel removeFromSuperview];


    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self.game removeFromParent];
        self.game = nil;
        [self viewWillAppear:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
//     self.game = [[STSGameScene alloc] initWithSize:self.view.frame.size];
//    SKView *spriteView = (SKView *)self.view;
//    [spriteView presentScene:self.game];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(gameOver:) userInfo:nil repeats:NO];
//    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 31, 300, 21)];
//    
//    //TIMER LABEL
//    self.period = 30;
//    self.displayTimer = [NSTimer scheduledTimerWithTimeInterval:1
//                                                             target:self
//                                                           selector:@selector(updateTime:)
//                                                           userInfo:nil
//                                                            repeats:YES];
//    NSDate *myTimerDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(NSTimeInterval)self.period];
//    NSTimeInterval timeLeft = [myTimerDate timeIntervalSinceNow];
//    self.timerLabel.text = [NSString stringWithFormat:@"Time left: %.2f", timeLeft];
//    
//    [self.view addSubview:self.timerLabel];
    
}

- (void)updateTime:(id)sender
{
    self.period--;
    NSDate *myTimerDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(NSTimeInterval)self.period];
    NSTimeInterval timeLeft = [myTimerDate timeIntervalSinceNow];
    self.timerLabel.text = [NSString stringWithFormat:@"Time left: %.2f", timeLeft];
    //[self.view addSubview:self.timerLabel];
}

- (void) viewDidDisappear:(BOOL)animated
{

    [self.timer invalidate];
    [self.displayTimer invalidate];
}



@end
