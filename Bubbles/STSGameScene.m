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
@property BOOL circleSelected;
@end

@implementation STSGameScene
- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
        UIPanGestureRecognizer *gestureRecogniser = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(flicked:)];
        [view addGestureRecognizer:gestureRecogniser];
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
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    [self addChild:self.playerCircle];
    
    //self.playerCircle.userInteractionEnabled = YES;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    //self.circleSelected = NO;
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    location.y = self.view.frame.size.height - location.y;
    NSMutableArray *nodes = [self nodesAtPoint:location];
    for (SKSpriteNode *node in nodes)
    {
        if ([self.playerCircle isEqual:node])
        {
            self.circleSelected = YES;
            NSLog(@"circle selected");
        }
        //[self.playerCircle runAction:[SKAction repeatActionForever:UI]]
    }
}



- (void)flicked:(UIPanGestureRecognizer *)gr
{
    if(self.circleSelected)
    {
        if (gr.state == UIGestureRecognizerStateChanged)
        {
            CGPoint move = [gr translationInView:self.view];
            SKAction *moveAction = [SKAction moveByX:move.x
                                                   y:-move.y
                                            duration:0];
            [self.playerCircle runAction:moveAction];
            [gr setTranslation:CGPointMake(0, 0)
                        inView:self.view];
        }
        
        if(gr.state == UIGestureRecognizerStateEnded)
        {
            CGPoint velocity = [gr velocityInView:self.view];
            velocity = [self convertPointFromView:velocity];
            
            [self.playerCircle.physicsBody applyForce:CGVectorMake(velocity.x, velocity.y)];
            self.circleSelected = NO;
            
        }
    }
}
@end
