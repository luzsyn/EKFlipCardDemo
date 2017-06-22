//
//  ViewController.m
//  EKFlipCard
//
//  Created by aika on 2017/6/21.
//  Copyright © 2017年 aika. All rights reserved.
//

#import "ViewController.h"

#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UILabel *frontLb;
@property (nonatomic, strong) UILabel *backLb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRandomColor;
    
    self.cardView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 44, CGRectGetWidth(self.view.bounds)-40, CGRectGetHeight(self.view.bounds)-88)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
        
        UILabel *frontLb = [self createLabel:@"Front" backgroundColor:[UIColor whiteColor]];
        UILabel *backLb = [self createLabel:@"Back" backgroundColor:[UIColor whiteColor]];
        _frontLb = frontLb;
        _backLb = backLb;
        
        [view addSubview:frontLb];
        [view addSubview:backLb];
        frontLb.center = backLb.center = CGPointMake(CGRectGetWidth(view.bounds)/2, CGRectGetHeight(view.bounds)/2);

        view;
    });
    
    [self.view addSubview:self.cardView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView transitionFromView:<#(nonnull UIView *)#> toView:<#(nonnull UIView *)#> duration:<#(NSTimeInterval)#> options:<#(UIViewAnimationOptions)#> completion:<#^(BOOL finished)completion#>]
    [self add3DRotationAnimation:self.cardView
                       fromValue:CATransform3DIdentity
                         toValue:[self getCATransform3DForAngle:M_PI_2]
                        duration:0.7
     timingFunction:kCAMediaTimingFunctionEaseIn
                          forKey:@"FrontAnimation"];
    
}

- (void)add3DRotationAnimation:(UIView *)animationView
                     fromValue:(CATransform3D)fromValue
                       toValue:(CATransform3D)toValue
                      duration:(CGFloat)duration
                timingFunction:(NSString *)timingFunctionName
                        forKey:(NSString *)animationKey

{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:fromValue];
    animation.toValue = [NSValue valueWithCATransform3D:toValue];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.delegate = self;
    [animationView.layer addAnimation:animation forKey:animationKey];
}

- (CATransform3D)getCATransform3DForAngle:(CGFloat)angle
{
    CATransform3D transA = CATransform3DIdentity;
    transA.m34  = - 1.0 / 1600;
    transA = CATransform3DRotate(transA, angle, 0, 1, 0);
    return transA;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [self.cardView.layer animationForKey:@"FrontAnimation"]) {
        
        //交换显示正反面
        [self.cardView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];

        [self add3DRotationAnimation:self.cardView
                           fromValue:[self getCATransform3DForAngle:M_PI_2*3]
                             toValue:[self getCATransform3DForAngle:M_PI*2]
                            duration:0.7
                      timingFunction:kCAMediaTimingFunctionEaseOut
                              forKey:@"BackAnimation"];

    }else {
        [self.cardView.layer removeAllAnimations];
    }
}

- (UILabel *)createLabel:(NSString *)text backgroundColor:(UIColor *)backgroundColor
{
    
    UILabel *label = [UILabel new];
    label.backgroundColor = backgroundColor;
    label.text = text;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
