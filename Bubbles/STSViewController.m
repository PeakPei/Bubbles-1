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

@interface STSViewController ()

@end

@implementation STSViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SKView *spriteView = (SKView *)self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    STSGameScene *game = [[STSGameScene alloc] initWithSize:self.view.frame.size];
    SKView *spriteView = (SKView *)self.view;
    [spriteView presentScene:game];
}
@end
