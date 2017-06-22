# EKFlipCardDemo
TransitionFromViewToView Using CATransform3D Rotation Animation

这是一个翻转卡片的Demo

虽然系统提供了翻转视图的API，

    [UIView transitionFromView:self.aView toView:self.bView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
     // do something such as hidden or remove
     }];

 但是系统API在翻转View的时候对view的alpha做了处理，导致在翻转的过程中会出现黑色闪屏效果，特别是在view的颜色是白色的时候，视觉效果更差，所以自己用CABasicAnimation做了类似的动画效果。

大概思路如下：
- 1.获取到fromView及toView
- 2.将toView添加到fromView的superView上
- 3.开始坐标变换及动画效果
- 4.完成后将fromView移除

第一次动手做动画，效果可能还不太好，还请各路大神多多指教。
