//
//  BaseViewController.m
//  BPG_New
//
//  Created by bai on 2016/12/7.
//  Copyright © 2016年 bai. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self HiddenNavgationImageView];

}


-(void)HiddenNavgationImageView{
    float ksystem = 10;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < ksystem)
    {
        //去除navgation的下黑线
        if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
        {
            NSArray *list=self.navigationController.navigationBar.subviews;
            //            DLog(@"1111 %@",list);
            for (id obj in list)
            {
                if ([obj isKindOfClass:[UIImageView class]])
                {
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2) {
                        if ([obj2 isKindOfClass:[UIImageView class]])
                        {
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=YES;
                        }
                    }
                }
            }
        }

    }
    else
    {
        UIImageView * navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
        navBarHairlineImageView.hidden = YES;
    }

}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
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
