//
//  CustomView.m
//  SJQuartz2d
//
//  Created by SPIREJ on 16/1/28.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

/**iPhone的绘图操作是在UIView类的drawRect方法中完成的，所以如果我们要想在一个UIView中绘图，需要写一个扩展UIView类，并重写drawRect方法，在这里进行绘图操作，程序会自动调用此方法进行绘图*/


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //获取图形上下文，绘图作用域，是专门用来保存绘图期间各种数据
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    [self drawLine:contextRef];
//    [self drawTriangle:contextRef];
//    [self drawCustomRect:contextRef];
//    [self drawCircle:contextRef];
//    [self drawArc:contextRef];
//    [self drawCurve:contextRef];
//    [self drawEffect:contextRef];
//    [self drawFont:contextRef];
//    [self drawImage:contextRef];
    [self clipImage:contextRef];
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    //drawRect是不能手动调用的，系统不允许直接调用
    //当需要调用drawRect方法的时候，就需要通知父类重新绘图
    [self setNeedsDisplay];
    self.backgroundColor = [UIColor whiteColor];
}
//10.切割图片
- (void)clipImage:(CGContextRef)contextRef{
    //画圆形
    CGContextAddEllipseInRect(contextRef, CGRectMake(20, 50, 100, 100));
    //切割操作
    CGContextClip(contextRef);
    CGContextFillPath(contextRef);
    UIImage *image = [UIImage imageNamed:@"c8177f3e6709c93d0c77051a9b3df8dcd0005451.jpg"];
    [image drawAtPoint:CGPointMake(10, 50)];
}
//9.绘制图片
- (void)drawImage:(CGContextRef)contextRef{
    UIImage *image = [UIImage imageNamed:@"c8177f3e6709c93d0c77051a9b3df8dcd0005451.jpg"];
    //平铺图像
    [image drawAsPatternInRect:self.bounds];
}
//8.绘制文字
- (void)drawFont:(CGContextRef)contextRef{
    NSString *string = @"最强的武器是什么，就是装逼。";
    NSDictionary *dict = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:20],
                           NSForegroundColorAttributeName:[UIColor brownColor]
                           };
    //调用字符串的 drawAtPoint方法能够将文字直接绘制到view上
//    [string drawAtPoint:CGPointMake(20, 20) withAttributes:dict];
    [string drawInRect:CGRectMake(10, 10, 100, 100) withAttributes:dict];
}
//7.画特效
- (void)drawEffect:(CGContextRef)contextRef{
    CGContextAddRect(contextRef, CGRectMake(50, 50, 100, 100));
    CGContextSetLineWidth(contextRef, 5.0);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor brownColor].CGColor);
    CGContextSetFillColorWithColor(contextRef, [UIColor cyanColor].CGColor);
    
    //设置透明度
    CGContextSetAlpha(contextRef, 0.5);
    //设置阴影
    CGContextSetShadow(contextRef, CGSizeMake(10, 10), 10);
    //同时显示线框和填充
    CGContextDrawPath(contextRef, kCGPathFillStroke);
}
//6.画曲线
- (void)drawCurve:(CGContextRef)contextRef{
    //曲线起点
    CGContextMoveToPoint(contextRef, 20, 100);
    /**
     *  画曲线
     *
     *  @param c#>   作用域 description#>
     *  @param cpx#> 控制点x description#>
     *  @param cpy#> 控制点y description#>
     *  @param x#>   终点x description#>
     *  @param y#>   终点y description#>
     */
//    CGContextAddQuadCurveToPoint(contextRef, 70, 150, 120, 50);
    //两个控制点的情况
    CGContextAddCurveToPoint(contextRef, 70, 20, 130, 180, 180, 100);
    CGContextStrokePath(contextRef);
}

//5.画扇形
- (void)drawArc:(CGContextRef)contextRef{
    CGContextMoveToPoint(contextRef, 50, 50);
    /**
     *  画扇形
     *
     *  @param c#>          作用域 description#>
     *  @param x#>          圆心x坐标 description#>
     *  @param y#>          圆心y坐标 description#>
     *  @param radius#>     半径 description#>
     *  @param startAngle#> 开始角度 description#>
     *  @param endAngle#>   结束角度 description#>
     *  @param clockwise#>  方向（默认是顺时针0，1是逆时针） description#>
     */
    CGContextAddArc(contextRef, 50, 50, 50, 0, 90*M_PI/180, 0);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor brownColor].CGColor);
    CGContextAddLineToPoint(contextRef, 50, 50);
    CGContextStrokePath(contextRef);
//    CGContextFillPath(contextRef);
}
//4.画圆
- (void)drawCircle:(CGContextRef)contextRef{
    CGContextAddEllipseInRect(contextRef, CGRectMake(30, 50, 100, 100));
    CGContextStrokePath(contextRef);
}

//3.画矩形
- (void)drawCustomRect:(CGContextRef)contextRef{
    //矩形框
    CGContextAddRect(contextRef, CGRectMake(50, 50, 100, 70));
    //空心（画线的轨迹）
    CGContextStrokePath(contextRef);
    //实心（填充）
    CGContextFillPath(contextRef);
    //同时显示线框和填充
    CGContextDrawPath(contextRef, kCGPathFillStroke);
#warning mark - 以上三种渲染方式只能有一种起作用，如果写了多种，默认使用先执行的效果
}

//2.画三角
- (void)drawTriangle:(CGContextRef)contextRef{
    CGContextMoveToPoint(contextRef, 100, 20);
    CGContextAddLineToPoint(contextRef, 150, 100);
    //如果连续添加多条线，会自动把上一条线的终点作为自己的起点（实现折线）
    CGContextAddLineToPoint(contextRef, 50, 100);
    CGContextSetLineWidth(contextRef, 1);
    //折线角的风格样式
    CGContextSetLineJoin(contextRef, kCGLineJoinRound);
    //连接起点和终点（封起来）
    CGContextClosePath(contextRef);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor brownColor].CGColor);
    //绘制空心的图形
    CGContextStrokePath(contextRef);
    //绘制实心的tux
//    CGContextFillPath(contextRef);
}
//1.画线段
- (void)drawLine:(CGContextRef)contextRef{
    //起点
    CGContextMoveToPoint(contextRef, 20, 50);
    //终点
    CGContextAddLineToPoint(contextRef, 100, 100);
    //线宽度
    CGContextSetLineWidth(contextRef, 5);
    //线颜色
//    CGContextSetRGBFillColor(contextRef, 1, 0, 0, 1);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor brownColor].CGColor);
    /**
     *  画虚线
     *
     *  @param c#>       作用域 description#>
     *  @param phase#>   起点的左偏移量 description#>
     *  @param lengths#> 规定实心和虚心的长度的是个数组 description#>
     *  @param count#>   实心和虚心的循环次数（count 必须等于lengths 数组的长度） description#>
     *
     */
    CGFloat lengths[] = {5,10};
    CGContextSetLineDash(contextRef, 0, lengths, 2);
    //将图形绘制到View上来（渲染）
    CGContextStrokePath(contextRef);
}

@end
