//
//  COntactInfoViewController.m
//  SWACC
//
//  Created by Infinitum on 09/11/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "COntactInfoViewController.h"
#import <UIKit/UIKit.h>
#import "UIColor+Expanded.h"
#import "ListServeViewController.h"
#import "MeetingCalendarViewController.h"
#import "EPLViewController.h"
#import "TopNewsViewController.h"
#import "MainViewController.h"
#import "ReaderViewController.h"

@interface COntactInfoViewController ()

@end

@implementation COntactInfoViewController

@synthesize appDelegate,scrollView,topnewsBtn,listserveBtn,eplBtn,titleBtn,contactBtn,webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#851c2b"];

    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"SWACC";
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

//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [leftBtn setFrame:CGRectMake(0, 0,30,30)];
//    //[leftBtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"font-awesome_4-6-3_search_60_10_851c2b_none.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
//    self.navigationItem.leftBarButtonItem = btn;
//    
//    UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [RightBtn setFrame:CGRectMake(0, 0,30,30)];
//    //[RightBtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
//    [RightBtn setBackgroundImage:[UIImage imageNamed:@"ionicons_2-0-1_android-settings_60_10_851c2b_none.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithCustomView:RightBtn];
//    //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
//    self.navigationItem.rightBarButtonItem = btn1;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*.12, screenRect.size.width, screenRect.size.height*0.06)];
    //    [scrollView setBackgroundColor:[UIColor greenColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    //    [self.view addSubview:scrollView];
    
    
    //scrollView.contentSize= CGSizeMake(350,0);
    
    //[self createScrollMenu];
    
    webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.11,screenRect.size.width,screenRect.size.height*0.89)];
    NSURL *targetURL;
    if(appDelegate.index==5){
        targetURL = [NSURL URLWithString:@"https://23.253.109.178/swacc/docs/2016-2017%20SWACC%20MEETINGS%20use.pdf"];
    }
    else{
        targetURL = [NSURL URLWithString:@"https://23.253.109.178/swacc/docs/SWACC%20Initiative_EPL%20Exposure_111115_CM.pdf"];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:request];
    [self.webView.scrollView setZoomScale:2.0 animated:YES];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];

    //[self handleSingleTap:path];

}
- (void)handleSingleTap:(NSString *)filePath
{
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
    
    if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
    {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
        [self.navigationController pushViewController:readerViewController animated:YES];
#else // present in a modal view controller
        
        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:readerViewController animated:YES completion:NULL];
        
#endif // DEMO_VIEW_CONTROLLER_PUSH
    }
    else // Log an error so that we know that something went wrong
    {
        NSLog(@"%s [ReaderDocument withDocumentFilePath:'%@' password:'%@'] failed.", __FUNCTION__, filePath, phrase);
    }
}
#pragma mark - ReaderViewControllerDelegate methods

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
    [self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
#endif // DEMO_VIEW_CONTROLLER_PUSH
}

-(IBAction)CancelAction:(id)sender{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
    [self.navigationController pushViewController:mainvc animated:YES];
}

- (void) loadRemotePdf
{
    webView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);

}

- (void)createScrollMenu
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:10.0f];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*.12, self.view.frame.size.width,screenRect.size.height*0.05)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    int x = 0;
    topnewsBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,0,screenRect.size.width*0.30,screenRect.size.height*0.05)];
    [topnewsBtn setTitle:@"Top News" forState:UIControlStateNormal];
    topnewsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [topnewsBtn setTitleColor:[UIColor colorWithHexString:@"ABA6A3"] forState:UIControlStateNormal];
    [topnewsBtn setBackgroundColor:[UIColor colorWithHexString:@"F8F4F1"]];
    [topnewsBtn.titleLabel setFont:font1];
    [topnewsBtn addTarget:self action:@selector(topnewsAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:topnewsBtn];
    
    x += screenRect.size.width*0.30;
    
    listserveBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,0,screenRect.size.width*0.70,screenRect.size.height*0.05)];
    [listserveBtn setTitle:@"List Serve Communication" forState:UIControlStateNormal];
    listserveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [listserveBtn setTitleColor:[UIColor colorWithHexString:@"ABA6A3"] forState:UIControlStateNormal];
    [listserveBtn setBackgroundColor:[UIColor colorWithHexString:@"F8F4F1"]];
    [listserveBtn.titleLabel setFont:font1];
    [listserveBtn addTarget:self action:@selector(listserveAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:listserveBtn];
    
    x += screenRect.size.width*0.70;
    
    eplBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,0,screenRect.size.width*0.20,screenRect.size.height*0.05)];
    [eplBtn setTitle:@"EPL" forState:UIControlStateNormal];
    eplBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [eplBtn setTitleColor:[UIColor colorWithHexString:@"ABA6A3"] forState:UIControlStateNormal];
    [eplBtn setBackgroundColor:[UIColor colorWithHexString:@"F8F4F1"]];
    [eplBtn.titleLabel setFont:font1];
    [eplBtn addTarget:self action:@selector(eplAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:eplBtn];
    
    x += screenRect.size.width*0.20;
    
    titleBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,0,screenRect.size.width*0.30,screenRect.size.height*0.05)];
    [titleBtn setTitle:@"Title IX" forState:UIControlStateNormal];
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [titleBtn setTitleColor:[UIColor colorWithHexString:@"ABA6A3"] forState:UIControlStateNormal];
    [titleBtn setBackgroundColor:[UIColor colorWithHexString:@"F8F4F1"]];
    [titleBtn.titleLabel setFont:font1];
    [titleBtn addTarget:self action:@selector(titleAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:titleBtn];
    
    x += screenRect.size.width*0.30;
    
    contactBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,0,screenRect.size.width*0.60,screenRect.size.height*0.05)];
    [contactBtn setTitle:@"Member Contact Info" forState:UIControlStateNormal];
    contactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [contactBtn setTitleColor:[UIColor colorWithHexString:@"ABA6A3"] forState:UIControlStateNormal];
    [contactBtn setBackgroundColor:[UIColor colorWithHexString:@"F8F4F1"]];
    [contactBtn.titleLabel setFont:font1];
    //[contactBtn addTarget:self action:@selector(contactAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:contactBtn];
    
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, contactBtn.frame.size.height - 1.0f, contactBtn.frame.size.width, 1)];
    bottomBorder.backgroundColor = [UIColor colorWithHexString:@"03687f"];
    [contactBtn addSubview:bottomBorder];

    x += screenRect.size.width*0.80;
    
    
    scrollView.contentSize = CGSizeMake(x,0);
    scrollView.backgroundColor = [UIColor colorWithHexString:@"F8F4F1"];
    
    [self.view addSubview:scrollView];
}
-(void)topnewsAction{
    TopNewsViewController *Topnews=[[TopNewsViewController alloc] initWithNibName:@"TopNewsViewController" bundle:nil];
    [self.navigationController pushViewController:Topnews animated:NO];
    
}
-(void)listserveAction{
    ListServeViewController *list=[[ListServeViewController alloc] initWithNibName:@"ListServeViewController" bundle:nil];
    [self.navigationController pushViewController:list animated:NO];
    
}
-(void)eplAction{
    EPLViewController *epl=[[EPLViewController alloc] initWithNibName:@"EPLViewController" bundle:nil];
    [self.navigationController pushViewController:epl animated:NO];
    
}
-(void)titleAction{
    MeetingCalendarViewController *title=[[MeetingCalendarViewController alloc] initWithNibName:@"MeetingCalendarViewController" bundle:nil];
    [self.navigationController pushViewController:title animated:NO];
    
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
