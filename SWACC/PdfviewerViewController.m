//
//  PdfviewerViewController.m
//  SWACC
//
//  Created by Infinitum on 02/01/17.
//  Copyright © 2017 com.keenan. All rights reserved.
//

#import "PdfviewerViewController.h"
#import "UIColor+Expanded.h"
@interface PdfviewerViewController ()

@end

@implementation PdfviewerViewController
@synthesize appDelegate,webView,scrollFront,BackImgVw1,image;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#851c2b"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"Viewer";
    [titleLabel setTextColor:[UIColor whiteColor]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,30,30)];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[UIColor colorWithHexString:@"#03687f"]];
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if ([appDelegate.urlStr rangeOfString:@".png"].location == NSNotFound) {
        if ([appDelegate.urlStr rangeOfString:@"http"].location == NSNotFound) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:appDelegate.urlStr];
            NSString* documentsPath1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            
            NSString* foofile = [documentsPath1 stringByAppendingPathComponent:appDelegate.urlStr];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
            NSLog(@"fileExists%d",fileExists);

            NSURL *pdfUrl = [NSURL fileURLWithPath:filePath];

            webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.11,screenRect.size.width,screenRect.size.height*0.89)];
            NSURL *targetURL;
            targetURL = [NSURL URLWithString:appDelegate.urlStr];
            NSURLRequest *request = [NSURLRequest requestWithURL:pdfUrl];
            [webView loadRequest:request];
            [self.webView.scrollView setZoomScale:2.0 animated:YES];
            [webView setBackgroundColor:[UIColor whiteColor]];
            [webView setScalesPageToFit:YES];
            [self.view addSubview:webView];
            
        }else{
        
    webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.11,screenRect.size.width,screenRect.size.height*0.89)];
    NSURL *targetURL;
        targetURL = [NSURL URLWithString:appDelegate.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:request];
    [self.webView.scrollView setZoomScale:2.0 animated:YES];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    }
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        self.scrollFront=[[UIScrollView alloc]init];
        self.scrollFront.layer.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.88);
        [self.scrollFront removeFromSuperview];
        [self.view addSubview:self.scrollFront];
        
        self.BackImgVw1 =[[UIImageView alloc]init];
        self.BackImgVw1.layer.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.25);
        [self.BackImgVw1 removeFromSuperview];
        [self.scrollFront addSubview:self.BackImgVw1];
        self.scrollFront.delegate=self;
        
        NSArray *arrayPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path = [arrayPaths objectAtIndex:0];
        NSString* pdfFileName = [path stringByAppendingPathComponent:appDelegate.urlStr];
        UIImage *image1=[UIImage imageWithContentsOfFile:pdfFileName];

        [BackImgVw1 setImage:image1];
        BackImgVw1.image = image1;
        
        BackImgVw1.frame = scrollFront.bounds;
        [BackImgVw1 setContentMode:UIViewContentModeScaleAspectFit];
        //scrollFront.contentSize = CGSizeMake(BackImgVw1.frame.size.width, BackImgVw1.frame.size.height);
        scrollFront.maximumZoomScale = 4.0;
        scrollFront.minimumZoomScale = 1.0;
        scrollFront.delegate = self;

    }
}
-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // return which subview we want to zoom
    
    if (scrollView==scrollFront) {
        
        return self.BackImgVw1;
    }
    return 0;
}

-(IBAction)CancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
