//
//  TabBar.m
//  CustomTabBar-0818
//
//  Created by apple on 14-8-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "TabBar.h"
#import "Items.h"

@interface TabBar ()
{
    UIImageView *bgImageView;
    NSMutableArray *_btnMArray;
    UIView *_maskView;
    CGFloat _intervalWidth;
    CGFloat _intervalHeight;
    //按钮宽度
    CGFloat width;
    int flog;
}
@end

@implementation TabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        bgImageView=[[UIImageView alloc]initWithFrame:self.bounds];
        
        bgImageView.image=[UIImage imageNamed:@"TabBarBackground.png"];
        
        [self addSubview:bgImageView];
    }
    _btnMArray=[NSMutableArray array];
    return self;
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    UIButton *btn=_btnMArray[selectIndex];
    [self didClicked:btn];
    _selectIndex=selectIndex;
}

- (void)setBgImage:(UIImage *)bgImage
{
    bgImageView.image=bgImage;
    _bgImage=bgImage;
}

- (void)setItemArray:(NSArray *)items
{
    _itemArray = items;
    _intervalWidth = 1;
    //查询中心按钮
    width=(self.frame.size.width-2*_intervalWidth)/3;
    Items *item=[items objectAtIndex:0];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.frame=CGRectMake(0, 0, width, self.frame.size.height);
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(didSelectClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sanjiao.png"]];
    imgView.frame = CGRectMake(btn.bounds.size.width-20, 0, 20, 20);
//    [btn setBackgroundImage:[UIImage imageNamed:@"sanjiao.png"] forState:UIControlStateNormal];
    btn.tag=0;
    [btn addSubview:imgView];
    [btn setTitle:@"查询中心" forState:UIControlStateNormal];
    [self addSubview:btn];
    [_btnMArray addObject:btn];
    
    //在线请假按钮
    Items *item1=[items objectAtIndex:6];
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(width+_intervalWidth, 0, width, self.frame.size.height);
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn1 setBackgroundImage:item.selectImage forState:UIControlStateSelected];
    btn1.tag=6;
    [btn1 setTitle:item1.title forState:UIControlStateNormal];
    [self addSubview:btn1];
    [_btnMArray addObject:btn1];
    
    Items *item2=[items objectAtIndex:7];
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(2*width+2*_intervalWidth, 0, width, self.frame.size.height);
//    btn2.alpha = 1;
    btn2.backgroundColor = [UIColor grayColor];
    [btn2 addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn2 setBackgroundImage:item.selectImage forState:UIControlStateSelected];
    btn2.tag=7;
    btn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn2 setTitle:item2.title forState:UIControlStateNormal];
    [self addSubview:btn2];
    [_btnMArray addObject:btn2];
    
//    [self maskView];
}

- (UIView *)maskView
{
    _maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedMask:)]];
    CGFloat btnHeight = 40;
    _intervalHeight = 1;
//    _maskView.backgroundColor = [UIColor whiteColor];
//    _maskView.alpha = 0.1;
    CGFloat oriYBtn = self.window.bounds.size.height-49-(4*_intervalHeight)-5*btnHeight;
    int count;
    for (int i=0; i<5; i++)
    {
        count = i+1;
        Items *item=[_itemArray objectAtIndex:count];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor grayColor];
        btn.alpha = 0.9;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.frame=CGRectMake(0,oriYBtn+i*(_intervalHeight+btnHeight),width,btnHeight);
        [btn addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setBackgroundImage:item.selectImage forState:UIControlStateSelected];
        btn.tag=count;
        [btn setTitle:item.title forState:UIControlStateNormal];
        [_maskView addSubview:btn];
        
        [_btnMArray addObject:btn];
    }
    return _maskView;
}

- (void)didClickedMask:(UIGestureRecognizer *)tap
{
    [_maskView removeFromSuperview];
}

- (void)didSelectClicked:(UIButton *)sender
{
    [self maskView];
    [self.window addSubview:_maskView];
}

- (void)didClicked:(UIButton *)sender
{
    [_maskView removeFromSuperview];
    //遍历各个按钮，使所有按钮都变为未选中状态
    for (UIButton *button in _btnMArray)
    {
        button.selected=NO;
    }
    sender.selected=YES;
    if (_delegate&&[_delegate respondsToSelector:@selector(tabBar:didTag:)])
    {
        [_delegate tabBar:self didTag:sender.tag];
    }
}

@end
