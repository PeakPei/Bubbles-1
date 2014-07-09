//
//  STSNavigationViewController.m
//  Bubbles
//
//  Created by Sophia Anopa on 7/8/14.
//  Copyright (c) 2014 STS. All rights reserved.
//

#import "STSNavigationViewController.h"
#import "STSHelloScene.h"
#import "STSDerpyViewController.h"
#import "STSViewController.h"

@interface STSNavigationViewController ()

@end

@implementation STSNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view = [[SKView alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SKView *spriteView = (SKView *)self.view;
//    spriteView.showsDrawCount = YES;
//    spriteView.showsNodeCount = YES;
//    spriteView.showsFPS = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    STSHelloScene *hello = [[STSHelloScene alloc] initWithSize:self.view.frame.size];
    hello.parentViewController = self;
    SKView *spriteView = (SKView *)self.view;
    [spriteView presentScene:hello];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showNormalGame
{
    STSViewController *normal = [[STSViewController alloc] init];
    [self.navigationController pushViewController:normal
                                         animated:YES];
}

- (void)showDerpyGame
{
    STSDerpyViewController *derpy = [[STSDerpyViewController alloc] init];
    [self.navigationController pushViewController:derpy
                                         animated:YES];
}
@end
