//
//  ChatUserListViewController.m
//  SWACC
//
//  Created by Infinitum on 16/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import "ChatUserListViewController.h"
#import "MessageChatViewController.h"
#import "UIColor+Expanded.h"
#import "MainViewController.h"
#import "MessageVO.h"
#import "Reachability.h"
#import "ChatVO.h"
@interface ChatUserListViewController ()


@end

@implementation ChatUserListViewController
{
    NSMutableArray *notif;
}

@synthesize userListArray,groupListArray,appDelegate,searchBar,navigationView,activityImageView,StrMain,userlistTableView,chatStrMain,msgListArray,lineView,msgLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"Listserv Communication"];
    [titleLabel setTextColor: [UIColor whiteColor]];
    titleLabel.font =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.hidesBackButton=YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#851c2b"];

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

    UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [RightBtn setFrame:CGRectMake(0, 0,30,30)];
    [RightBtn addTarget:self action:@selector(SearchAction:) forControlEvents:UIControlEventTouchUpInside];
    [RightBtn setBackgroundImage:[UIImage imageNamed:@"search_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithCustomView:RightBtn];
    //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    self.navigationItem.rightBarButtonItem = btn1;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:14.0f];
    int x = 0;

    
    UIButton *chatsBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,screenRect.size.height*0.11,screenRect.size.width*0.33,screenRect.size.height*0.06)];
    [chatsBtn setTitle:@"Messages " forState:UIControlStateNormal];
    chatsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [chatsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chatsBtn setBackgroundColor:[UIColor colorWithHexString:@"851c2b"]];
    [chatsBtn.titleLabel setFont:font1];
    [chatsBtn addTarget:self action:@selector(chatAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chatsBtn];
    

    x += screenRect.size.width*0.33;

    UIButton * groupBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,screenRect.size.height*0.11,screenRect.size.width*0.33,screenRect.size.height*0.06)];
    [groupBtn setTitle:@"Groups" forState:UIControlStateNormal];
    groupBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [groupBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [groupBtn setBackgroundColor:[UIColor colorWithHexString:@"851c2b"]];
    [groupBtn.titleLabel setFont:font1];
    [groupBtn addTarget:self action:@selector(groupAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:groupBtn];
    
    x += screenRect.size.width*0.33;
    
    UIButton * mycontactBtn=[[UIButton alloc]initWithFrame:CGRectMake(x,screenRect.size.height*0.11,screenRect.size.width*0.345,screenRect.size.height*0.06)];
    [mycontactBtn setTitle:@"My Contacts" forState:UIControlStateNormal];
    mycontactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [mycontactBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mycontactBtn setBackgroundColor:[UIColor colorWithHexString:@"851c2b"]];
    [mycontactBtn.titleLabel setFont:font1];
    [mycontactBtn addTarget:self action:@selector(mycontactAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mycontactBtn];

    
    StrMain=[[NSString alloc]init];
    chatStrMain=[[NSString alloc]init];
    msgListArray=[[NSMutableArray alloc]init];
    userlistTableView=[[UITableView alloc]init];
    userlistTableView.frame=CGRectMake(0,screenRect.size.height*0.18,screenRect.size.width,screenRect.size.height*.82);
    [userlistTableView removeFromSuperview];
    userlistTableView.dataSource = self;
    userlistTableView.delegate = self;
    [userlistTableView setBackgroundColor:[UIColor clearColor]];
    userlistTableView.separatorInset = UIEdgeInsetsZero;
    userlistTableView.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:userlistTableView];
    
    
    if ([appDelegate.pushStr isEqualToString:@"yes"] && appDelegate.getuserList) {
        appDelegate.pushStr=@"no";
        MessageChatViewController * msgChat;
        msgChat= [[MessageChatViewController alloc] initWithNibName:@"MessageChatViewController" bundle:nil];
        msgChat.MsgVO=[[MessageVO alloc]init];
        msgChat.MsgVO=appDelegate.MSGVO;
        [self.navigationController pushViewController:msgChat animated:YES];

    }
    appDelegate.tabStr=[[NSString alloc]init];
    appDelegate.tabStr=@"Chats";

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:[prefs objectForKey:@"user_id"] object:nil];
}
-(void)chatAction{
    [navigationView removeFromSuperview];
    appDelegate.tabStr=@"Chats";
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [lineView removeFromSuperview];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, screenRect.size.height*0.17, screenRect.size.width*0.33, 2)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"03687f"];
    [self.view addSubview:lineView];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *oldStr=[prefs objectForKey:[prefs objectForKey:@"user_id"]];
    userListArray=[[NSMutableArray alloc]init];
    if(oldStr!=nil)
        userListArray=[self ToListss:oldStr :false];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                               ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [userListArray sortedArrayUsingDescriptors:descriptors];
    userListArray=[[NSMutableArray alloc]init];
    userListArray=[reverseOrder mutableCopy];
    filteredContentList=[[NSMutableArray alloc]init];
    filteredContentList=[userListArray mutableCopy];
    [userlistTableView reloadData];
    if ([userListArray count]>0) {
        [msgLbl removeFromSuperview];
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        [msgLbl removeFromSuperview];
        msgLbl = [[UILabel alloc] init];
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15, screenRect.size.width*0.90, 60)];
        msgLbl.textAlignment = NSTextAlignmentCenter;
        msgLbl.text=@"No records found";
        [msgLbl setTextColor: [UIColor blackColor]];
        UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
        msgLbl.font=font1s;
        [self.view addSubview:msgLbl];
    }
}
-(void)groupAction{
    [navigationView removeFromSuperview];
    appDelegate.tabStr=@"Groups";
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [lineView removeFromSuperview];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.33, screenRect.size.height*0.17, screenRect.size.width*0.33, 2)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"03687f"];
    [self.view addSubview:lineView];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
    NSString *oldStr=[prefs objectForKey:keyStr];
    userListArray=[[NSMutableArray alloc]init];
    if(oldStr!=nil)
        userListArray=[self ToListss:oldStr :false];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                               ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [userListArray sortedArrayUsingDescriptors:descriptors];
    userListArray=[[NSMutableArray alloc]init];
    userListArray=[reverseOrder mutableCopy];
    filteredContentList=[[NSMutableArray alloc]init];
    filteredContentList=[userListArray mutableCopy];
    [userlistTableView reloadData];
    [userlistTableView reloadData];
    if ([userListArray count]>0) {
        [msgLbl removeFromSuperview];
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        [msgLbl removeFromSuperview];
        msgLbl = [[UILabel alloc] init];
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15, screenRect.size.width*0.90, 60)];
        msgLbl.textAlignment = NSTextAlignmentCenter;
        msgLbl.text=@"No records found";
        [msgLbl setTextColor: [UIColor blackColor]];
        UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
        msgLbl.font=font1s;
        [self.view addSubview:msgLbl];
    }
}
-(void)mycontactAction{
    [navigationView removeFromSuperview];
    appDelegate.tabStr=@"Contacts";
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [lineView removeFromSuperview];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.66, screenRect.size.height*0.17, screenRect.size.width*0.34, 2)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"03687f"];
    [self.view addSubview:lineView];
    userListArray=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Search"];
    NSString *oldStr=[prefs objectForKey:keyStr];
    userListArray=[self ToListss:oldStr :false];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                               ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [userListArray sortedArrayUsingDescriptors:descriptors];
    userListArray=[[NSMutableArray alloc]init];
    userListArray=[reverseOrder mutableCopy];
    filteredContentList=[[NSMutableArray alloc]init];
    filteredContentList=[userListArray mutableCopy];
    [userlistTableView reloadData];
    if ([userListArray count]>0) {
        [msgLbl removeFromSuperview];
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        [msgLbl removeFromSuperview];
        msgLbl = [[UILabel alloc] init];
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15, screenRect.size.width*0.90, 60)];
        msgLbl.textAlignment = NSTextAlignmentCenter;
        msgLbl.text=@"No records found";
        [msgLbl setTextColor: [UIColor blackColor]];
        UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
        msgLbl.font=font1s;
        [self.view addSubview:msgLbl];
    }
}

- (void) receiveNotification:(NSNotification *) notification
{
    appDelegate.userlistBool=true;
    appDelegate.msgchatBool=false;
    //appDelegate.tabStr=@"Chats";
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *oldStr=[prefs objectForKey:[prefs objectForKey:@"user_id"]];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    if ([appDelegate.tabStr isEqualToString:@"Chats"]) {
        [lineView removeFromSuperview];
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, screenRect.size.height*0.17, screenRect.size.width*0.33, 2)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"03687f"];
        [self.view addSubview:lineView];
        
        filteredContentList=[[NSMutableArray alloc]init];
        NSString *oldStr=[prefs objectForKey:[prefs objectForKey:@"user_id"]];
        userListArray=[[NSMutableArray alloc]init];
        if(oldStr!=nil)
            userListArray=[self ToListss:oldStr :false];
        
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                                   ascending:NO];
        NSArray *descriptors = [NSArray arrayWithObject:descriptor];
        NSArray *reverseOrder = [userListArray sortedArrayUsingDescriptors:descriptors];
        userListArray=[[NSMutableArray alloc]init];
        userListArray=[reverseOrder mutableCopy];
        filteredContentList=[[NSMutableArray alloc]init];
        filteredContentList=[userListArray mutableCopy];
        [userlistTableView reloadData];
        if ([userListArray count]>0) {
            [msgLbl removeFromSuperview];
        }else{
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            [msgLbl removeFromSuperview];
            msgLbl = [[UILabel alloc] init];
            [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15, screenRect.size.width*0.90, 60)];
            msgLbl.textAlignment = NSTextAlignmentCenter;
            msgLbl.text=@"No records found";
            [msgLbl setTextColor: [UIColor blackColor]];
            UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
            msgLbl.font=font1s;
            [self.view addSubview:msgLbl];
            
        }
    }else if ([appDelegate.tabStr isEqualToString:@"Contacts"]){
        [self mycontactAction];
        
    }else if ([appDelegate.tabStr isEqualToString:@"Groups"]){
        [self groupAction];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    appDelegate.userlistBool=true;
    appDelegate.msgchatBool=false;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *oldStr=[prefs objectForKey:[prefs objectForKey:@"user_id"]];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if ([appDelegate.tabStr isEqualToString:@"Chats"]) {
    [lineView removeFromSuperview];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, screenRect.size.height*0.17, screenRect.size.width*0.33, 2)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"03687f"];
    [self.view addSubview:lineView];

    filteredContentList=[[NSMutableArray alloc]init];
    NSString *oldStr=[prefs objectForKey:[prefs objectForKey:@"user_id"]];
    userListArray=[[NSMutableArray alloc]init];
    if(oldStr!=nil)
    userListArray=[self ToListss:oldStr :false];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                               ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [userListArray sortedArrayUsingDescriptors:descriptors];
    userListArray=[[NSMutableArray alloc]init];
    userListArray=[reverseOrder mutableCopy];
    filteredContentList=[[NSMutableArray alloc]init];
    filteredContentList=[userListArray mutableCopy];
    [userlistTableView reloadData];
    if ([userListArray count]>0) {
        [msgLbl removeFromSuperview];
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        [msgLbl removeFromSuperview];
        msgLbl = [[UILabel alloc] init];
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15, screenRect.size.width*0.90, 60)];
        msgLbl.textAlignment = NSTextAlignmentCenter;
        msgLbl.text=@"No records found";
        [msgLbl setTextColor: [UIColor blackColor]];
        UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
        msgLbl.font=font1s;
        [self.view addSubview:msgLbl];
        
    }
    }else if ([appDelegate.tabStr isEqualToString:@"Contacts"]){
        [self mycontactAction];

    }else if ([appDelegate.tabStr isEqualToString:@"Groups"]){
        [self groupAction];
    }
    
    if (oldStr==nil || !appDelegate.getuserList) {
        NSString *urlString=[prefs objectForKey:@"SWACC"];
        if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
            [self performSelector:@selector(getUserList1) withObject:nil afterDelay:1.0 ];
        }else{
            [self getUserList];
        }
    }
}


-(void)getUserList{
    appDelegate.getuserList=true;
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
            NSMutableURLRequest *urlRequest;
            NSString *urlString1=[prefs objectForKey:@"SWACC"];
            if ([urlString1 isEqualToString:@"http://192.168.0.37/swacc/"]) {
                httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@",[prefs objectForKey:@"user_id"]]];
                urlString = [[NSString alloc]initWithFormat:@"%@wsGetUnreadMessages.php",[prefs objectForKey:@"SWACC"]];
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
                [urlRequest setURL:[NSURL URLWithString:@"https://stg.benefitbridge.com/swacc/api/unreadmessages"]];
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
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                            
//                            [alert show];
                            
                        }else if (boolValue==1){
                            NSArray *userArray;
                            userArray = [userDict objectForKey:@"message"];
                            NSMutableArray *userlistArrayloc,*grouplistArrayloc;
                            NSString *oldStr=[prefs objectForKey:[prefs objectForKey:@"user_id"]];
                            userlistArrayloc=[[NSMutableArray alloc]init];
                            if(oldStr!=nil)
                                userlistArrayloc=[self ToListss:oldStr :false];
                            
                            grouplistArrayloc=[[NSMutableArray alloc]init];

                            NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
                            NSString *oldStrs=[prefs objectForKey:keyStr];
                            grouplistArrayloc=[[NSMutableArray alloc]init];
                            if(oldStrs!=nil)
                                grouplistArrayloc=[self ToListss:oldStrs :false];

                            for (int count=0; count<[userArray count]; count++){
                                int un_count =0;

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

                                if ([activityData objectForKey:@"sender_id"] != [NSNull null])
                                    msgvo.senderID=[activityData objectForKey:@"sender_id"];
                                
                                if ([activityData objectForKey:@"name"] != [NSNull null])
                                    msgvo.username=[activityData objectForKey:@"name"];
                                
                                if ([activityData objectForKey:@"profile_picture"] != [NSNull null])
                                    msgvo.profile=[activityData objectForKey:@"profile_picture"];
                                
                                if ([activityData objectForKey:@"chat_id"] != [NSNull null])
                                    msgvo.chatid=[activityData objectForKey:@"chat_id"];

                                if ([activityData objectForKey:@"message"] != [NSNull null])
                                    msgvo.message=[activityData objectForKey:@"message"];

//                                if ([activityData objectForKey:@"chat_date"] != [NSNull null])
//                                    msgvo.msg_Date=[activityData objectForKey:@"chat_date"];

                                if ([activityData objectForKey:@"attachment"] != [NSNull null])
                                    msgvo.attachment=[activityData objectForKey:@"attachment"];

                                NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
                                [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
                                NSString *dateString = [fbdateFormat stringFromDate:today];
                                NSLog(@"dateString%@",dateString);
                                msgvo.msg_Date=dateString;
                                
                                if ([prefs objectForKey:msgvo.senderID]==nil) {
                                    [prefs setObject:msgvo.profile forKey:msgvo.senderID];
                                    if (![msgvo.profile isEqualToString:@""]) {
                                        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msgvo.profile]]];
                                        NSData *ImageDatas = UIImageJPEGRepresentation(image,0.1);
                                        NSString *imgStr=[[NSString alloc]init];
                                        imgStr=  [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                                        NSString* imgkeyStr=[NSString stringWithFormat:@"%@_%@",msgvo.senderID,@"ProfileImage"];
                                        [prefs setObject:imgStr forKey:imgkeyStr];
                                    }
                                }else if(![[prefs objectForKey:msgvo.senderID] isEqualToString:msgvo.profile]){
                                    [prefs setObject:msgvo.profile forKey:msgvo.senderID];
                                    if (![msgvo.profile isEqualToString:@""]) {
                                        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msgvo.profile]]];
                                        NSData *ImageDatas = UIImageJPEGRepresentation(image,0.1);
                                        NSString *imgStr=[[NSString alloc]init];
                                        imgStr=  [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                                        NSString* imgkeyStr=[NSString stringWithFormat:@"%@_%@",msgvo.senderID,@"ProfileImage"];
                                        [prefs setObject:imgStr forKey:imgkeyStr];
                                    }
                                }

                                msgListArray=[[NSMutableArray alloc]init];
                                NSString *keyStr=[NSString stringWithFormat:@"%@%@",msgvo.senderID,[prefs objectForKey:@"user_id"]];
                                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                                NSString *oldStr=[prefs objectForKey:keyStr];
                                if( [prefs objectForKey:keyStr]!=nil)
                                    msgListArray =[self ToListss:oldStr:true];

                                ChatVO *chatvo=[[ChatVO alloc]init];
                                chatvo.TrueStr=[[NSString alloc]init];
                                chatvo.chatid=[[NSString alloc]init];
                                chatvo.message=[[NSString alloc]init];
                                chatvo.msg_Date=[[NSString alloc]init];
                                chatvo.status=[[NSString alloc]init];
                                chatvo.TrueStr=@"False";
                                chatvo.chatid=msgvo.chatid;
                                chatvo.message=msgvo.message;
//                                chatvo.msg_Date=msgvo.msg_Date;
                                chatvo.msg_Date=dateString;
                                chatvo.attachment=msgvo.attachment;

                                NSLog(@"dateString%@",dateString);

                                chatvo.status=@"0";
                                
                                if (![msgvo.attachment isEqualToString:@""]) {
                                    NSArray* commonFields = [msgvo.message componentsSeparatedByString:@": "];
                                    if ([commonFields count]>1) {
                                        NSData *pdfData1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:msgvo.attachment]];
                                        NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                        NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
                                        NSString *filePath1 = [documentsDirectory1 stringByAppendingPathComponent:[commonFields objectAtIndex:1]];
                                        [pdfData1 writeToFile:filePath1 atomically:YES];

                                        NSString* documentsPath1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                                        NSString* foofile = [documentsPath1 stringByAppendingPathComponent:[commonFields objectAtIndex:1]];
                                        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
                                        NSLog(@"fileExists%d",fileExists);
                                        
                                    }else{
                                        NSData *pdfData1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:msgvo.attachment]];
                                        NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                        NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
                                        NSString *filePath1 = [documentsDirectory1 stringByAppendingPathComponent:msgvo.message];
                                        [pdfData1 writeToFile:filePath1 atomically:YES];

                                        NSString* documentsPath1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                                        NSString* foofile = [documentsPath1 stringByAppendingPathComponent:msgvo.message];
                                        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
                                        NSLog(@"fileExists%d",fileExists);
                                        
                                    }
                                }

                                BOOL chatid=NO;
                                for (int count1=0; count1<[msgListArray  count]; count1++){
                                    ChatVO *CVO=[msgListArray objectAtIndex:count1];
                                    if ([chatvo.chatid isEqualToString:CVO.chatid]) {
                                        chatid=YES;
                                        break;
                                    }else{
                                        chatid=NO;
                                    }
                                }
                                if (!chatid) {
                                    [msgListArray addObject:chatvo];
                                    [prefs setObject:[self ToStringss:msgListArray : true] forKey:keyStr];
                                }

                                for (int count=0; count<[userListArray  count]; count++){
                                    MessageVO *msgvos=[userListArray objectAtIndex:count];
                                    if ([msgvo.senderID isEqualToString:msgvos.senderID]) {
                                        un_count=[msgvos.unreadMsg intValue];
                                        NSLog(@"count %d",count);
                                        [userListArray removeObject:msgvos];
                                    }
                                }
                                
                                for (int count=0; count<[grouplistArrayloc  count]; count++){
                                    MessageVO *msgvosg=[grouplistArrayloc objectAtIndex:count];
                                    if ([msgvo.senderID isEqualToString:msgvosg.senderID]) {
                                        un_count=[msgvosg.unreadMsg intValue];
                                        NSLog(@"count %d",count);
                                        [grouplistArrayloc removeObject:msgvosg];
                                    }
                                }

                                for (int count=0; count<[userlistArrayloc  count]; count++){
                                    MessageVO *msgvosu=[userlistArrayloc objectAtIndex:count];
                                    if ([msgvo.senderID isEqualToString:msgvosu.senderID]) {
                                        un_count=[msgvosu.unreadMsg intValue];
                                        NSLog(@"count %d",count);
                                        [userlistArrayloc removeObject:msgvosu];
                                    }
                                }

                                msgvo.unreadMsg=[NSString stringWithFormat:@"%d",un_count];
                                [userListArray addObject:msgvo];
                                
                                if ([msgvo.senderID rangeOfString:@"U_"].location == NSNotFound) {
                                    //group
                                    [grouplistArrayloc addObject:msgvo];

                                    NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
                                    [prefs setObject:[self ToStringss:grouplistArrayloc :false]  forKey:keyStr];
                                }else{
                                    //normal msg
                                    [userlistArrayloc addObject:msgvo];

                                    [prefs setObject:[self ToStringss:userlistArrayloc :false]  forKey:[prefs objectForKey:@"user_id"]];
                                    NSLog(@"true");
                                    }
                                }
                                NSLog(@"array count %lu",(unsigned long)[userListArray count]);
                            
                               [activityImageView removeFromSuperview];
                            
                            appDelegate.msgTotalCount=0;
                            for (int count=0; count<[userListArray  count]; count++){
                                MessageVO *msgvos1=[userListArray objectAtIndex:count];
                                appDelegate.msgTotalCount=appDelegate.msgTotalCount+[msgvos1.unreadMsg intValue];
                            }
                            NSLog(@"msgTotalCount %d ",appDelegate.msgTotalCount);
                            [UIApplication sharedApplication].applicationIconBadgeNumber = appDelegate.msgTotalCount;

                            if ([userArray count]>0) {
                                NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                                                           ascending:NO];
                                NSArray *descriptors = [NSArray arrayWithObject:descriptor];
                                NSArray *reverseOrder = [userlistArrayloc sortedArrayUsingDescriptors:descriptors];
                                userListArray=[[NSMutableArray alloc]init];
                                userListArray=[reverseOrder mutableCopy];
                            filteredContentList=[[NSMutableArray alloc]init];
                            filteredContentList=[userListArray mutableCopy];
                            [userlistTableView reloadData];
                                [msgLbl removeFromSuperview];
                            }
                    }
                }
            }
        }];
    }
}


-(NSString *)ToStringss :(NSMutableArray *)mutableArray :(BOOL)ischat{
    NSString *seprator=@"%!@#%";
    NSString *str=[[NSString alloc]init];
    for (int count=0; count<[mutableArray count]; count++){
        if (!ischat) {
            NSString *app_str=[seprator stringByAppendingString:[self objToStr:[mutableArray objectAtIndex:count]]];
            if(count==0)
                str= [str stringByAppendingString:[self objToStr:[mutableArray objectAtIndex:count]]];
            else
                str= [str stringByAppendingString:app_str];
        }
        else if(ischat)
        {
            NSString *app_str=[seprator stringByAppendingString:[self objToStrchat:[mutableArray objectAtIndex:count]]];
            if(count==0)
                str= [str stringByAppendingString:[self objToStrchat:[mutableArray objectAtIndex:count]]];
            else
                str= [str stringByAppendingString:app_str];
        }
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

-(NSString *)objToStrchat :(ChatVO *)chatVO {
    NSString *str=[[NSString alloc]init];
    NSString *seprator=@"%=";
    str=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",chatVO.TrueStr,seprator,chatVO.chatid,seprator,chatVO.message,seprator,chatVO.msg_Date,seprator,@"0",seprator,chatVO.attachment];
    return str;
}

-(NSMutableArray *)ToListss :(NSString *)Strs  : (BOOL)ischat{
    NSString *seprator=@"%!@#%";
    NSArray* commonFields = [Strs componentsSeparatedByString:seprator];
    NSMutableArray *muArray=[[NSMutableArray alloc]init];
    for (int count=0; count<[commonFields count]; count++){
        if(!ischat)
            [muArray addObject:[self StrtoObj:[commonFields objectAtIndex:count]]];
        else
            [muArray addObject:[self StrtoObjchat:[commonFields objectAtIndex:count]]];
    }
    return muArray;
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

        if([commonFields count]>3){
        msgvo.senderID=[commonFields objectAtIndex:0];
        msgvo.username=[commonFields objectAtIndex:1];
        msgvo.chatid=[commonFields objectAtIndex:2];
        msgvo.message=[commonFields objectAtIndex:3];
        msgvo.msg_Date=[commonFields objectAtIndex:4];
        msgvo.unreadMsg=[commonFields objectAtIndex:5];
        msgvo.profile=[commonFields objectAtIndex:6];
            msgvo.attachment=[commonFields objectAtIndex:7];

        }else{
            msgvo.senderID=[commonFields objectAtIndex:0];
            msgvo.username=[commonFields objectAtIndex:1];
            msgvo.profile=[commonFields objectAtIndex:2];
        }
    }
    return msgvo;
}
-(ChatVO *)StrtoObjchat :(NSString *)str  {
    ChatVO * chatvo=[[ChatVO alloc]init];
    NSString *seprator=@"%=";
    NSArray* commonFields = [str componentsSeparatedByString:seprator];
    for (int co=0; co<[commonFields count]; co++) {
        chatvo.TrueStr=[[NSString alloc]init];
        chatvo.chatid=[[NSString alloc]init];
        chatvo.message=[[NSString alloc]init];
        chatvo.msg_Date=[[NSString alloc]init];
        chatvo.status=[[NSString alloc]init];
        chatvo.attachment=[[NSString alloc]init];

        chatvo.TrueStr=[commonFields objectAtIndex:0];
        chatvo.chatid=[commonFields objectAtIndex:1];
        chatvo.message=[commonFields objectAtIndex:2];
        chatvo.msg_Date=[commonFields objectAtIndex:3];
        chatvo.status=[commonFields objectAtIndex:4];
        chatvo.attachment=[commonFields objectAtIndex:5];

    }
    return chatvo;
}


-(void)getUserList1{
    appDelegate.getuserList=true;
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@",[prefs objectForKey:@"user_id"]]];
    urlString = [[NSString alloc]initWithFormat:@"%@wsGetUnreadMessages.php",[prefs objectForKey:@"SWACC"]];
    url=[[NSURL alloc] initWithString:urlString];
    rest_url=url;
    NSData *postData = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connections = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connections start];
  
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
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if (boolValue==1){
        NSArray *userArray;
        userArray = [dic objectForKey:@"message"];
        NSMutableArray *userlistArrayloc,*grouplistArrayloc;
        NSString *oldStr=[prefs objectForKey:[prefs objectForKey:@"user_id"]];
        userlistArrayloc=[[NSMutableArray alloc]init];
        if(oldStr!=nil)
            userlistArrayloc=[self ToListss:oldStr :false];
        
        grouplistArrayloc=[[NSMutableArray alloc]init];
        
        NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
        NSString *oldStrs=[prefs objectForKey:keyStr];
        grouplistArrayloc=[[NSMutableArray alloc]init];
        if(oldStrs!=nil)
            grouplistArrayloc=[self ToListss:oldStrs :false];

        for (int count=0; count<[userArray count]; count++){
            int un_count =0;
            
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

            if ([activityData objectForKey:@"sender_id"] != [NSNull null])
                msgvo.senderID=[activityData objectForKey:@"sender_id"];
            
            if ([activityData objectForKey:@"name"] != [NSNull null])
                msgvo.username=[activityData objectForKey:@"name"];
            
            if ([activityData objectForKey:@"profile_picture"] != [NSNull null])
                msgvo.profile=[activityData objectForKey:@"profile_picture"];
            
            if ([activityData objectForKey:@"chat_id"] != [NSNull null])
                msgvo.chatid=[activityData objectForKey:@"chat_id"];
            
            if ([activityData objectForKey:@"message"] != [NSNull null])
                msgvo.message=[activityData objectForKey:@"message"];
            
            if ([activityData objectForKey:@"attachment"] != [NSNull null])
                msgvo.attachment=[activityData objectForKey:@"attachment"];

//            if ([activityData objectForKey:@"chat_date"] != [NSNull null])
//                msgvo.msg_Date=[activityData objectForKey:@"chat_date"];
            
            NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
            [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
            NSString *dateString = [fbdateFormat stringFromDate:today];
            NSLog(@"dateString%@",dateString);
            msgvo.msg_Date=dateString;
            
            if ([prefs objectForKey:msgvo.senderID]==nil) {
                [prefs setObject:msgvo.profile forKey:msgvo.senderID];
                if (![msgvo.profile isEqualToString:@""]) {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msgvo.profile]]];
                    NSData *ImageDatas = UIImageJPEGRepresentation(image,0.1);
                    NSString *imgStr=[[NSString alloc]init];
                    imgStr=  [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                    NSString* imgkeyStr=[NSString stringWithFormat:@"%@_%@",msgvo.senderID,@"ProfileImage"];
                    [prefs setObject:imgStr forKey:imgkeyStr];
                }
            }else if(![[prefs objectForKey:msgvo.senderID] isEqualToString:msgvo.profile]){
                [prefs setObject:msgvo.profile forKey:msgvo.senderID];
                if (![msgvo.profile isEqualToString:@""]) {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msgvo.profile]]];
                    NSData *ImageDatas = UIImageJPEGRepresentation(image,0.1);
                    NSString *imgStr=[[NSString alloc]init];
                    imgStr=  [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                    NSString* imgkeyStr=[NSString stringWithFormat:@"%@_%@",msgvo.senderID,@"ProfileImage"];
                    [prefs setObject:imgStr forKey:imgkeyStr];
                }
            }
            
            msgListArray=[[NSMutableArray alloc]init];
            NSString *keyStr;
                keyStr=[NSString stringWithFormat:@"%@%@",msgvo.senderID,[prefs objectForKey:@"user_id"]];
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *oldStr=[prefs objectForKey:keyStr];
            if( [prefs objectForKey:keyStr]!=nil)
                msgListArray =[self ToListss:oldStr:true];
            
            ChatVO *chatvo=[[ChatVO alloc]init];
            chatvo.TrueStr=[[NSString alloc]init];
            chatvo.chatid=[[NSString alloc]init];
            chatvo.message=[[NSString alloc]init];
            chatvo.msg_Date=[[NSString alloc]init];
            chatvo.status=[[NSString alloc]init];
            chatvo.TrueStr=@"False";
            chatvo.chatid=msgvo.chatid;
            chatvo.message=msgvo.message;
            //chatvo.msg_Date=msgvo.msg_Date;
            chatvo.msg_Date=dateString;
            chatvo.attachment=msgvo.attachment;

            NSLog(@"dateString%@",dateString);

            chatvo.status=@"0";
            if (![msgvo.attachment isEqualToString:@""]) {
                NSArray* commonFields = [msgvo.message componentsSeparatedByString:@": "];
                if ([commonFields count]>1) {
                    NSData *pdfData1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:msgvo.attachment]];
                    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
                    NSString *filePath1 = [documentsDirectory1 stringByAppendingPathComponent:[commonFields objectAtIndex:1]];
                    [pdfData1 writeToFile:filePath1 atomically:YES];
                    
                    NSString* documentsPath1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                    NSString* foofile = [documentsPath1 stringByAppendingPathComponent:[commonFields objectAtIndex:1]];
                    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
                    NSLog(@"fileExists%d",fileExists);
                    
                }else{
                    NSData *pdfData1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:msgvo.attachment]];
                    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
                    NSString *filePath1 = [documentsDirectory1 stringByAppendingPathComponent:msgvo.message];
                    [pdfData1 writeToFile:filePath1 atomically:YES];
                    
                    NSString* documentsPath1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                    NSString* foofile = [documentsPath1 stringByAppendingPathComponent:msgvo.message];
                    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
                    NSLog(@"fileExists%d",fileExists);
                    
                }
            }

            BOOL chatid=NO;
            for (int count1=0; count1<[msgListArray  count]; count1++){
                ChatVO *CVO=[msgListArray objectAtIndex:count1];
                if ([chatvo.chatid isEqualToString:CVO.chatid]) {
                    chatid=YES;
                    break;
                }else{
                    chatid=NO;
                }
            }
            if (!chatid) {
                [msgListArray addObject:chatvo];
                [prefs setObject:[self ToStringss:msgListArray : true] forKey:keyStr];
            }
            
            for (int count=0; count<[grouplistArrayloc  count]; count++){
                MessageVO *msgvosg=[grouplistArrayloc objectAtIndex:count];
                
                if ([msgvo.senderID isEqualToString:msgvosg.senderID]) {
                    un_count=[msgvosg.unreadMsg intValue];
                    NSLog(@"count %d",count);
                    [grouplistArrayloc removeObject:msgvosg];
                }
            }
            
            for (int count=0; count<[userlistArrayloc  count]; count++){
                MessageVO *msgvosu=[userlistArrayloc objectAtIndex:count];
                
                if ([msgvo.senderID isEqualToString:msgvosu.senderID]) {
                    un_count=[msgvosu.unreadMsg intValue];
                    NSLog(@"count %d",count);
                    [userlistArrayloc removeObject:msgvosu];
                }
            }
            
            msgvo.unreadMsg=[NSString stringWithFormat:@"%d",un_count+1];
            [userListArray addObject:msgvo];
            
            if ([msgvo.senderID rangeOfString:@"U_"].location == NSNotFound) {
                //group
                [grouplistArrayloc addObject:msgvo];
                
                NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
                [prefs setObject:[self ToStringss:grouplistArrayloc :false]  forKey:keyStr];
            }else{
                //normal msg
                [userlistArrayloc addObject:msgvo];
                
                [prefs setObject:[self ToStringss:userlistArrayloc :false]  forKey:[prefs objectForKey:@"user_id"]];
                NSLog(@"true");
            }
        }
        NSLog(@"array count %lu",(unsigned long)[userListArray count]);
        
        [activityImageView removeFromSuperview];
        
        appDelegate.msgTotalCount=0;
        for (int count=0; count<[userListArray  count]; count++){
            MessageVO *msgvos1=[userListArray objectAtIndex:count];
            appDelegate.msgTotalCount=appDelegate.msgTotalCount+[msgvos1.unreadMsg intValue];
        }
        NSLog(@"msgTotalCount %d ",appDelegate.msgTotalCount);
        [UIApplication sharedApplication].applicationIconBadgeNumber = appDelegate.msgTotalCount;
        
        if ([userArray count]>0) {
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                                   ascending:NO];
        NSArray *descriptors = [NSArray arrayWithObject:descriptor];
        NSArray *reverseOrder = [userlistArrayloc sortedArrayUsingDescriptors:descriptors];
        userListArray=[[NSMutableArray alloc]init];
        userListArray=[reverseOrder mutableCopy];
        filteredContentList=[[NSMutableArray alloc]init];
        filteredContentList=[userListArray mutableCopy];
        [userlistTableView reloadData];
            [msgLbl removeFromSuperview];
        }
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
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    else
    {
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}


-(IBAction)SearchAction:(id)sender{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    navigationView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width,45)];
    [navigationView setBackgroundColor:[UIColor whiteColor]];
    //[self.view addSubview:navigationView];
   UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(5,10,screenRect.size.width*0.10,screenRect.size.height*0.05)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_arrow_red.png"]forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor whiteColor]];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];

        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(screenRect.size.width*.15, 0.0, screenRect.size.width*.80, 44.0)];
        searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [searchBar setBackgroundColor:[UIColor clearColor]];
        searchBar.placeholder=@"Search...";
        searchBar.tintColor=[UIColor clearColor];
        searchBar.barTintColor = [UIColor whiteColor];
        navigationView.autoresizingMask = 0;
        searchBar.layer.borderColor = [[UIColor whiteColor] CGColor];
        searchBar.delegate = self;
        [navigationView addSubview:searchBar];
    
    CGRect rect = self.searchBar.frame;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, rect.size.height-2,rect.size.width, 2)];
    lineView.backgroundColor = [UIColor whiteColor];
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0,0,rect.size.width, 2)];
    lineView1.backgroundColor = [UIColor whiteColor];
    [self.searchBar addSubview:lineView];
    [self.searchBar addSubview:lineView1];

    [self.navigationController.navigationBar addSubview: navigationView];
}

- (void)searchTableList {
    NSString *searchString = searchBar.text;
    userListArray=[[NSMutableArray alloc]init];
    for (int i=0; i<filteredContentList.count; i++) {
        MessageVO *msgvo=[filteredContentList objectAtIndex:i];
        if ([msgvo.username rangeOfString:searchString].location != NSNotFound) {
            [userListArray addObject:msgvo];
        }
    }
    if ([userListArray count]>0) {
        [msgLbl removeFromSuperview];
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        [msgLbl removeFromSuperview];
        msgLbl = [[UILabel alloc] init];
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15, screenRect.size.width*0.90, 60)];
        msgLbl.textAlignment = NSTextAlignmentCenter;
        msgLbl.text=@"No records found";
        [msgLbl setTextColor: [UIColor blackColor]];
        UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
        msgLbl.font=font1s;
        [self.view addSubview:msgLbl];
    }
}

#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length != 0){
        isSearching = YES;
        [self searchTableList];
    }else {
        isSearching = NO;
        userListArray=[[NSMutableArray alloc]init];
        userListArray=[filteredContentList mutableCopy];;
        // tblContentList.hidden=YES;
    }
    [userlistTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    NSLog(@"Cancel clicked");
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [self.searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar {
    NSLog(@"Search Clicked");
    if(searchBar.text  !=nil) {
        isSearching = YES;
        [self searchTableList];
    }else {
        isSearching = NO;
        userListArray=[[NSMutableArray alloc]init];
        userListArray=[filteredContentList mutableCopy];;
        // tblContentList.hidden=YES;
    }
    [userlistTableView reloadData];
}

-(IBAction)CancelAction:(id)sender{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
    appDelegate.userlistBool=false;
    appDelegate.msgchatBool=false;
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)backAction{
    [navigationView removeFromSuperview];
    userListArray=[[NSMutableArray alloc]init];
    userListArray=[filteredContentList mutableCopy];;
    [userlistTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [userListArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-Bold" size:16.0f];
    UIFont * font2 =[UIFont fontWithName:@"Open Sans" size:14.0f];

    MessageVO *msgvo=[userListArray objectAtIndex:indexPath.row];
    UIImageView *  logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,15,screenRect.size.width*.12,screenRect.size.width*.12)];
    NSString* imgkeyStr;
    if (  [appDelegate.tabStr isEqualToString:@"Groups"]) {
        imgkeyStr=[NSString stringWithFormat:@"%@_%@",msgvo.senderID,@"Group"];
    }else{
        imgkeyStr=[NSString stringWithFormat:@"%@_%@",msgvo.senderID,@"ProfileImage"];
    }

    if (imgkeyStr==nil && [imgkeyStr isEqualToString:@""]) {
        [logoImg setImage:[UIImage imageNamed:@"upload_Picture copy.png"]];
    }else
    {
        NSString *imgstr=[prefs objectForKey:imgkeyStr];
        if (imgstr==nil) {
            [logoImg setImage:[UIImage imageNamed:@"upload_Picture copy.png"]];
        }else{
        NSData *nsdataBackBase64String = [[NSData alloc] initWithBase64EncodedString:[prefs objectForKey:imgkeyStr] options:0];
        UIImage *img1 = [UIImage imageWithData: nsdataBackBase64String];
        logoImg.image=img1;
        }
    }
    logoImg.layer.cornerRadius = logoImg.frame.size.width / 2;
    logoImg.clipsToBounds = YES;
    logoImg.layer.borderWidth = 1.5f;
    logoImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [cell.contentView addSubview:logoImg];

    NSString *firstlastname=[[NSString alloc]init];
    UILabel *usernameLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.17,screenRect.size.height*.005, screenRect.size.width*.60,screenRect.size.height*.05)];
    firstlastname=[NSString stringWithFormat:@"%@",msgvo.username];
    [usernameLbl setText:firstlastname];
    usernameLbl.font=font1;
    [usernameLbl setTextColor:[UIColor blackColor]];
    usernameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    [cell.contentView addSubview:usernameLbl];
    
    if (![msgvo.message isEqualToString:@""]) {
    NSString *msgStr=[[NSString alloc]init];
    UILabel *msgLblTxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.17,screenRect.size.height*.06, screenRect.size.width*.60,screenRect.size.height*.05)];
    msgStr=[NSString stringWithFormat:@"%@",msgvo.message];
    [msgLblTxt setText:msgStr];
    msgLblTxt.font=font2;
    [msgLblTxt setTextColor:[UIColor blackColor]];
    msgLblTxt.lineBreakMode = NSLineBreakByWordWrapping;
    [cell.contentView addSubview:msgLblTxt];

    }
    if (![msgvo.msg_Date isEqualToString:@""]) {
    
            UILabel *msgTime=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.80,screenRect.size.height*.01, 100,20)];
            msgTime.font=[UIFont fontWithName:@"Open Sans" size:09.0f];
            NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
            NSString *fbdate=[NSString stringWithFormat:@"%@",[[msgvo.msg_Date componentsSeparatedByString:@""] objectAtIndex:0]];
            [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *facebookdate = [fbdateFormat dateFromString:fbdate];
            //[fbdateFormat setTimeZone:[NSTimeZone systemTimeZone]];
            fbdateFormat.timeZone = [NSTimeZone systemTimeZone];
            NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
            long seconds= [self timeDifference:today ToDate:facebookdate];
            long diffinsec=seconds%60;
            diffinsec=seconds/60;
            long minutes=seconds/60;
            diffinsec=diffinsec/60;
            long hours=minutes/60;
            diffinsec=diffinsec/24;
            long days=hours/24;
            long month=days/30;
            long year=month/12;
            if(hours<=23){
                NSString *fbdate1=[NSString stringWithFormat:@"%@",[[msgvo.msg_Date componentsSeparatedByString:@" "] objectAtIndex:1]];
                NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
                [timeFormat setDateFormat:@"HH:mm:ss"];
                NSDate *timedate = [timeFormat dateFromString:fbdate1];
                NSDateFormatter *timeFormat123 = [[NSDateFormatter alloc] init];
                [timeFormat123 setDateFormat:@"hh:mm a"];
                NSString *dateString = [timeFormat123 stringFromDate:timedate];
                msgTime.text=dateString ;
            }else if(month<=12){
                NSString *fbdate1=[NSString stringWithFormat:@"%@",[[msgvo.msg_Date componentsSeparatedByString:@" "] objectAtIndex:0]];
                NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
                [timeFormat setDateFormat:@"yyyy-MM-dd"];
                NSDate *timedate = [timeFormat dateFromString:fbdate1];
                NSDateFormatter *timeFormat123 = [[NSDateFormatter alloc] init];
                [timeFormat123 setDateFormat:@"dd MMM"];
                NSString *dateString = [timeFormat123 stringFromDate:timedate];
                msgTime.text=dateString;
                }else if(year>=0){
                    NSString *fbdate1=[NSString stringWithFormat:@"%@",[[msgvo.msg_Date componentsSeparatedByString:@" "] objectAtIndex:0]];
                    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
                    [timeFormat setDateFormat:@"yyyy-MM-dd"];
                    NSDate *timedate = [timeFormat dateFromString:fbdate1];
                    NSDateFormatter *timeFormat123 = [[NSDateFormatter alloc] init];
                    [timeFormat123 setDateFormat:@"dd MMM yy"];
                    NSString *dateString = [timeFormat123 stringFromDate:timedate];
                    msgTime.text=dateString;
            }
            msgTime.textColor=[UIColor grayColor];
            [cell.contentView addSubview:msgTime];
    
    if (![msgvo.unreadMsg isEqualToString:@""] && msgvo.unreadMsg!=nil && ![msgvo.unreadMsg isEqualToString:@"0"]) {
        UIButton *countLbl=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.85,screenRect.size.height*.07, screenRect.size.width*.10,screenRect.size.width*.10)];
        [countLbl setTitle:msgvo.unreadMsg forState:UIControlStateNormal];
        [countLbl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        countLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [countLbl setBackgroundImage:[UIImage imageNamed:@"circle_blue.png"] forState:UIControlStateNormal];
        UIFont * font =[UIFont fontWithName:@"Open Sans" size:9.0f];
        countLbl.titleLabel.font = font;
        [cell.contentView addSubview:countLbl];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*.12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [navigationView removeFromSuperview];
        MessageChatViewController * msgChat;
        msgChat= [[MessageChatViewController alloc] initWithNibName:@"MessageChatViewController" bundle:nil];
        MessageVO *msgvo=[userListArray objectAtIndex:indexPath.row];
        msgChat.MsgVO=[[MessageVO alloc]init];
        msgChat.MsgVO=msgvo;
        [self.navigationController pushViewController:msgChat animated:YES];
}
- (int)timeDifference:(NSDate *)fromDate ToDate:(NSDate *)toDate{
    NSTimeInterval distanceBetweenDates = [fromDate timeIntervalSinceDate:toDate];
    return distanceBetweenDates;
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
