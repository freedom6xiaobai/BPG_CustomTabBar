//
//  BPGTabBarViewController.m
//  CustomTabBar
//
//  Created by baipeng on 2017/6/7.
//  Copyright © 2017年 BPG. All rights reserved.
//

#import "BPGTabBarViewController.h"
#import "BPGNavgationViewController.h"


#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "PushViewController.h"


#import "BPGTabBar.h"



@interface BPGTabBarViewController ()

@end

@implementation BPGTabBarViewController
+ (void)initialize
{
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@""]];//背景色

    // 获取TabBarItem的appearence
    UITabBarItem *appearance = [UITabBarItem appearance];
    // 正常状态
    NSDictionary *normalDict = @{
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                 NSFontAttributeName:[UIFont systemFontOfSize:12]
                                 };
    [appearance setTitleTextAttributes:normalDict forState:UIControlStateNormal];

    // 选中状态
    NSDictionary *selectedDict = @{
                                   NSForegroundColorAttributeName:[UIColor redColor],
                                   NSFontAttributeName:[UIFont systemFontOfSize:12]
                                   };
    [appearance setTitleTextAttributes:selectedDict forState:UIControlStateSelected];


    //隐藏阴影线
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [UITabBar appearance].barTintColor=[UIColor whiteColor];//背景颜色为红色
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化所有的子控制器
    [self setupChildViewControllers];
    [self setupTabBar];
}

/**
 自定义tabbar
 */
-(void)setupTabBar{
    BPGTabBar *tabBar = [[BPGTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
    __weak typeof(self)weakSelf = self;
    tabBar.operationBlock = ^{
        PushViewController *publish = [[PushViewController alloc]init];
        BPGNavgationViewController *nav = [[BPGNavgationViewController alloc]initWithRootViewController:publish];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    };
}
/**
 * 初始化所有的子控制器
 */
- (void)setupChildViewControllers
{
    OneViewController *one = [[OneViewController alloc] init];
    [self setupOneChildViewController:one title:@"一" image:@"tabbar_icon_reader_normal" selectedImage:@"tabbar_icon_reader_highlight"];

    TwoViewController *two = [[TwoViewController alloc] init];
    [self setupOneChildViewController:two title:@"二" image:@"tabbar_icon_reader_normal" selectedImage:@"tabbar_icon_reader_highlight"];

    ThirdViewController *third = [[ThirdViewController alloc] init];
    [self setupOneChildViewController:third title:@"三" image:@"tabbar_icon_reader_normal" selectedImage:@"tabbar_icon_reader_highlight"];

    FourViewController *four = [[FourViewController alloc] init];
    [self setupOneChildViewController:four title:@"四" image:@"tabbar_icon_reader_normal" selectedImage:@"tabbar_icon_reader_highlight"];

    FiveViewController *five = [[FiveViewController alloc] init];
    [self setupOneChildViewController:five title:@"五" image:@"tabbar_icon_reader_normal" selectedImage:@"tabbar_icon_reader_highlight"];


}



- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{

    vc.tabBarItem.title = title;
    vc.title = title;
    UIImage *musicImage = [UIImage imageNamed:image];
    UIImage *musicImageSel = [UIImage imageNamed:selectedImage];

    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];



    vc.tabBarItem.image =  musicImage;
    vc.tabBarItem.selectedImage =musicImageSel;



    [self addChildViewController:[[BPGNavgationViewController alloc] initWithRootViewController:vc]];
}


#pragma mark - UITabBarControllerDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    UIView *tabBarButton = [item valueForKey:@"_view"];
    if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        CABasicAnimation *imgAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        imgAnimation.duration = 0.25;
        imgAnimation.fromValue = @(0.2);
        imgAnimation.toValue = @(1.3);
        imgAnimation.autoreverses = YES;
        UIImageView *img = [tabBarButton valueForKey:@"_info"];
        [img.layer addAnimation:imgAnimation forKey:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
