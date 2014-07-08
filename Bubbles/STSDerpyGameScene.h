//
//  STSDerpyGameScene.h
//  Bubbles
//
//  Created by Sophia Anopa on 7/8/14.
//  Copyright (c) 2014 STS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface STSDerpyGameScene : SKScene
@property (nonatomic) NSMutableArray *circles;
@property (nonatomic) SKSpriteNode *playerCircle;
@property int points;
//@property (nonatomic) NSTimer *timer;
@property (nonatomic, strong) UILabel *scoreLabel;
@end
