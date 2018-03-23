//
//  MainViewController.m
//  ScrollAndCollection
//
//  Created by aa on 2018/3/23.
//  Copyright © 2018年 金刚葫芦娃. All rights reserved.
//

#import "MainViewController.h"
#import "ColViewController.h"
#define MAINPRICECOLOR [UIColor whiteColor]
#define MAINSCREEN [UIScreen mainScreen].bounds
#define MAINPRICECOLOR [UIColor colorWithRed:0.0980 green:0.7608 blue:0.5451 alpha:1]
@interface MainViewController ()<UIScrollViewDelegate>
{
    UIView * lineView;
    NSArray * _array;
}
@property (nonatomic, strong) UIScrollView * baseScroll;
@property (nonatomic, strong)  ColViewController * bsVC1;
@property (nonatomic, strong)  ColViewController * bsVC2;
@property (nonatomic, strong)  ColViewController * bsVC3;
@property (nonatomic, strong)  ColViewController * bsVC4;
@end

@implementation MainViewController
#pragma mark - 滑动视图
- (UIScrollView *)baseScroll{
    if (!_baseScroll) {
        _baseScroll = [[UIScrollView alloc]init];
        _baseScroll.frame = self.view.bounds;
        _baseScroll.backgroundColor = MAINPRICECOLOR;
        _baseScroll.delegate = self;
        _baseScroll.userInteractionEnabled = YES;
        _baseScroll.pagingEnabled = YES;
    }
    return _baseScroll;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.baseScroll];
    _baseScroll.contentSize = CGSizeMake(MAINSCREEN.size.width*4,0);
    _array = @[@"下载",@"收藏",@"已购",@"历史"];
    CGFloat w = MAINSCREEN.size.width/4;
    for (int i = 0; i<4; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*w, [UIApplication sharedApplication].statusBarFrame.size.height+54, w, 30);
        [button setTitle:_array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.2902 green:0.9333 blue:0.8078 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100+i;
        [button addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i ==0) {
            lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor whiteColor];
            lineView.frame = CGRectMake(0, 0, 60, 2);
            lineView.center = CGPointMake(button.center.x, button.center.y+15);
            [self.view addSubview:lineView];
            button.selected = YES;
        }
        [self.view addSubview:button];
        
    }
        NSArray * color = @[[UIColor colorWithRed:0.254 green:0.369 blue:0.458 alpha:1],
                            [UIColor colorWithRed:0.256 green:0.111 blue:0.666 alpha:1],
                            [UIColor colorWithRed:0.333 green:0.213 blue:0.567 alpha:1],
                            [UIColor colorWithRed:0.987 green:0.654 blue:0.321 alpha:1]];
    for (int i = 0; i<color.count; i++) {
        //主视图
        switch (i) {
            case 0:
            {
                _bsVC1 = [[ColViewController alloc]init];
                _bsVC1.view.frame = CGRectMake(i*MAINSCREEN.size.width, [UIApplication sharedApplication].statusBarFrame.size.height+84, MAINSCREEN.size.width, MAINSCREEN.size.height-[UIApplication sharedApplication].statusBarFrame.size.height-54-30);
                _bsVC1.view.backgroundColor = color[i];
                [_baseScroll addSubview:_bsVC1.view];
            }
                break;
            case 1:
            {
                _bsVC2 = [[ColViewController alloc]init];
                _bsVC2.view.frame = CGRectMake(i*MAINSCREEN.size.width, [UIApplication sharedApplication].statusBarFrame.size.height+84, MAINSCREEN.size.width, MAINSCREEN.size.height-[UIApplication sharedApplication].statusBarFrame.size.height-54-30);
                _bsVC2.view.backgroundColor = color[i];
                [_baseScroll addSubview:_bsVC2.view];
            }
                break;
            case 2:
            {
                _bsVC3 = [[ColViewController alloc]init];
                _bsVC3.view.frame = CGRectMake(i*MAINSCREEN.size.width, [UIApplication sharedApplication].statusBarFrame.size.height+84, MAINSCREEN.size.width, MAINSCREEN.size.height-[UIApplication sharedApplication].statusBarFrame.size.height-54-30);
                _bsVC3.view.backgroundColor = color[i];
                [_baseScroll addSubview:_bsVC3.view];
            }
                break;
            case 3:
            {
                _bsVC4 = [[ColViewController alloc]init];
                _bsVC4.view.frame = CGRectMake(i*MAINSCREEN.size.width,[UIApplication sharedApplication].statusBarFrame.size.height+84, MAINSCREEN.size.width, MAINSCREEN.size.height-[UIApplication sharedApplication].statusBarFrame.size.height-54-30);
                NSLog(@"frame%@",_bsVC4.view);
                _bsVC4.view.backgroundColor = color[i];
                [_baseScroll addSubview:_bsVC4.view];
            }
                break;
                
            default:
                break;
        }
        
    }
}
- (void)switchClick:(UIButton *)sender{
    for (int i = 0; i<_array.count; i++) {
        UIButton * btn = (UIButton *)[self.view viewWithTag:100+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    [UIView animateWithDuration:0.5 animations:^{
        lineView.center = CGPointMake(sender.center.x, sender.center.y+15);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _baseScroll.contentOffset = CGPointMake((sender.tag-100)*MAINSCREEN.size.width, 0);
    }];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"当前的  offset %f",scrollView.contentOffset.x);
    
    for (int i = 0;i<_array.count;i++) {
        UIButton * sender = (UIButton *)[self.view viewWithTag:i+100];
        sender.selected = NO;
    }
    if (scrollView.contentOffset.x>=MAINSCREEN.size.width&&scrollView.contentOffset.x<MAINSCREEN.size.width*2) {
        UIButton * sender = (UIButton *)[self.view viewWithTag:101];
        [UIView animateWithDuration:0.5 animations:^{
            lineView.center = CGPointMake(sender.center.x, sender.center.y+15);
        }];
        sender.selected = YES;
    }else if (scrollView.contentOffset.x>=MAINSCREEN.size.width*2&&scrollView.contentOffset.x<MAINSCREEN.size.width*3){
        UIButton * sender = (UIButton *)[self.view viewWithTag:102];
        [UIView animateWithDuration:0.5 animations:^{
            lineView.center = CGPointMake(sender.center.x, sender.center.y+15);
        }];
        sender.selected = YES;
    }else if (scrollView.contentOffset.x>=MAINSCREEN.size.width*3&&scrollView.contentOffset.x<MAINSCREEN.size.width*4){
        UIButton * sender = (UIButton *)[self.view viewWithTag:103];
        [UIView animateWithDuration:0.5 animations:^{
            lineView.center = CGPointMake(sender.center.x, sender.center.y+15);
        }];
        sender.selected = YES;
    }else{
        UIButton * sender = (UIButton *)[self.view viewWithTag:100];
        [UIView animateWithDuration:0.5 animations:^{
            lineView.center = CGPointMake(sender.center.x, sender.center.y+15);
        }];
        sender.selected = YES;
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
