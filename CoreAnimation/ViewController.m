//
//  ViewController.m
//  CoreAnimation
//
//  Created by Jo Tu on 7/19/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) UIDynamicItemBehavior *boardDynamicProperties;
@property (nonatomic) UIDynamicItemBehavior *ballDynamicProperties;
@property (nonatomic) UIPushBehavior *pusher;
@property (nonatomic)UICollisionBehavior *collisionBehavior;
@property (nonatomic) CGPoint paddleCenterPoint;
@property(nonatomic,strong)UIButton *retryButton;
@property (nonatomic) bool retryButtonClicked;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.ball.clipsToBounds = YES;
//

//    self.view.backgroundColor = [UIColor yellowColor];
    

    
    [self loadBoardAndPaddle];
//    [self setRoundedView:(UIImageView*)self.ball toDiameter:50.0];
    // Do any additional setup after loading the view, typically from a nib.
    
//    
//    self.ball = [[UIView alloc] initWithFrame:CGRectMake(100.0, 100.0, 50.0, 50.0)];
//    self.ball.backgroundColor = [UIColor orangeColor];
//    self.ball.layer.cornerRadius = 25.0;
//    self.ball.layer.borderColor = [UIColor blackColor].CGColor;
//    self.ball.layer.borderWidth = 0.0;
//    [self.view addSubview:self.ball];
//    
//    self.board = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 75,
//                                                         self.view.bounds.size.height-20,
//                                                           150.0,
//                                                           30.0)];
//    self.board.backgroundColor = [UIColor greenColor];
//    self.board.layer.cornerRadius = 15.0;
//    self.paddleCenterPoint = self.board.center;
//    [self.view addSubview:self.board];
//    
//    
//     self.retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.retryButton addTarget:self
//                         action:@selector(retryGame)
//     forControlEvents:UIControlEventTouchUpInside];
//    [self.retryButton setTitle:@"Retry" forState:UIControlStateNormal];
//    [self.retryButton setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
//    self.retryButton.frame = CGRectMake(120, 210.0, 160.0, 40.0);
//    [self.view addSubview:self.retryButton];
//    self.retryButton.hidden = YES;
//    
//    // Initialize the animator.
//    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
//    
//    self.pusher = [[UIPushBehavior alloc] initWithItems:@[self.ball]
//                                                   mode:UIPushBehaviorModeInstantaneous];
//    self.pusher.pushDirection = CGVectorMake(1.0,2.5);
//    self.pusher.active = YES;
//    self.pusher.angle =  60.0;


    [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(initAnimation)
                                   userInfo:nil
                                    repeats:NO];
   

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)retryGame{

    self.retryButton.hidden = YES;
    [self loadBoardAndPaddle];
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(initAnimation)
                                   userInfo:nil
                                    repeats:NO];}

//- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
//    
////    UIView *lockInView = [[UIView alloc]initWithFrame:CGRectMake(0, 600,[[UIScreen mainScreen] bounds].size.width,self.board.bounds.size.height)];
////
//    CGPoint pt = [[touches anyObject] locationInView:self.view];
////    pt.y =  725;
//    
//
//    self.board.center = CGPointMake(pt.x,self.view.bounds.size.height-20);
//    
//}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    CGFloat yPoint = self.view.bounds.size.height-20;
    CGPoint paddleCenter = CGPointMake(touchLocation.x, yPoint);
    
    self.board.center = paddleCenter;
    [self.animator updateItemUsingCurrentState:self.board];
}
//
//-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
//{
//    CGPoint saveCenter = roundedView.center;
//    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
//    roundedView.frame = newFrame;
//    roundedView.layer.cornerRadius = newSize / 2.0;
//    roundedView.center = saveCenter;
//}


-(void) initAnimation
{
    
//    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
//    self.pusher = [[UIPushBehavior alloc] initWithItems:@[self.ball]
//                                                   mode:UIPushBehaviorModeInstantaneous];
//    self.pusher.pushDirection = CGVectorMake(0.5,1.0);
//    self.pusher.active = YES;
//    self.pusher.angle =  60.0;
    
    // Because push is instantaneous, it will only happen once
    [self.animator addBehavior:self.pusher];

    
//    UIGravityBehavior *gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[ self.ball]];
//    [animator addBehavior:gravityBeahvior];
    
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ball,self.board]];
    // Creates collision boundaries from the bounds of the dynamic animator's
    // reference view (self.view).
    self.collisionBehavior.collisionDelegate = self;
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collisionBehavior];
    

    self.ballDynamicProperties = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ball]];
    self.ballDynamicProperties.allowsRotation = YES;
    self.ballDynamicProperties.elasticity = 1.0;
    self.ballDynamicProperties.friction = 0.;
    self.ballDynamicProperties.resistance =0.0 ;
    [self.ballDynamicProperties addAngularVelocity:0 forItem:self.ball];
    self.ballDynamicProperties.angularResistance = 0.0;

    [self.animator addBehavior:self.ballDynamicProperties];
    
    self.boardDynamicProperties = [[UIDynamicItemBehavior alloc] initWithItems:@[self.board]];
    self.boardDynamicProperties.allowsRotation = NO;
//    [self.animator addBehavior:self.boardDynamicProperties];
    self.boardDynamicProperties.density = 10000.0f;
    
    
    [self.animator addBehavior:self.boardDynamicProperties];

    
    
//    UIDynamicItemBehavior *elasticityBehavior =
//    [[UIDynamicItemBehavior alloc] initWithItems:@[self.ball]];
//    elasticityBehavior.elasticity =1.0;
//    [animator addBehavior:elasticityBehavior];
    
//    self.animator = animator;

    
}


//
//-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id)item1 withItem:(id)item2 atPoint:(CGPoint)p{
//    NSLog(@"%f",self.ball.frame.origin.y);
//
//    if (item1 == self.ball && item2 == self.board) {
//        UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ball,self.board] mode:UIPushBehaviorModeInstantaneous];
//        pushBehavior.angle = 30.0;
//        pushBehavior.magnitude = 0.75;
//        [self.animator addBehavior:pushBehavior];
//        
//    }
//    


//              [self.animator addBehavior:pushBehavior];
        
//}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item
   withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    NSLog(@"Boundary contact occurred - %@", identifier);
//    NSLog(@"%f",self.view.frame.size.height);
    if(self.ball.frame.origin.y > self.view.frame.size.height-72){
        NSLog(@"floor hit");
        [self.ball removeFromSuperview];
        [self.board removeFromSuperview];
        [self.animator removeAllBehaviors];
//        [self loadLoseScreen];
        self.retryButton.hidden = NO;
//        self.retryButtonClicked = YES;
//        [self.view setNeedsDisplay];
        
    }
    
}


-(void)loadLoseScreen{
    self.retryButton.hidden = NO;

}



////- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//
//    UITouch *touch = [touches anyObject];
//    
//    // If the touch was in the placardView, move the placardView to its location
//    if ([touch view] == self.board) {
//        CGPoint location = [touch locationInView:self.view];
//        self.board.center = location;
//        return;               //pan gesture to any view; not what i want but useful
//    }
//}


-(void)loadBoardAndPaddle{
    
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(100.0, 100.0, 50.0, 50.0)];
    self.ball.backgroundColor = [UIColor orangeColor];
    self.ball.layer.cornerRadius = 25.0;
    self.ball.layer.borderColor = [UIColor blackColor].CGColor;
    self.ball.layer.borderWidth = 0.0;
    [self.view addSubview:self.ball];
    
    self.board = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 75,
                                                          self.view.bounds.size.height-20,
                                                          150.0,
                                                          30.0)];
    self.board.backgroundColor = [UIColor greenColor];
    self.board.layer.cornerRadius = 15.0;
    self.paddleCenterPoint = self.board.center;
    [self.view addSubview:self.board];
    
    
    self.retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.retryButton addTarget:self
                         action:@selector(retryGame)
               forControlEvents:UIControlEventTouchUpInside];
    [self.retryButton setTitle:@"Retry" forState:UIControlStateNormal];
    [self.retryButton setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    self.retryButton.frame = CGRectMake(120, 210.0, 160.0, 40.0);
    [self.view addSubview:self.retryButton];
    self.retryButton.hidden = YES;
    
    // Initialize the animator.
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[self.ball]
                                                   mode:UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(1.0,2.5);
    self.pusher.active = YES;
}

@end
