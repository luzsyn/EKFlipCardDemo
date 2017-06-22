# EKFlipCardDemo
TransitionFromViewToView Using CATransform3D Rotation Animation

这是一个翻转卡片的Demo

虽然系统提供了翻转视图的API，

    [UIView transitionFromView:self.aView toView:self.bView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
     // do something such as hidden or remove
     }];

 但是系统API在翻转View的时候对view的alpha做了处理，导致在翻转的过程中会出现黑色闪屏效果，特别是在view的颜色是白色的时候，视觉效果更差，所以自己用CABasicAnimation做了类似的动画效果。

大概思路如下：
- 1.开始坐标变换及动画效果,将view从0旋转到M_PI_2的角度
- 2.交换子视图的位置（也可以用removeFromSuperView/addSubView的方式）
- 3.开始坐标变换及动画效果,将view从M_PI_2*3旋转到M_PI*2的角度
- 4.完成后将view的动画效果移除

第一次动手做动画，效果可能还不太好，还请各路大神多多指教。
