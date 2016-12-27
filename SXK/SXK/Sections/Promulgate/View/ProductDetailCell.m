//
//  ProductDetailCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/22.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ProductDetailCell.h"
#import "MaintainCellModel.h"

@interface ProductDetailCell ()<UIWebViewDelegate>

@end

@implementation ProductDetailCell{
    UIWebView *_webView;
    CGFloat _height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _webView = [[UIWebView alloc] init];
         _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
        
        
        [self addSubview:_webView];
        
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(-8);
            make.right.equalTo(self.mas_right).offset(8);
        }];
    }
        return  self;
}

-(void)setModel:(id)model
{
    MaintainCellModel *_model = model;
//    NSString *html = _model.description1;
    
    
//    NSString *jsString = [NSString stringWithFormat:@"<html> \n"
//                          "<head> \n"
//                          "<style type=\"text/css\"> \n"
//                          "body {font-size: %f; font-family: \"%@\"; color: %@;}\n"
//                          "</style> \n"
//                          "</head> \n"
//                          "<body>%@</body> \n"
//                          "</html>", 13.0f, @"Times New Roman", @"black", _model.description1];
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:13px}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       "$img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",_model.description1];
    
//    NSLog(@"html :   %@",htmls);
    
    [_webView loadHTMLString:htmls  baseURL:nil];
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
//    NSString *js = @"function imgAutoFit() { \
//    var imgs = document.getElementsByTagName('img'); \
//    for (var i = 0; i < imgs.length; ++i) {\
//    var img = imgs[i];   \
//    img.style.maxWidth = %f;   \
//    img.style.height = 'auto' \
//    } \
//    }";
//    
//    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width];
//    
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    
//    NSString *js = @"function imgAutoFit() { \
//    var imgs = document.getElementsByTagName('img'); \
//    for (var i = 0; i < imgs.length; ++i) {\
//    var img = imgs[i];   \
//                            \
//    img.style.maxWidth = %f;   \
//    img.style.height = 'auto' \
//    } \
//    }";
//    
//    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width];
//    
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];

//    
//    NSString *js=@"var script = document.createElement('script');"
//    "script.type = 'text/javascript';"
//    "script.text = \"function ResizeImages() { "
//    "var myimg,oldwidth;"
//    "var maxwidth = %f;"
//    "for(i=0;i <document.images.length;i++){"
//    "myimg = document.images[i];"
//    "if(myimg.width > maxwidth){"
//    "oldwidth = myimg.width;"
//    "myimg.width = %f;"
//    "}"
//    "}"
//    "}\";"
//    "document.getElementsByTagName('head')[0].appendChild(script);";
//    js=[NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];

    
    CGFloat height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    _height = height;
    [_delegate getHeight:height];
    
}


@end
