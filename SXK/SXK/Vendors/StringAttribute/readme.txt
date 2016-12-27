//
//  readme.m
//  HYStringAttribute
//
//  Created by HEYANG on 15/11/22.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

如何使用这个富文本工具？

1、在需要使用这个富文本工具的地方
#import "StringAttributeHelper.h" 即可使用这个工具类的API

2、然后是属性值通过字典存储的一系列“属性模型对象”

3、一般最后都是调用NSString拓展的可变富文本的类方法
NSMutableAttributeString *attrStr = [str mutableAttributedStringWithStringAttributes:(NSArray *)attributes]

4、控件.attributedText = attrStr;

具体如何使用，可以参考ViewController的Demo使用代码。



不足之处，还没有拓展其他需要的富文本属性。一共有21中富文本属性，这里才实现了2种。

