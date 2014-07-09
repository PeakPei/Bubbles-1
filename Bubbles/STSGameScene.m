//
//  STSGameScene.m
//  Bubbles
//
//  Created by Sophia Anopa on 7/8/14.
//  Copyright (c) 2014 STS. All rights reserved.
//

#import "STSGameScene.h"

@interface STSGameScene () <SKPhysicsContactDelegate>
@property BOOL contentCreated;
@property BOOL circleSelected;
@property NSArray *circleImages;
typedef enum  {
    STSCircleColorRed = 1 ,
    STSCircleColorYellow = 0,
    STSCircleColorBlue = 2,
    STSCircleColorOrange = 3,
    STSCircleColorGreen = 4,
    STSCircleColorPurple = 5
}STSCircleColors;


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
        
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 71, 100, 21)];
        self.scoreLabel.text = [NSString stringWithFormat:@"Points: %d", self.points];
        [self.view addSubview:self.scoreLabel];
    }
}

- (void)createSceneContents
{

    self.circleImages = [[NSArray alloc] initWithObjects:@"playerCircleYellow.png", @"playerCircleRed.png", @"playerCircle.png", @"playerCircleOrange.png", @"playerCircleGreen.png", @"playerCirclePurple.png", nil];
    self.backgroundColor = [SKColor whiteColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    //PLAYER CIRCLE
    [self makePlayer];
//    int color = (arc4random() % 3);
//    self.playerCircle = [SKSpriteNode spriteNodeWithImageNamed:self.circleImages[color]];
//    self.playerCircle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:30];
//    self.playerCircle.size = CGSizeMake(60, 60);
//    self.playerCircle.physicsBody.dynamic = YES;
//    self.playerCircle.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
//    self.playerCircle.physicsBody.categoryBitMask = color+3;
//    self.playerCircle.physicsBody.contactTestBitMask = 10;
    
    self.physicsWorld.gravity = CGVectorMake(0.0,0.0);
    self.physicsWorld.contactDelegate = self;
    CGRect smallFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-60);
    //NSLog(@"%f, %f", smallFrame.size.height, self.frame.size.height);
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:smallFrame];

//    [self addChild:self.playerCircle];
//    
    //OTHER CIRCLES
    self.circles = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:self.circleImages[i]];
        node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:40];
        node.physicsBody.mass *= 2;
        node.size = CGSizeMake(80, 80);
        float x = arc4random() % (int)self.frame.size.width;
        float y = (arc4random() % (int)smallFrame.size.height);
        node.position = CGPointMake(x, y);
        node.physicsBody.categoryBitMask = i;
        node.physicsBody.contactTestBitMask = i+15;
        [self.circles addObject:node];
        [self addChild:node];
    }
    
}

- (void)makePlayer
{
    int color = (arc4random() % 6);
    self.playerCircle = [SKSpriteNode spriteNodeWithImageNamed:self.circleImages[color]];
    self.playerCircle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:10];
    self.playerCircle.size = CGSizeMake(60, 60);
    self.playerCircle.physicsBody.dynamic = YES;
    self.playerCircle.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    self.playerCircle.physicsBody.categoryBitMask = color+6;
    self.playerCircle.physicsBody.contactTestBitMask = 15;
    self.playerCircle.name = @"playerCircle";
    [self addChild:self.playerCircle];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    //self.circleSelected = NO;
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    location.y = self.view.frame.size.height - location.y;
    NSArray *nodes = [self nodesAtPoint:location];
    for (SKSpriteNode *node in nodes)
    {
        if ([self.playerCircle isEqual:node])
        {
            [self.playerCircle removeAllActions];
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
            CGPoint newPos = CGPointMake(self.view.bounds.size.width /2, gr.view.center.y + move.y);
            
            if(newPos.y <= self.frame.size.height-60  && newPos.y > 0 && newPos.x <= self.frame.size.width && newPos.x > 0)
            {
                SKAction *moveAction = [SKAction moveByX:move.x
                                                       y:-move.y
                                                duration:0];
                [self.playerCircle runAction:moveAction];
                [gr setTranslation:CGPointMake(0, 0)
                            inView:self.view];
            }
            
        }
        
        if(gr.state == UIGestureRecognizerStateEnded)
        {
            CGPoint velocity = [gr velocityInView:self.view];
            CGPoint move = [gr translationInView:self.view];
            CGPoint newPos = CGPointMake(self.view.bounds.size.width /2, gr.view.center.y + move.y);
            NSLog(@"Velocity: %f, %f", velocity.x, velocity.y);
            if(newPos.y <= self.frame.size.height-60  && newPos.y > 0 && newPos.x <= self.frame.size.width && newPos.x > 0 && hypot(abs(velocity.x),abs(velocity.y)) > 200)
            {
                

                velocity = [self convertPointFromView:velocity];
                
                [self.playerCircle.physicsBody applyForce:CGVectorMake(velocity.x*0.5, velocity.y*0.5)];
                self.circleSelected = NO;
            }
            
        }
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
           // NSLog(@"contact between some circles");
    if ([firstBody isEqual:self.playerCircle.physicsBody] || [secondBody isEqual:self.playerCircle.physicsBody])
    {
        if (MAX(firstBody.categoryBitMask, secondBody.categoryBitMask) == MIN(firstBody.categoryBitMask, secondBody.categoryBitMask) + 6)
        {
            //NSLog(@"Contact between same colours");
            self.points++;
            //NSLog(@"Won points: %d", self.points);
            int color = (arc4random() % 6);
            self.playerCircle.texture = [SKTexture textureWithImageNamed:self.circleImages[color]];
            self.playerCircle.physicsBody.categoryBitMask = color+6;
            self.playerCircle.physicsBody.contactTestBitMask = 15;
            self.scoreLabel.text = [NSString stringWithFormat:@"Points: %d", self.points];
           // [self makePlayer];
            
        }
        else{
            if (firstBody.categoryBitMask != -1 && secondBody.categoryBitMask != -1)
            {
                //NSLog(@"%d, %d", firstBody.categoryBitMask, secondBody.categoryBitMask);
                //NSLog(@"Diff colours");
                self.points--;
                //NSLog(@"Lost points: %d", self.points);
                self.scoreLabel.text = [NSString stringWithFormat:@"Points: %d", self.points];
            }
        }
    }
    /*if ([secondBody isEqual:self.playerCircle.physicsBody])
    {
        if (secondBody.categoryBitMask == firstBody
            .categoryBitMask + 3)
        {
            NSLog(@"Contact between same colours");
        }
        else{
            NSLog(@"Diff colours");
        }
    }*/
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    //NSLog(@"contact ended");
}
@end
