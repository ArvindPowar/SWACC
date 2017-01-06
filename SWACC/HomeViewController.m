//
//  HomeViewController.m
//  SWACC
//
//  Created by Infinitum on 09/11/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import <UIKit/UIKit.h>
#import "UIColor+Expanded.h"
#import "MenuViewController.h"
#import "ChatUserListViewController.h"
#import "ProfileViewController.h"
#import "Reachability.h"
#import "MessageVO.h"
#import "TopNewsVO.h"
#import "TopNewsViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize appDelegate,scrollView,topnewsBtn,listserveBtn,eplBtn,titleBtn,contactBtn,
tableViewMain,overlayView,isMenuVisible,menuNameButton,activityImageView,serachArray,commonUrl;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate=[[UIApplication sharedApplication] delegate];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"SWACC";
    [titleLabel setTextColor:[UIColor blackColor]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    [titleLabel setTextColor: [UIColor whiteColor]];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#851c2b"];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,30,30)];
    [leftBtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"slider_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    self.navigationItem.leftBarButtonItem = btn;
    
    UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [RightBtn setFrame:CGRectMake(0, 0,30,30)];
    [RightBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    [RightBtn setBackgroundImage:[UIImage imageNamed:@"settings_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithCustomView:RightBtn];
    //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    self.navigationItem.rightBarButtonItem = btn1;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*.12, screenRect.size.width, screenRect.size.height*0.06)];
//    [scrollView setBackgroundColor:[UIColor greenColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.view addSubview:scrollView];
    //scrollView.contentSize= CGSizeMake(350,0);
    //[self createScrollMenu];
    
   // topnewsArray=[[NSMutableArray alloc]init];
//    TopNewsVO *topnewVO=[[TopNewsVO alloc]init];
//    topnewVO.title=[[NSString alloc]init];
//    topnewVO.descriprions=[[NSString alloc]init];
//    topnewVO.title=@"EU informs of intentions to file objections on halloumi PDO application";
//    topnewVO.descriprions=@"European Commission informed Cyprus about three intentions to file objections on its application to file halloumi as a product with protected designation of origin (PDO), while at least another one is expected according to Famagusta Gazette today.";
//    [topnewsArray addObject:topnewVO];
//    
//    TopNewsVO *topnewVO1=[[TopNewsVO alloc]init];
//    topnewVO1.title=[[NSString alloc]init];
//    topnewVO1.descriprions=[[NSString alloc]init];
//    topnewVO1.title=@"GC Minister announces new Cypriot airliner in a couple of months";
//    topnewVO1.descriprions=@"According to reports in GC press, GC Communications Minister Demetriades has said that a new Cypriot airliner will be operational after a couple of months.";
//    [topnewsArray addObject:topnewVO1];
//    
//    TopNewsVO *topnewVO2=[[TopNewsVO alloc]init];
//    topnewVO2.title=[[NSString alloc]init];
//    topnewVO2.descriprions=[[NSString alloc]init];
//    topnewVO2.title=@"Only 12 out of 115 refugees who arrived in Akrotiri apply for asylum";
//    topnewVO2.descriprions=@"Only 12 refugees out of 115 who arrived in Akrotiri last week have indicated interest to apply for asylum, according to report in GC press.";
//    [topnewsArray addObject:topnewVO2];
//    
//    TopNewsVO *topnewVO3=[[TopNewsVO alloc]init];
//    topnewVO3.title=[[NSString alloc]init];
//    topnewVO3.descriprions=[[NSString alloc]init];
//    topnewVO3.title=@"Akansoy said he did not become a minister in order to 'mess around'";
//    topnewVO3.descriprions=@"Newly appointed Interior Minister Asim Akansoy who spoke to Vatan Mehmet at KIBRIS POSTASI first said that he did not become a minister in order";
//    [topnewsArray addObject:topnewVO3];
//    
//    TopNewsVO *topnewVO4=[[TopNewsVO alloc]init];
//    topnewVO4.title=[[NSString alloc]init];
//    topnewVO4.descriprions=[[NSString alloc]init];
//    topnewVO4.title=@"Akinci says peaceful modern island will help Turkey to achieve its goals";
//    topnewVO4.descriprions=@"President Akinci has said that a peaceful, modern, European and international Cyprus would ease international relations for Turkey and help it achieve its global goals.";
//    [topnewsArray addObject:topnewVO4];

    
    tableViewMain=[[UITableView alloc]init];
    tableViewMain.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height);
    tableViewMain.dataSource = self;
    tableViewMain.delegate = self;
    [tableViewMain setBackgroundColor:[UIColor clearColor]];
    self.tableViewMain.separatorColor = [UIColor clearColor];
    tableViewMain.separatorInset = UIEdgeInsetsZero;
    tableViewMain.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:tableViewMain];
    
    serachArray=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *urlString=[prefs objectForKey:@"SWACC"];
    if ( !appDelegate.getuserList) {

        if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            commonUrl=[[NSString alloc]init];
            commonUrl=@"USERLIST";
            [self performSelector:@selector(getSearchUserList1) withObject:nil afterDelay:1.0 ];
        }else{
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            [self performSelector:@selector(getSearchUserList) withObject:nil afterDelay:1.0 ];
        }
    }
    
    
}

-(void)settingAction{
//    MenuViewController *epl=[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
//    [self.navigationController pushViewController:epl animated:NO];
//    ChatUserListViewController *userList=[[ChatUserListViewController alloc] initWithNibName:@"ChatUserListViewController" bundle:nil];
//    [self.navigationController pushViewController:userList animated:NO];

    ProfileViewController *userList=[[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    [self.navigationController pushViewController:userList animated:NO];
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
        //[topnewsBtn addTarget:self action:@selector(dayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:listserveBtn];

    x += screenRect.size.width*0.70;

        eplBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,0,screenRect.size.width*0.20,screenRect.size.height*0.05)];
        [eplBtn setTitle:@"EPL" forState:UIControlStateNormal];
        eplBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [eplBtn setTitleColor:[UIColor colorWithHexString:@"ABA6A3"] forState:UIControlStateNormal];
        [eplBtn setBackgroundColor:[UIColor colorWithHexString:@"F8F4F1"]];
        [eplBtn.titleLabel setFont:font1];
        //[topnewsBtn addTarget:self action:@selector(dayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:eplBtn];

        x += screenRect.size.width*0.20;

        titleBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,0,screenRect.size.width*0.30,screenRect.size.height*0.05)];
        [titleBtn setTitle:@"Title IX" forState:UIControlStateNormal];
        titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [titleBtn setTitleColor:[UIColor colorWithHexString:@"ABA6A3"] forState:UIControlStateNormal];
        [titleBtn setBackgroundColor:[UIColor colorWithHexString:@"F8F4F1"]];
        [titleBtn.titleLabel setFont:font1];
        //[topnewsBtn addTarget:self action:@selector(dayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:titleBtn];

        x += screenRect.size.width*0.30;

        contactBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,0,screenRect.size.width*0.60,screenRect.size.height*0.05)];
        [contactBtn setTitle:@"Member Contact Info" forState:UIControlStateNormal];
        contactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [contactBtn setTitleColor:[UIColor colorWithHexString:@"ABA6A3"] forState:UIControlStateNormal];
        [contactBtn setBackgroundColor:[UIColor colorWithHexString:@"F8F4F1"]];
        [contactBtn.titleLabel setFont:font1];
        //[topnewsBtn addTarget:self action:@selector(dayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:contactBtn];

        x += screenRect.size.width*0.80;
    
    scrollView.contentSize = CGSizeMake(x,0);
    scrollView.backgroundColor = [UIColor colorWithHexString:@"F8F4F1"];
    [self.view addSubview:scrollView];
}

-(void)topnewsAction{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, topnewsBtn.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor redColor];
    [topnewsBtn addSubview:lineView];
}

#pragma marl - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appDelegate.topnewsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *NameLbl,*lineLbl;
    TopNewsVO *topnewVO=[appDelegate.topnewsArray objectAtIndex:indexPath.row];

    UIFont * font1 =[UIFont fontWithName:@"OpenSans-Bold" size:16.0f];
    UIFont * font2 =[UIFont fontWithName:@"Open Sans" size:14.0f];

    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor=[UIColor whiteColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIImageView *  logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,15,screenRect.size.width*.12,screenRect.size.width*.12)];
    [logoImg setImage:[UIImage imageNamed:@"news-01.jpg"]];
    logoImg.layer.cornerRadius = logoImg.frame.size.width / 2;
    logoImg.clipsToBounds = YES;
    logoImg.layer.borderWidth = 1.5f;
    logoImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [cell.contentView addSubview:logoImg];
    
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*.005, screenRect.size.width*.78,screenRect.size.height*.05)];
    [titleLbl setText:[NSString stringWithFormat:@"%@",topnewVO.title]];
    titleLbl.font=font1;
    [titleLbl setTextColor:[UIColor blackColor]];
    titleLbl.lineBreakMode = NSLineBreakByWordWrapping;
    [cell.contentView addSubview:titleLbl];
    
    UILabel *descriptionLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*.06, screenRect.size.width*.78,screenRect.size.height*.08)];
    [descriptionLbl setText:[NSString stringWithFormat:@"%@",topnewVO.descriprions]];
    descriptionLbl.font=font2;
    [descriptionLbl setTextColor:[UIColor blackColor]];
    descriptionLbl.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionLbl.numberOfLines = 0;
    descriptionLbl.clipsToBounds = YES;
    [cell.contentView addSubview:descriptionLbl];
    
    lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.145, screenRect.size.width*0.90,1)];
    [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
    [cell.contentView addSubview:lineLbl];
    
    tableView.backgroundColor=[UIColor clearColor];
    [cell setBackgroundColor:[UIColor clearColor]];
    //Your main thread code goes in here
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopNewsViewController * topnews;
    topnews= [[TopNewsViewController alloc] initWithNibName:@"TopNewsViewController" bundle:nil];
    TopNewsVO *topnewVO=[appDelegate.topnewsArray objectAtIndex:indexPath.row];
    topnews.topnewsVO=[[TopNewsVO alloc]init];
    topnews.topnewsVO=topnewVO;
    [self.navigationController pushViewController:topnews animated:YES];
}

-(void)getGroupList
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:[prefs objectForKey:@"NOINTERNET"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityImageView removeFromSuperview];
    }else{
        serachArray=[[NSMutableArray alloc]init];
        NSURL *url;
        NSMutableString *httpBodyString;
        NSString *urlString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSMutableURLRequest *urlRequest;
        NSString *urlString1=[prefs objectForKey:@"SWACC"];
        if ([urlString1 isEqualToString:@"http://192.168.0.37/swacc/"]) {
            httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@",[prefs objectForKey:@"user_id"]]];
            urlString = [[NSString alloc]initWithFormat:@"%@wsGetGroups.php",[prefs objectForKey:@"SWACC"]];
            url=[[NSURL alloc] initWithString:urlString];
            urlRequest=[NSMutableURLRequest requestWithURL:url];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        }else{
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[prefs objectForKey:@"user_id"] forKey:@"user_id"];
            //convert object to data
            NSError *error;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
            
            urlRequest = [[NSMutableURLRequest alloc] init];
            [urlRequest setURL:[NSURL URLWithString:@"https://stg.benefitbridge.com/swacc/api/groups"]];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [urlRequest setHTTPBody:jsonData];
        }

        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error)
            {
                [activityImageView removeFromSuperview];
                NSLog(@"Failed to submit request");
            }
            else
            {
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                
                NSError *error;
                if ([content isEqualToString:@""]) {
                    [activityImageView removeFromSuperview];
                    //                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //                        [alert show];
                }else {
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    NSString *result = [[NSString alloc]init];
                    result =[userDict objectForKey:@"result"];
                    NSString *message = [[NSString alloc]init];
                    message = [userDict objectForKey:@"message"];
                    int boolValue =[result intValue];
                    if (boolValue==0) {
                        [activityImageView removeFromSuperview];
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [alert show];
                        
                    }else if (boolValue==1){
                        NSArray *userArray;
                        userArray = [userDict objectForKey:@"message"];
                        
                        for (int count=0; count<[userArray count]; count++){
                            NSDictionary *activityData=[userArray objectAtIndex:count];
                            MessageVO *msgvo=[[MessageVO alloc]init];
                            msgvo.senderID=[[NSString alloc]init];
                            msgvo.username=[[NSString alloc]init];
                            msgvo.profile=[[NSString alloc]init];
                            msgvo.chatid=[[NSString alloc]init];
                            msgvo.message=[[NSString alloc]init];
                            msgvo.msg_Date=[[NSString alloc]init];
                            msgvo.unreadMsg=[[NSString alloc]init];
                            msgvo.attachment=[[NSString alloc]init];

                            if ([activityData objectForKey:@"group_id"] != [NSNull null])
                                msgvo.senderID=[activityData objectForKey:@"group_id"];
                            
                            if ([activityData objectForKey:@"group_name"] != [NSNull null])
                                msgvo.username=[activityData objectForKey:@"group_name"];
                            
                            if ([activityData objectForKey:@"group_profile_pic"] != [NSNull null])
                                msgvo.profile=[activityData objectForKey:@"group_profile_pic"];
                            
//                            if ([activityData objectForKey:@"chat_id"] != [NSNull null])
//                                msgvo.chatid=[activityData objectForKey:@"chat_id"];
                            
                            if (![msgvo.profile isEqualToString:@""]) {
                                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msgvo.profile]]];
                                NSData *ImageDatas = UIImageJPEGRepresentation(image,0.1);
                                NSString *imgStr=[[NSString alloc]init];
                                imgStr=  [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                                NSString* imgkeyStr=[NSString stringWithFormat:@"%@_%@",msgvo.senderID,@"Group"];
                                [prefs setObject:imgStr forKey:imgkeyStr];
                            }
                            
//                            if ([activityData objectForKey:@"attachment"] != [NSNull null])
//                                msgvo.attachment=[activityData objectForKey:@"attachment"];

                            BOOL trueV=NO;
                            NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
                            serachArray=[self ToListss:[prefs objectForKey:keyStr] : false];
                            for (int count=0; count<[serachArray  count]; count++){
                                MessageVO *msgvos=[serachArray objectAtIndex:count];
                                NSLog(@"msgvos sender print %@",msgvos.senderID);
                                if ([msgvo.senderID isEqualToString:msgvos.senderID]) {
                                    trueV=YES;
                                    break;
                                }else{
                                    trueV=NO;
                                }
                            }

                            if (!trueV) {
                                [serachArray addObject:msgvo];
                            }
                           
                            [prefs setObject:[self ToStringss:serachArray] forKey:keyStr];
                            //[activityImageView removeFromSuperview];
                        }
                        //[activityImageView removeFromSuperview];
                        [self getTopnewslist];
                    }
                }
            }
        }];
    }
}
-(void)getTopnewslist
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:[prefs objectForKey:@"NOINTERNET"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityImageView removeFromSuperview];
    }else{
        serachArray=[[NSMutableArray alloc]init];
        NSURL *url;
        NSMutableString *httpBodyString;
        NSString *urlString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSMutableURLRequest *urlRequest;
        NSString *urlString1=[prefs objectForKey:@"SWACC"];
        if ([urlString1 isEqualToString:@"http://192.168.0.37/swacc/"]) {
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@""]];
        urlString = [[NSString alloc]initWithFormat:@"%@wsGetTopNews.php",[prefs objectForKey:@"SWACC"]];
        url=[[NSURL alloc] initWithString:urlString];
        urlRequest=[NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        }
        else
        {
            urlRequest = [[NSMutableURLRequest alloc] init];
            //[request setURL:[NSURL URLWithString:@"http://192.168.0.192:9810/api/IdCard/UpdateImages"]];
            [urlRequest setURL:[NSURL URLWithString:@"https://stg.benefitbridge.com/swacc/api/news"]];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            //[urlRequest setHTTPBody:jsonData];
        }
        

        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error)
            {
                [activityImageView removeFromSuperview];
                NSLog(@"Failed to submit request");
            }
            else
            {
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                
                NSError *error;
                if ([content isEqualToString:@""]) {
                    [activityImageView removeFromSuperview];
                    //                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //                        [alert show];
                }else {
                    NSMutableArray *topnewsArray1=[[NSMutableArray alloc]init];
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    NSString *result = [[NSString alloc]init];
                    result =[userDict objectForKey:@"result"];
                    NSString *message = [[NSString alloc]init];
                    message = [userDict objectForKey:@"message"];
                    int boolValue =[result intValue];
                    if (boolValue==0) {
                        [activityImageView removeFromSuperview];
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [alert show];
                        
                    }else if (boolValue==1){
                        NSArray *userArray;
                        userArray = [userDict objectForKey:@"message"];
                        
                        for (int count=0; count<[userArray count]; count++){
                            NSDictionary *activityData=[userArray objectAtIndex:count];
                            TopNewsVO *topVO=[[TopNewsVO alloc]init];
                            topVO.news_id=[[NSString alloc]init];
                            topVO.title=[[NSString alloc]init];
                            topVO.descriprions=[[NSString alloc]init];
                            topVO.publisDate=[[NSString alloc]init];
                            topVO.expireDate=[[NSString alloc]init];
                            
                            if ([activityData objectForKey:@"news_id"] != [NSNull null])
                                topVO.news_id=[activityData objectForKey:@"news_id"];
                            
                            if ([activityData objectForKey:@"news_title"] != [NSNull null])
                                topVO.title=[activityData objectForKey:@"news_title"];
                            
                            if ([activityData objectForKey:@"news_contents"] != [NSNull null])
                                topVO.descriprions=[activityData objectForKey:@"news_contents"];
                            
                            if ([activityData objectForKey:@"pub_date"] != [NSNull null])
                                topVO.publisDate=[activityData objectForKey:@"pub_date"];
                            
                            if ([activityData objectForKey:@"exp_date"] != [NSNull null])
                                topVO.expireDate=[activityData objectForKey:@"exp_date"];
                            
                            [topnewsArray1 addObject:topVO];
                        }
                        
                        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"publisDate"
                                                                                   ascending:NO];
                        NSArray *descriptors = [NSArray arrayWithObject:descriptor];
                        NSArray *reverseOrder = [topnewsArray1 sortedArrayUsingDescriptors:descriptors];
                        appDelegate.topnewsArray=[[NSMutableArray alloc]init];
                        appDelegate.topnewsArray=[reverseOrder mutableCopy];
                        
                        [tableViewMain reloadData];
                        [activityImageView removeFromSuperview];
                    }
                }
            }
        }];
    }
}

-(NSMutableArray *)ToListss :(NSString *)Strs  : (BOOL)ischat{
    NSString *seprator=@"%!@#%";
    if (![Strs isEqualToString:@""]) {
        NSArray* commonFields = [Strs componentsSeparatedByString:seprator];
        NSMutableArray *muArray=[[NSMutableArray alloc]init];
        for (int count=0; count<[commonFields count]; count++){
                [muArray addObject:[self StrtoObj:[commonFields objectAtIndex:count]]];
        }
        return muArray;
    }
    return 0;
}

-(MessageVO *)StrtoObj :(NSString *)str  {
    MessageVO * msgvo=[[MessageVO alloc]init];
    NSString *seprator=@"%=";
    NSArray* commonFields = [str componentsSeparatedByString:seprator];
    for (int co=0; co<[commonFields count]; co++) {
        msgvo.senderID=[[NSString alloc]init];
        msgvo.username=[[NSString alloc]init];
        msgvo.profile=[[NSString alloc]init];
        msgvo.chatid=[[NSString alloc]init];
        msgvo.message=[[NSString alloc]init];
        msgvo.msg_Date=[[NSString alloc]init];
        msgvo.unreadMsg=[[NSString alloc]init];
        msgvo.attachment=[[NSString alloc]init];
        msgvo.senderID=[commonFields objectAtIndex:0];
        if ([msgvo.senderID rangeOfString:@"U_"].location == NSNotFound) {
            if ([commonFields count]>3) {
                msgvo.username=[commonFields objectAtIndex:1];
                msgvo.chatid=[commonFields objectAtIndex:2];
                msgvo.message=[commonFields objectAtIndex:3];
                msgvo.msg_Date=[commonFields objectAtIndex:4];
                msgvo.unreadMsg=[commonFields objectAtIndex:5];
                msgvo.profile=[commonFields objectAtIndex:6];
                msgvo.attachment=[commonFields objectAtIndex:7];

            }else{
                msgvo.username=[commonFields objectAtIndex:1];
                msgvo.profile=[commonFields objectAtIndex:2];
            }
        }else{
            msgvo.username=[commonFields objectAtIndex:1];
            msgvo.chatid=[commonFields objectAtIndex:2];
            msgvo.message=[commonFields objectAtIndex:3];
            msgvo.msg_Date=[commonFields objectAtIndex:4];
            msgvo.unreadMsg=[commonFields objectAtIndex:5];
            msgvo.profile=[commonFields objectAtIndex:6];
            msgvo.attachment=[commonFields objectAtIndex:7];
        }
        
    }
    return msgvo;
}

-(void)getGrouplist1{
    commonUrl=@"GROUPLIST";
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@",[prefs objectForKey:@"user_id"]]];
    urlString = [[NSString alloc]initWithFormat:@"%@wsGetGroups.php",[prefs objectForKey:@"SWACC"]];
    url=[[NSURL alloc] initWithString:urlString];
    rest_url=url;
    NSData *postData = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connections = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connections start];
}

-(void)getSearchUserList
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:[prefs objectForKey:@"NOINTERNET"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityImageView removeFromSuperview];
    }else{
        NSURL *url;
        NSMutableString *httpBodyString;
        NSString *urlString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSMutableURLRequest *urlRequest;
        NSString *urlString1=[prefs objectForKey:@"SWACC"];
        if ([urlString1 isEqualToString:@"http://192.168.0.37/swacc/"]) {
            httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@",[prefs objectForKey:@"user_id"]]];
            urlString = [[NSString alloc]initWithFormat:@"%@wsGetAllUsers.php",[prefs objectForKey:@"SWACC"]];
            url=[[NSURL alloc] initWithString:urlString];
            urlRequest=[NSMutableURLRequest requestWithURL:url];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        }else{
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[prefs objectForKey:@"user_id"] forKey:@"user_id"];
            //convert object to data
            NSError *error;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
            
            urlRequest = [[NSMutableURLRequest alloc] init];
            [urlRequest setURL:[NSURL URLWithString:@"https://stg.benefitbridge.com/swacc/api/user/getall"]];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [urlRequest setHTTPBody:jsonData];
        }

        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error)
            {
                [activityImageView removeFromSuperview];
                NSLog(@"Failed to submit request");
            }
            else
            {
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                
                NSError *error;
                if ([content isEqualToString:@""]) {
                    [activityImageView removeFromSuperview];
                    //                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //                        [alert show];
                }else {
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    NSString *result = [[NSString alloc]init];
                    result =[userDict objectForKey:@"result"];
                    NSString *message = [[NSString alloc]init];
                    message = [userDict objectForKey:@"message"];
                    int boolValue =[result intValue];
                    if (boolValue==0) {
                        [activityImageView removeFromSuperview];
//                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                        
//                        [alert show];
                        
                    }else if (boolValue==1){
                        NSArray *userArray;
                        userArray = [userDict objectForKey:@"message"];
                        
                        for (int count=0; count<[userArray count]; count++){
                            NSDictionary *activityData=[userArray objectAtIndex:count];
                            MessageVO *msgvo=[[MessageVO alloc]init];
                            msgvo.senderID=[[NSString alloc]init];
                            msgvo.username=[[NSString alloc]init];
                            msgvo.profile=[[NSString alloc]init];
                            msgvo.chatid=[[NSString alloc]init];
                            msgvo.message=[[NSString alloc]init];
                            msgvo.msg_Date=[[NSString alloc]init];
                            msgvo.unreadMsg=[[NSString alloc]init];
                            msgvo.attachment=[[NSString alloc]init];

                            if ([activityData objectForKey:@"user_id"] != [NSNull null])
                                msgvo.senderID=[activityData objectForKey:@"user_id"];
                            
                            if ([activityData objectForKey:@"name"] != [NSNull null])
                                msgvo.username=[activityData objectForKey:@"name"];
                            
                            if ([activityData objectForKey:@"profile_picture"] != [NSNull null])
                                msgvo.profile=[activityData objectForKey:@"profile_picture"];
                            
                            if ([activityData objectForKey:@"chat_id"] != [NSNull null])
                                msgvo.chatid=[activityData objectForKey:@"chat_id"];

                            if (![msgvo.profile isEqualToString:@""]) {
                                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msgvo.profile]]];
                                NSData *ImageDatas = UIImageJPEGRepresentation(image,0.1);
                                NSString *imgStr=[[NSString alloc]init];
                                imgStr=  [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                                NSString* imgkeyStr=[NSString stringWithFormat:@"%@_%@",msgvo.senderID,@"ProfileImage"];
                                [prefs setObject:imgStr forKey:imgkeyStr];
                            }
                                [serachArray addObject:msgvo];
                            
                            
                            NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Search"];
                            [prefs setObject:[self ToStringss:serachArray] forKey:keyStr];

                        //[activityImageView removeFromSuperview];
                            
                        }
                        [self getGroupList];
                    }
                }
            }
        }];
    }
}
-(void)getSearchUserList1{
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@",[prefs objectForKey:@"user_id"]]];
    urlString = [[NSString alloc]initWithFormat:@"%@wsGetAllUsers.php",[prefs objectForKey:@"SWACC"]];
    url=[[NSURL alloc] initWithString:urlString];
    rest_url=url;
    NSData *postData = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connections = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connections start];
}
-(void)getTopnews{
    commonUrl=@"Topnews";

    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@""]];
    urlString = [[NSString alloc]initWithFormat:@"%@wsGetTopNews.php",[prefs objectForKey:@"SWACC"]];
    url=[[NSURL alloc] initWithString:urlString];
    rest_url=url;
    NSData *postData = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connections = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connections start];
}

-(NSString *)ToStringss :(NSMutableArray *)mutableArray {
    NSString *seprator=@"%!@#%";
    NSString *str=[[NSString alloc]init];
    for (int count=0; count<[mutableArray count]; count++){
            NSString *app_str=[seprator stringByAppendingString:[self objToStr:[mutableArray objectAtIndex:count]]];
            if(count==0)
                str= [str stringByAppendingString:[self objToStr:[mutableArray objectAtIndex:count]]];
            else
                str= [str stringByAppendingString:app_str];
    }
    NSLog(@"String %@",str);
    return str;
}

-(NSString *)objToStr :(MessageVO *)msgvo {
    NSString *str=[[NSString alloc]init];
    NSString *seprator=@"%=";
    str=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",msgvo.senderID,seprator,msgvo.username,seprator,msgvo.chatid,seprator,msgvo.message,seprator,msgvo.msg_Date,seprator,msgvo.unreadMsg,seprator,msgvo.profile,seprator,msgvo.attachment];
    
    
    return str;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"WE Got %@ :)",dic);
    NSString *result = [[NSString alloc]init];
    result =[dic objectForKey:@"result"];
    NSString *message = [[NSString alloc]init];
    message = [dic objectForKey:@"message"];
    int boolValue =[result intValue];
    if (boolValue==0) {
        [activityImageView removeFromSuperview];
        //        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
    }else if (boolValue==1){
        NSArray *userArray;
        userArray = [dic objectForKey:@"message"];
        if ([commonUrl isEqualToString:@"Topnews"]) {
            NSMutableArray *topnewsArray1=[[NSMutableArray alloc]init];
            [activityImageView removeFromSuperview];
            for (int count=0; count<[userArray count]; count++){
                NSDictionary *activityData=[userArray objectAtIndex:count];
                TopNewsVO *topVO=[[TopNewsVO alloc]init];
                topVO.news_id=[[NSString alloc]init];
                topVO.title=[[NSString alloc]init];
                topVO.descriprions=[[NSString alloc]init];
                topVO.publisDate=[[NSString alloc]init];
                topVO.expireDate=[[NSString alloc]init];
                
                if ([activityData objectForKey:@"news_id"] != [NSNull null])
                    topVO.news_id=[activityData objectForKey:@"news_id"];

                    if ([activityData objectForKey:@"news_title"] != [NSNull null])
                        topVO.title=[activityData objectForKey:@"news_title"];
                    
                    if ([activityData objectForKey:@"news_contents"] != [NSNull null])
                        topVO.descriprions=[activityData objectForKey:@"news_contents"];
                    
                    if ([activityData objectForKey:@"pub_date"] != [NSNull null])
                        topVO.publisDate=[activityData objectForKey:@"pub_date"];
                
                    if ([activityData objectForKey:@"exp_date"] != [NSNull null])
                    topVO.expireDate=[activityData objectForKey:@"exp_date"];

                    [topnewsArray1 addObject:topVO];
            }
            

            NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"publisDate"
                                                                       ascending:NO];
            NSArray *descriptors = [NSArray arrayWithObject:descriptor];
            NSArray *reverseOrder = [topnewsArray1 sortedArrayUsingDescriptors:descriptors];
            appDelegate.topnewsArray=[[NSMutableArray alloc]init];
            appDelegate.topnewsArray=[reverseOrder mutableCopy];

            [tableViewMain reloadData];
        }else{
        for (int count=0; count<[userArray count]; count++){
            NSDictionary *activityData=[userArray objectAtIndex:count];
            MessageVO *msgvo=[[MessageVO alloc]init];
            msgvo.senderID=[[NSString alloc]init];
            msgvo.username=[[NSString alloc]init];
            msgvo.profile=[[NSString alloc]init];
            msgvo.chatid=[[NSString alloc]init];
            msgvo.message=[[NSString alloc]init];
            msgvo.msg_Date=[[NSString alloc]init];
            msgvo.unreadMsg=[[NSString alloc]init];
            msgvo.attachment=[[NSString alloc]init];

            if ([commonUrl isEqualToString:@"USERLIST"]) {

            if ([activityData objectForKey:@"user_id"] != [NSNull null])
                msgvo.senderID=[activityData objectForKey:@"user_id"];
            
            if ([activityData objectForKey:@"name"] != [NSNull null])
                msgvo.username=[activityData objectForKey:@"name"];
            
            if ([activityData objectForKey:@"profile_picture"] != [NSNull null])
                msgvo.profile=[activityData objectForKey:@"profile_picture"];
            }else{
                if ([activityData objectForKey:@"group_id"] != [NSNull null])
                    msgvo.senderID=[activityData objectForKey:@"group_id"];
                
                if ([activityData objectForKey:@"group_name"] != [NSNull null])
                    msgvo.username=[activityData objectForKey:@"group_name"];
                
                if ([activityData objectForKey:@"group_profile_pic"] != [NSNull null])
                    msgvo.profile=[activityData objectForKey:@"group_profile_pic"];

            }
            
            if (![msgvo.profile isEqualToString:@""]) {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msgvo.profile]]];
                NSData *ImageDatas = UIImageJPEGRepresentation(image,0.1);
                NSString *imgStr=[[NSString alloc]init];
                imgStr=  [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                if ([commonUrl isEqualToString:@"USERLIST"]) {
                NSString* imgkeyStr=[NSString stringWithFormat:@"%@_%@",msgvo.senderID,@"ProfileImage"];
                [prefs setObject:imgStr forKey:imgkeyStr];
                }else{
                    NSString* imgkeyStr=[NSString stringWithFormat:@"%@_%@",msgvo.senderID,@"Group"];
                    [prefs setObject:imgStr forKey:imgkeyStr];
                }
            }

            if ([commonUrl isEqualToString:@"USERLIST"]) {
                [serachArray addObject:msgvo];
            }else{
            BOOL trueV=NO;
            NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
            serachArray=[self ToListss:[prefs objectForKey:keyStr] : false];
            for (int count=0; count<[serachArray  count]; count++){
                MessageVO *msgvos=[serachArray objectAtIndex:count];
                NSLog(@"msgvos sender print %@",msgvos.senderID);
                if ([msgvo.senderID isEqualToString:msgvos.senderID]) {
                    trueV=YES;
                    break;
                }else{
                    trueV=NO;
                }
            }
            
            if (!trueV) {
                [serachArray addObject:msgvo];
            }
            
            [prefs setObject:[self ToStringss:serachArray] forKey:keyStr];
            [activityImageView removeFromSuperview];
        }

        
            if ([commonUrl isEqualToString:@"USERLIST"]) {
            NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Search"];
            [prefs setObject:[self ToStringss:serachArray] forKey:keyStr];
            }else{
                NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
                [prefs setObject:[self ToStringss:serachArray] forKey:keyStr];
            }
        }
        NSLog(@"array count %lu",(unsigned long)[serachArray count]);
        
        [activityImageView removeFromSuperview];
        
        if ([commonUrl isEqualToString:@"USERLIST"]) {
            serachArray=[[NSMutableArray alloc]init];
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            [self performSelector:@selector(getGrouplist1) withObject:nil afterDelay:1.0 ];
        }
            
            if ([commonUrl isEqualToString:@"GROUPLIST"]) {
                serachArray=[[NSMutableArray alloc]init];
                [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                [self performSelector:@selector(getTopnews) withObject:nil afterDelay:1.0 ];
            }

    }
    }
    
    else{

    }
}


- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSArray *obj=[[NSArray alloc]initWithObjects:rest_url, nil];
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        if ([obj containsObject:challenge.protectionSpace.host])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
}
-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust] &&
        ![challenge.protectionSpace.host hasSuffix:@"Login.php"])
    {
        // accept the certificate anyway
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    else
    {
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) threadStartAnimating:(id)data {
    UIImage *statusImage = [UIImage imageNamed:@"tmp-0.gif"];
    activityImageView = [[UIImageView alloc]
                         initWithImage:statusImage];
    
    [activityImageView setBackgroundColor:[UIColor colorWithHexString:@"923846"]];
    activityImageView.layer.cornerRadius=8.0f;
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"tmp-0.gif"],
                                         [UIImage imageNamed:@"tmp-1.gif"],
                                         [UIImage imageNamed:@"tmp-2.gif"],
                                         [UIImage imageNamed:@"tmp-3.gif"],
                                         [UIImage imageNamed:@"tmp-4.gif"],
                                         [UIImage imageNamed:@"tmp-5.gif"],
                                         [UIImage imageNamed:@"tmp-6.gif"],
                                         [UIImage imageNamed:@"tmp-7.gif"],
                                         [UIImage imageNamed:@"tmp-8.gif"],
                                         [UIImage imageNamed:@"tmp-9.gif"],
                                         [UIImage imageNamed:@"tmp-10.gif"],
                                         [UIImage imageNamed:@"tmp-11.gif"],
                                         [UIImage imageNamed:@"tmp-12.gif"],
                                         [UIImage imageNamed:@"tmp-13.gif"],
                                         [UIImage imageNamed:@"tmp-14.gif"],
                                         [UIImage imageNamed:@"tmp-15.gif"],
                                         [UIImage imageNamed:@"tmp-16.gif"],
                                         [UIImage imageNamed:@"tmp-17.gif"],
                                         [UIImage imageNamed:@"tmp-18.gif"],
                                         [UIImage imageNamed:@"tmp-19.gif"],
                                         [UIImage imageNamed:@"tmp-20.gif"],
                                         [UIImage imageNamed:@"tmp-21.gif"],
                                         [UIImage imageNamed:@"tmp-22.gif"],
                                         [UIImage imageNamed:@"tmp-23.gif"],
                                         [UIImage imageNamed:@"tmp-24.gif"],
                                         [UIImage imageNamed:@"tmp-25.gif"],
                                         [UIImage imageNamed:@"tmp-26.gif"],
                                         [UIImage imageNamed:@"tmp-27.gif"],
                                         [UIImage imageNamed:@"tmp-28.gif"],
                                         [UIImage imageNamed:@"tmp-29.gif"],
                                         [UIImage imageNamed:@"tmp-30.gif"],
                                         [UIImage imageNamed:@"tmp-31.gif"],
                                         [UIImage imageNamed:@"tmp-32.gif"],
                                         [UIImage imageNamed:@"tmp-33.gif"],
                                         [UIImage imageNamed:@"tmp-34.gif"],
                                         [UIImage imageNamed:@"tmp-35.gif"],
                                         [UIImage imageNamed:@"tmp-36.gif"],
                                         [UIImage imageNamed:@"tmp-37.gif"],
                                         [UIImage imageNamed:@"tmp-38.gif"],
                                         [UIImage imageNamed:@"tmp-39.gif"],
                                         [UIImage imageNamed:@"tmp-40.gif"],
                                         [UIImage imageNamed:@"tmp-41.gif"],
                                         [UIImage imageNamed:@"tmp-42.gif"],
                                         [UIImage imageNamed:@"tmp-43.gif"],
                                         [UIImage imageNamed:@"tmp-44.gif"],
                                         [UIImage imageNamed:@"tmp-45.gif"],
                                         [UIImage imageNamed:@"tmp-46.gif"],
                                         [UIImage imageNamed:@"tmp-47.gif"],
                                         [UIImage imageNamed:@"tmp-48.gif"],
                                         [UIImage imageNamed:@"tmp-49.gif"],
                                         [UIImage imageNamed:@"tmp-50.gif"],
                                         [UIImage imageNamed:@"tmp-51.gif"],
                                         [UIImage imageNamed:@"tmp-52.gif"],
                                         [UIImage imageNamed:@"tmp-53.gif"],
                                         [UIImage imageNamed:@"tmp-54.gif"],
                                         [UIImage imageNamed:@"tmp-55.gif"],
                                         [UIImage imageNamed:@"tmp-56.gif"],
                                         [UIImage imageNamed:@"tmp-57.gif"],
                                         [UIImage imageNamed:@"tmp-58.gif"],
                                         [UIImage imageNamed:@"tmp-59.gif"], nil];
    
    activityImageView.animationDuration = 1.5;
    activityImageView.frame = CGRectMake(
                                         self.view.frame.size.width/2
                                         -35,
                                         self.view.frame.size.height/2
                                         -35,70,
                                         70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
    //[self LoginGoBtnClicks];
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
