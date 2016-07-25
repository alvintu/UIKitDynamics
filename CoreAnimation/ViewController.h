//
//  ViewController.h
//  CoreAnimation
//
//  Created by Jo Tu on 7/19/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface ViewController : UIViewController<UICollisionBehaviorDelegate>

@property (strong, nonatomic) IBOutlet UIView *board;
@property (strong, nonatomic) IBOutlet UIView *ball;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

