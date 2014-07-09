//
//  HelloScene.m
//  SpriteWalkthrough
//
//  Created by Sophia Anopa on 7/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "STSHelloScene.h"
#import "STSGameScene.h"
#import "STSDerpyGameScene.h"

@interface STSHelloScene ()
@property BOOL contentCreated;
@end

@implementation STSHelloScene
- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor whiteColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild:[self newGameNode]];
    [self addChild:[self newDerpyNode]];
}

- (SKLabelNode *)newGameNode
{
    /*SKLabelNode *gameNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text = @"Hello, World!";
    helloNode.fontSize = 42;
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    helloNode.name = @"helloNode";
    return helloNode; */
    SKLabelNode *gameNode = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    gameNode.text = @"Normal Game";
    gameNode.fontColor = [SKColor grayColor];
    gameNode.fontSize = 20;
    gameNode.position = CGPointMake(self.frame.size.width * 1/2, self.frame.size.height * 2/3);
    gameNode.name = @"gameNode";
    return gameNode;
    
    
}

-(SKLabelNode *)newDerpyNode
{
    SKLabelNode *derpyNode = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    derpyNode.fontColor = [SKColor grayColor];
    derpyNode.text = @"Abnormal/Derpy Game";
    derpyNode.fontSize = 20;
    derpyNode.position = CGPointMake(self.frame.size.width * 1/2, self.frame.size.height * 1/3);
    derpyNode.name = @"derpyNode";
    return derpyNode;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKNode *gameNode = [self childNodeWithName:@"gameNode"];
    SKNode *derpyNode = [self childNodeWithName:@"derpyNode"];
    //if (helloNode != nil) {
       /* helloNode.name = nil;
        SKAction *moveUp = [SKAction moveByX:0 y:100.0 duration:0.5];
        SKAction *zoom = [SKAction scaleTo:2.0 duration:0.25];
        SKAction *pause = [SKAction waitForDuration:0.5];
        SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence:@[moveUp, zoom, pause, fadeAway, remove]];
        [helloNode runAction:moveSequence
                  completion:^{
                      SKScene *spaceshipScene = [[SpaceshipScene alloc] initWithSize:self.size];
                      SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
                      [self.view presentScene:spaceshipScene transition:doors];
                  }];
    
    }*/
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    location.y = self.view.frame.size.height - location.y;
    NSArray *nodes = [self nodesAtPoint:location];
    for (SKSpriteNode *node in nodes)
    {
        if ([gameNode isEqual:node])
        {
            //Go to game scene
            NSLog(@"Clicked normal game");
            [self.parentViewController showNormalGame];
        }
        else if ([derpyNode isEqual:node])
        {
            //Go to derpy scene
            NSLog(@"Clicked derpy game");
            [self.parentViewController showDerpyGame];
        }
    }

}
@end
