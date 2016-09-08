//
//  PPX_Button.m
//  PPX_Player
//
//  Created by pipixia on 16/9/7.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "PPX_Button.h"


@interface PPX_Button ()
{
    CGRect _imageRect;
    CGRect _titleRect;
}
@end

@implementation PPX_Button

-(instancetype)initWithFrame:(CGRect)frame imageRect:(CGRect)imageRect titleRect:(CGRect)titleRect{
    if (self=[super initWithFrame:frame]) {
        _imageRect=imageRect;
        _titleRect=titleRect;
    }
    return self;
}

//设置image的范围
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return _imageRect;
}

//设置title的范围
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return _titleRect;
}


@end
