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
@end

@implementation STSViewController
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    SKView *spriteView = (SKView *)self.view;
//}

- (void)viewWillAppear:(BOOL)animated
{
    self.game = [[STSGameScene alloc] initWithSize:self.view.frame.size];
    SKView *spriteView = (SKView *)self.view;
    spriteView.showsNodeCount = YES;
    [spriteView presentScene:self.game];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(gameOver:) userInfo:nil repeats:NO];
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 31, 300, 21)];
    
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

}

- (void)gameOver:(id)sender
{
    [self.displayTimer invalidate];
    self.displayTimer = nil;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                    message:[NSString stringWithFormat:@"Points: %d", self.game.points]
                                                   delegate:self
                                          cancelButtonTitle:@"Play Again"
                                          otherButtonTitles:nil];
    [self.game.scoreLabel removeFromSuperview];
    [self.timerLabel removeFromSuperview];

    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.game removeFromParent];
     self.game = [[STSGameScene alloc] initWithSize:self.view.frame.size];
    SKView *spriteView = (SKView *)self.view;
    [spriteView presentScene:self.game];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(gameOver:) userInfo:nil repeats:NO];
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 31, 300, 21)];
    
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

}

- (void)updateTime:(id)sender
{
    self.period--;
    NSDate *myTimerDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(NSTimeInterval)self.period];
    NSTimeInterval timeLeft = [myTimerDate timeIntervalSinceNow];
    self.timerLabel.text = [NSString stringWithFormat:@"Time left: %.2f", timeLeft];
    //[self.view addSubview:self.timerLabel];
}
@end
