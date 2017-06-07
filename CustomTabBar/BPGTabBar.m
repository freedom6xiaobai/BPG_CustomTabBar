//
//  BPGTabBar.m
//  BPG_New
//
//  Created by bai on 2017/2/23.
//  Copyright © 2017年 bai. All rights reserved.
//

#import "BPGTabBar.h"
/** 通知：UITabbarButton的重复点击 */
NSString * const BSTabBarButtonRepeatClickNotification = @"BSTabBarButtonRepeatClickNotification";


@interface BPGTabBar ()
/** 自定义按钮 */
@property (nonatomic,strong) UIButton *plusButton;
/** 记录上一次点击过的按钮的Tag */
@property (nonatomic,assign) NSInteger previousClicktag;
/** 记录上一次点击过的按钮 */
@property (nonatomic,strong) UIControl *previousClickTaBarButton;

@end

@implementation BPGTabBar
#pragma mark - 操作
// 监听按钮的点击
- (void)plusButtonClick{
    if (self.operationBlock) {
        self.operationBlock();
    }
}

- (void)tabBarButtonClick:(UIControl *)tabBarButton{
    if (self.previousClicktag == tabBarButton.tag) {
        // 告诉其他人（按钮呗重复点击了）
        [[NSNotificationCenter defaultCenter] postNotificationName:BSTabBarButtonRepeatClickNotification object:nil];
    }
    self.previousClicktag = tabBarButton.tag;
}




// 重新布局TabBar的子控件
- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat width = self.frame.size.width/( self.items.count + 1);
    CGFloat height = self.frame.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger i = 0;
    for (UIControl *taBarControl in self.subviews) {
        if ([taBarControl isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i==2) {
                i++;
            }
            x = i*width;
            taBarControl.frame = CGRectMake(x, y, width, height);
            i++;

            taBarControl.tag = i;
            [taBarControl addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];

            /// 短时间内连续点击，类似于鼠标的双击事件
//             [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDownRepeat];
        }
    }

    // 计算plusButton的位置
    self.plusButton.center = CGPointMake(width * 2.5, height*0.5);
    self.plusButton.contentEdgeInsets = UIEdgeInsetsMake(2, 0, -2, 0); 
}


// 懒加载plusButton并初始化该按钮
- (UIButton *)plusButton{
    if (!_plusButton) {
        _plusButton = [[UIButton alloc] init];
        [_plusButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_plusButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_plusButton sizeToFit];
        [self addSubview:_plusButton];
        // 监听按钮的点击
        [_plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusButton;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
