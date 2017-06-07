//
//  BPGNavgationViewController.m
//  BPG_sunning
//
//  Created by bai on 16/7/11.
//  Copyright © 2016年 BPG. All rights reserved.
//

#import "BPGNavgationViewController.h"

@interface BPGNavgationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BPGNavgationViewController
+ (void)initialize
{
    // 设置导航栏的主题
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTintColor:[UIColor blackColor]];//字体颜色
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    [bar setBarTintColor:[UIColor orangeColor]];//背景
    
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [self handleNavigationSetUp];
    
    
    
    
}
#pragma mark - 侧滑返回ViewController
-(void)handleNavigationSetUp{
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}
#pragma mark - UIGestureRecognizerDelegate
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count != 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {// 隐藏导航栏

        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitle:@" 返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        button.bounds = CGRectMake(0, 0, 70, 30);
        button.contentEdgeInsets = UIEdgeInsetsMake(0,  0, 0, 0);
        [button sizeToFit];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        

        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
        
        // 2.隐藏底部TabBar导航条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}



@end
