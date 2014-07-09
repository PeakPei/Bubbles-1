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
    
    //TITLE
    [self addChild:[self newTitleNode]];
}

- (SKSpriteNode *)newTitleNode
{
    
    SKLabelNode *titleNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Bold"];
    titleNode.fontColor = [UIColor colorWithRed:131/255.0 green:159/255.0 blue:203/255.0 alpha:0.9];
    titleNode.text = @"Bubbles";
    titleNode.fontSize = 50;
    titleNode.position = CGPointMake(self.frame.size.width * 1/2, self.frame.size.height * 5/7);

    
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:59/255.0 green:89/255.0 blue:152/255.0 alpha:1.0] size:CGSizeMake(titleNode.frame.size.width + 20, titleNode.frame.size.height + 80)];
    [bg initWithImageNamed:[NSString stringWithFormat:@"bubbles.png"]];
    bg.size = CGSizeMake(titleNode.frame.size.width + 20, titleNode.frame.size.height +80);
    bg.position = titleNode.position;
    titleNode.position = CGPointMake((bg.frame.size.width - titleNode.frame.size.width)/2 - 10, -(bg.frame.size.height - titleNode.frame.size.height)/2);
    [bg addChild:titleNode];
    bg.name = @"titleNode";
    
    //Floating effect
    titleNode.physicsBody.dynamic = YES;
    SKAction *moveUp = [SKAction moveTo:CGPointMake(titleNode.position.x, titleNode.position.y-5)
                               duration:1.0];
    SKAction *moveDown = [SKAction moveTo:CGPointMake(titleNode.position.x, titleNode.position.y+40)
                                 duration:1.0];
    SKAction *move = [SKAction sequence:@[moveUp, moveDown]];
    move = [SKAction repeatActionForever:move];
    [titleNode runAction:move];
    
    
    
    return bg;

}

- (SKSpriteNode *)newGameNode
{
    /*SKLabelNode *gameNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text = @"Hello, World!";
    helloNode.fontSize = 42;
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    helloNode.name = @"helloNode";
    return helloNode; */
    SKLabelNode *gameNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Bold"];
    gameNode.text = @"Normal Game";
    gameNode.fontColor = [SKColor whiteColor];
    gameNode.fontSize = 20;
    gameNode.position = CGPointMake(self.frame.size.width * 1/2, self.frame.size.height * 2/5);
//    gameNode.name = @"gameNode";
    
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:59/255.0 green:89/255.0 blue:152/255.0 alpha:1.0] size:CGSizeMake(gameNode.frame.size.width+20, gameNode.frame.size.height+20)];
    bg.position = gameNode.position;
    gameNode.position = CGPointMake((bg.frame.size.width-gameNode.frame.size.width)/2 - 10, -(bg.frame.size.height - gameNode.frame.size.height)/2);
    [bg addChild:gameNode];
    bg.name = @"gameNode";
    return bg;
    
    
}

-(SKSpriteNode *)newDerpyNode
{
    SKLabelNode *derpyNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Bold"];
    derpyNode.fontColor = [SKColor whiteColor];
    derpyNode.text = @"Abnormal/Derpy Game";
    derpyNode.fontSize = 20;
    derpyNode.position = CGPointMake(self.frame.size.width * 1/2, self.frame.size.height * 1/4);
//    derpyNode.name = @"derpyNode";
    
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:59/255.0 green:89/255.0 blue:152/255.0 alpha:1.0] size:CGSizeMake(derpyNode.frame.size.width + 20, derpyNode.frame.size.height +20)];
    [bg initWithImageNamed:[NSString stringWithFormat:@"rainbow.png"]];
    bg.size = CGSizeMake(derpyNode.frame.size.width + 20, derpyNode.frame.size.height +20);
    bg.position = derpyNode.position;
    derpyNode.position = CGPointMake((bg.frame.size.width - derpyNode.frame.size.width)/2 - 10, -(bg.frame.size.height - derpyNode.frame.size.height)/2);
    [bg addChild:derpyNode];
    bg.name = @"derpyNode";
    
    

    return bg;
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
