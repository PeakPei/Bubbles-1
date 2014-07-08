//
//  STSGameScene.m
//  Bubbles
//
//  Created by Sophia Anopa on 7/8/14.
//  Copyright (c) 2014 STS. All rights reserved.
//

#import "STSGameScene.h"

@interface STSGameScene ()
@property BOOL contentCreated;
@end

@implementation STSGameScene
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
    self.playerCircle = [SKSpriteNode spriteNodeWithImageNamed:@"playerCircle.png"];
    self.playerCircle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:30];
    self.playerCircle.size = CGSizeMake(60, 60);
    self.playerCircle.physicsBody.dynamic = YES;
    self.playerCircle.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    self.physicsWorld.gravity = CGVectorMake(0.0,0.0);
    [self addChild:self.playerCircle];
    
}
@end
