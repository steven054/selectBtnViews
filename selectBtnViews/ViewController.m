//
//  ViewController.m
//  selectBtnViews
//
//  Created by 史德伟 on 16/3/22.
//  Copyright (c) 2016年 QJS. All rights reserved.
//

#import "ViewController.h"
#import "QJSselectBtnViews.h"
@interface ViewController ()<QJSselectBtnViewsDelegate>
{
    NSInteger selectNavbtnIndex;
}
@property(nonatomic,strong)QJSselectBtnViews *sectionBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.userInteractionEnabled=YES;
    
    UIView *vies=[[UIView alloc ]init];
    vies.frame=CGRectMake(0, 100, self.view.frame.size.width, 100);
    [self.view addSubview:vies];
    selectNavbtnIndex=0;

    self.sectionBtn = [QJSselectBtnViews finacesNavButtonViewWithTitleArray:@[@"仟金所项目一",@"仟金所项目二",@"仟金所项目三",@"仟金所项目四",@"仟金所项目五",@"仟金所项目六",@"仟金所项目七",@"仟金所项目八",@"仟金所项目九"] andSelectedIndex:selectNavbtnIndex];
    self.sectionBtn.backgroundColor = [UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f];
    self.sectionBtn.frame=CGRectMake(0, 0, self.view.frame.size.width, 100);
    self.sectionBtn.delegate = self;
    [vies addSubview:_sectionBtn];
    
    
}


-(void)finacesNavButtonView:(QJSselectBtnViews *)navButtonView didSelectedButtonAtIndex:(NSInteger)buttonIndex
{
    selectNavbtnIndex=buttonIndex;
    
    
//    navButtonView.scrollview.contentOffset=CGPointMake(selectNavbtnIndex*self.view.frame.size.width/4, 0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
