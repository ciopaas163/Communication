//
//  SGInfoAlert.m
//
//  Created by Azure_Sagi on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SGInfoAlert.h"

@implementation SGInfoAlert


// 画出圆角矩形背景
static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 CGFLOAT_TYPE_DXYZ ovalWidth,CGFLOAT_TYPE_DXYZ ovalHeight)
{
    CGFLOAT_TYPE_DXYZ fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) { 
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context); 
    CGContextTranslateCTM (context, CGRectGetMinX(rect), 
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight); 
    fw = CGRectGetWidth (rect) / ovalWidth; 
    fh = CGRectGetHeight (rect) / ovalHeight; 
    CGContextMoveToPoint(context, fw, fh/2); 
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); 
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); 
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); 
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); 
    CGContextClosePath(context); 
    CGContextRestoreGState(context); 
}

- (id)initWithFrame:(CGRect)frame bgColor:(CGColorRef)color info:(NSString*)info{
    CGRect viewR = CGRectMake(0, 0, frame.size.width*1.2, frame.size.height*1.2);
    self = [super initWithFrame:viewR];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        bgcolor_ = color;
        info_ = [[NSString alloc] initWithString:info];
        fontSize_ = frame.size;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 背景0.8透明度
    CGContextSetAlpha(context, .8);
    addRoundedRectToPath(context, rect, 4.0f, 4.0f);
    CGContextSetFillColorWithColor(context, bgcolor_);
    CGContextFillPath(context);
    
    // 文字1.0透明度
    CGContextSetAlpha(context, 1.0);
    //CGContextSetShadowWithColor(context, CGSizeMake(0, -1), 1, [[UIColor whiteColor] CGColor]);
   // CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGFLOAT_TYPE_DXYZ x = (rect.size.width - fontSize_.width) / 2.0;
    CGFLOAT_TYPE_DXYZ y = (rect.size.height - fontSize_.height) / 2.0;
    CGRect r = CGRectMake(x, y, fontSize_.width, fontSize_.height);
//    [info_ drawInRect:r withFont:[UIFont systemFontOfSize:kSGInfoAlert_fontSize] lineBreakMode:NSLineBreakByWordWrapping];
    [info_ drawInRect:r withAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:kSGInfoAlert_fontSize] forKey:NSFontAttributeName]];
    
  //  [info_ drawInRect:r withFont:[UIFont systemFontOfSize:kSGInfoAlert_fontSize] lineBreakMode:UILineBreakModeTailTruncation];
}
- (void)remove{
    [self removeFromSuperview];
}

// 渐变消失
- (void)fadeAway{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5f];
    self.alpha = .0;
    [UIView commitAnimations];
    [self performSelector:@selector(remove) withObject:nil afterDelay:1.0f];
}

+ (void)showInfo:(NSString *)info 
         bgColor:(CGColorRef)color
          inView:(UIView *)view 
        vertical:(CGFLOAT_TYPE_DXYZ)height{
    height = height < 0 ? 0 : height > 1 ? 1 : height;
    NSAttributedString *aStr4 =[[NSAttributedString alloc]initWithString:info  attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:kSGInfoAlert_fontSize] forKey:NSFontAttributeName]];
    CGSize size  = [aStr4 boundingRectWithSize:kMax_ConstrainedSize
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                        context:nil].size;

    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    SGInfoAlert *alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    alert.center = CGPointMake(view.center.x, view.frame.size.height*height);
    alert.alpha = 0;
    [view addSubview:alert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    alert.alpha = 1.0;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1];
}
+ (void)showInfo:(NSString *)info
         bgColor:(CGColorRef)color
          inUIImageView:(UIImageView *)imgView
        vertical:(CGFLOAT_TYPE_DXYZ)height{
    height = height < 0 ? 0 : height > 1 ? 1 : height;
    UIView * view = [UIApplication sharedApplication].keyWindow;
    NSAttributedString *aStr =[[NSAttributedString alloc]initWithString:info  attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:kSGInfoAlert_fontSize] forKey:NSFontAttributeName]];
    CGSize size  = [aStr boundingRectWithSize:kMax_ConstrainedSize
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                       context:nil].size;
    
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    SGInfoAlert *alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    alert.center = CGPointMake(view.center.x, view.frame.size.height*height);
    alert.alpha = 0;
    [view addSubview:alert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    alert.alpha = 1.0;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1];
}
@end
