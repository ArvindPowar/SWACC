//
//  MessageChatViewController.m
//  SWACC
//
//  Created by Infinitum on 16/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import "MessageChatViewController.h"
#import "UIColor+Expanded.h"
#import "Reachability.h"
#import "ChatVO.h"
#import "ChatUserListViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "DocumentViewController.h"
#import "PdfviewerViewController.h"
@interface MessageChatViewController ()

@end

@implementation MessageChatViewController
@synthesize appDelegate,chatTableView,msgListArray,msgText,sendBtn,lpgr,selectMsgArray,activityImageView,MsgVO,StrMain,resentMsg,commonURL,navigationView,
titleLbl,forwardmsgStr,isMenuVisible,menuNameButton,clearView,selectIndex,tap;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    appDelegate=[[UIApplication sharedApplication] delegate];
    appDelegate.documentsendStr=[[NSString alloc]init];
    appDelegate.documentsendStr=@"False";
    tap.cancelsTouchesInView=NO;

    navigationView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 300, 30)];
    titleLbl = [[UILabel alloc] initWithFrame: CGRectMake(40, 0, 300, 30)];
    
    titleLbl.text = NSLocalizedString(MsgVO.username, nil);
    [titleLbl setTextColor:[UIColor whiteColor]];
    [titleLbl setFont:font];
    [titleLbl setBackgroundColor:[UIColor clearColor]];
    UIImage *image;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([MsgVO.profile isEqualToString:@""]) {
        image = [UIImage imageNamed:@"upload_Picture copy.png"];
    }else
    {
    NSString* imgkeyStr;
    if ([appDelegate.tabStr isEqualToString:@"Groups"]) {
        imgkeyStr=[NSString stringWithFormat:@"%@_%@",MsgVO.senderID,@"Group"];
    }else{
        imgkeyStr=[NSString stringWithFormat:@"%@_%@",MsgVO.senderID,@"ProfileImage"];
    }
        NSData *nsdataBackBase64String = [[NSData alloc] initWithBase64EncodedString:[prefs objectForKey:imgkeyStr] options:0];
        if (nsdataBackBase64String!=nil) {
            image = [UIImage imageWithData: nsdataBackBase64String];
        }else{
            image = [UIImage imageNamed:@"upload_Picture copy.png"];
        }
    }
    appDelegate.msgTotalCount=appDelegate.msgTotalCount-[MsgVO.unreadMsg intValue];
    [UIApplication sharedApplication].applicationIconBadgeNumber = appDelegate.msgTotalCount;

    UIImageView *myImageView = [[UIImageView alloc] initWithImage:image];
    myImageView.frame = CGRectMake(0, 0, 30, 30);
    myImageView.layer.cornerRadius = myImageView.frame.size.width / 2;
    myImageView.layer.masksToBounds = YES;
    myImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    myImageView.layer.borderWidth = 0.1;
    
    [navigationView addSubview:titleLbl];
    [navigationView setBackgroundColor:[UIColor  clearColor]];
    [navigationView addSubview:myImageView];
    self.navigationItem.titleView = navigationView;
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"#851c2b"]];

    self.navigationItem.hidesBackButton=YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#851c2b"];

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,30,30)];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setBackgroundColor:[UIColor clearColor]];
    [leftBtn setTintColor:[UIColor colorWithHexString:@"#03687f"]];
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    
    UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [RightBtn setFrame:CGRectMake(0, 0,30,30)];
    [RightBtn addTarget:self action:@selector(attachMentAction) forControlEvents:UIControlEventTouchUpInside];
    [RightBtn setBackgroundImage:[UIImage imageNamed:@"attach_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithCustomView:RightBtn];
    //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    self.navigationItem.rightBarButtonItem = btn1;
    forwardmsgStr=[[NSString alloc]init];
    if (appDelegate.forwardmsgArray==nil || [appDelegate.forwardmsgArray count]==0) {
        appDelegate.forwardmsgArray=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *urlString=[prefs objectForKey:@"SWACC"];
        if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
            [self postStatus1];
        }else{
            [self postStatus];
        }
    }else{
        for (int count=0; count<[appDelegate.forwardmsgArray  count]; count++){
//            forwardmsgStr=[appDelegate.forwardmsgArray objectAtIndex:count];
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            NSString *urlString=[prefs objectForKey:@"SWACC"];
            if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
                commonURL=@"sendMsg";
                [self performSelector:@selector(sendMsgAction1:) withObject:[appDelegate.forwardmsgArray objectAtIndex:count]  afterDelay:1.0 ];
            }else{
                [self performSelector:@selector(sendMsgAction:) withObject:[appDelegate.forwardmsgArray objectAtIndex:count]  afterDelay:1.0 ];
            }
        }
    }
    commonURL=[[NSString alloc]init];
    StrMain=[[NSString alloc]init];
    selectMsgArray=[[NSMutableArray alloc]init];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:15.0f];

    chatTableView=[[UITableView alloc]init];
    chatTableView.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height*.88);
    [chatTableView removeFromSuperview];
    chatTableView.dataSource = self;
    chatTableView.delegate = self;
    [chatTableView setBackgroundColor:[UIColor clearColor]];
    chatTableView.separatorInset = UIEdgeInsetsZero;
    chatTableView.layoutMargins = UIEdgeInsetsZero;
    [chatTableView setSeparatorColor:[UIColor clearColor]];
    chatTableView.allowsMultipleSelection=YES;
    [self.view addSubview:chatTableView];
    
    UIView * backgroundview=[[UIView alloc] init];
    [backgroundview setFrame:CGRectMake(0, screenRect.size.height*.91, screenRect.size.width, screenRect.size.height*.09)];
    [backgroundview setBackgroundColor:[UIColor colorWithHexString:@"f9fcf5"]];
    [self.view addSubview:backgroundview];

    msgText=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*.10,screenRect.size.height*.92,screenRect.size.width*.70,40)];
    msgText.font=font1;
    msgText.textAlignment=NSTextAlignmentLeft;
    msgText.delegate = self;
    msgText.textColor=[UIColor blackColor];
    msgText.layer.borderWidth=1.0;
    msgText.layer.cornerRadius=5.0f;
    msgText.layer.borderColor=[UIColor grayColor].CGColor;
    UIView *paddingViewsb = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    msgText.leftView = paddingViewsb;
    msgText.leftViewMode = UITextFieldViewModeAlways;
    msgText.placeholder=@"Type message here";
    [self.view addSubview:msgText];

    sendBtn=[[UIButton alloc]init];
    sendBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.85,screenRect.size.height*.92,screenRect.size.width*.13,40)];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"send_white.png"] forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[UIColor colorWithHexString:@"#03687f"]];
    [sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    sendBtn.layer.cornerRadius=17.0f;
    [self.view addSubview:sendBtn];
    
    msgListArray=[[NSMutableArray alloc]init];
    NSString *keyStr=[NSString stringWithFormat:@"%@%@",MsgVO.senderID,[prefs objectForKey:@"user_id"]];
    NSString *oldStr=[prefs objectForKey:keyStr];
    if( [prefs objectForKey:keyStr]!=nil){
        msgListArray =[self ToListss:oldStr:true];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                               ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [msgListArray sortedArrayUsingDescriptors:descriptors];
    msgListArray=[[NSMutableArray alloc]init];
    msgListArray=[reverseOrder mutableCopy];
    [chatTableView reloadData];
    }
    if ([msgListArray count]>0) {
        int lastRowNumber = [chatTableView numberOfRowsInSection:0] - 1;
        NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [chatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    //[chatTableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
    filteredContentList=[[NSMutableArray alloc]init];
    //if( [prefs objectForKey:[prefs objectForKey:@"user_id"]]!=nil){
        if ([MsgVO.senderID rangeOfString:@"U_"].location == NSNotFound) {
            //group
            NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
            filteredContentList=[self ToListss:[prefs objectForKey:keyStr]:false];
        }else{
       filteredContentList=[self ToListss:[prefs objectForKey:[prefs objectForKey:@"user_id"]]:false];
        }
    //}
    //if ([appDelegate.tabStr isEqualToString:@"Chats" ]) {
    MsgVO.unreadMsg=@"0";
    [self updatefunction:filteredContentList:MsgVO];
   // }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"msgChat" object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    appDelegate.userlistBool=false;
    appDelegate.msgchatBool=true;

    msgListArray=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *keyStr=[NSString stringWithFormat:@"%@%@",MsgVO.senderID,[prefs objectForKey:@"user_id"]];
    NSString *oldStr=[prefs objectForKey:keyStr];
    if( [prefs objectForKey:keyStr]!=nil)
        msgListArray =[self ToListss:oldStr:true];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                               ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [msgListArray sortedArrayUsingDescriptors:descriptors];
    msgListArray=[[NSMutableArray alloc]init];
    msgListArray=[reverseOrder mutableCopy];
    

    //[chatTableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
    NSString *urlString=[prefs objectForKey:@"SWACC"];
    if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
        [self postStatus1];
    }else{
        [self postStatus];
    }
    filteredContentList=[[NSMutableArray alloc]init];
    //if( [prefs objectForKey:[prefs objectForKey:@"user_id"]]!=nil)
        if ([MsgVO.senderID rangeOfString:@"U_"].location == NSNotFound) {
            //group
            NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
            filteredContentList=[self ToListss:[prefs objectForKey:keyStr]:false];
        }else{
        filteredContentList=[self ToListss:[prefs objectForKey:[prefs objectForKey:@"user_id"]]:false];
        }
    //if ([appDelegate.tabStr isEqualToString:@"Chats" ]) {
    MessageVO * mVO=[filteredContentList objectAtIndex:[filteredContentList count]-1];
    appDelegate.msgTotalCount=appDelegate.msgTotalCount-[mVO.unreadMsg intValue];
    [UIApplication sharedApplication].applicationIconBadgeNumber = appDelegate.msgTotalCount;

    MsgVO.unreadMsg=@"0";
    ChatVO * CV=[msgListArray objectAtIndex:[msgListArray count]-1];
    MsgVO.message=CV.message;
    MsgVO.msg_Date=CV.msg_Date;
    [self updatefunction:filteredContentList:MsgVO];
   // }
    [chatTableView reloadData];
    if ([msgListArray count]>0) {
        int lastRowNumber = [chatTableView numberOfRowsInSection:0] - 1;
        NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [chatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton=YES;
    appDelegate.userlistBool=false;
    appDelegate.msgchatBool=true;
    
    if ([appDelegate.documentsendStr isEqualToString:@"True"]) {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *urlString=[prefs objectForKey:@"SWACC"];
            if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
                commonURL=@"sendMsg";
                [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                [self performSelector:@selector(sendMsgAction1:) withObject:appDelegate.fileextentions afterDelay:1.0 ];
            }
            else{
                [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                [self performSelector:@selector(sendMsgAction:) withObject:appDelegate.fileextentions afterDelay:1.0 ];
            }
        }
}

-(void)updatefunction:(NSMutableArray *)userListArray : (MessageVO *)msgvo{
    //appDelegate.msgTotalCount=0;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    for (int count=0; count<[userListArray  count]; count++){
        MessageVO *msgvos=[userListArray objectAtIndex:count];
        NSLog(@"msgvos sender print %@",msgvos.senderID);
        if ([msgvo.senderID isEqualToString:msgvos.senderID]) {
            [userListArray removeObjectAtIndex:count];
        }
    }
    
    [userListArray addObject:msgvo];
    if ([MsgVO.senderID rangeOfString:@"U_"].location == NSNotFound) {
        //group
        NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
        [prefs setObject:[self ToStringss:userListArray : false] forKey:keyStr];

    }else{
    [prefs setObject:[self ToStringss:userListArray : false] forKey:[prefs objectForKey:@"user_id"]];
    }
//    for (int count=0; count<[userListArray  count]; count++){
//        MessageVO *msgvos1=[userListArray objectAtIndex:count];
//        appDelegate.msgTotalCount=appDelegate.msgTotalCount+[msgvos1.unreadMsg intValue];
//    }
//    NSLog(@"msgTotalCount %d ",appDelegate.msgTotalCount);
//    [UIApplication sharedApplication].applicationIconBadgeNumber = appDelegate.msgTotalCount;
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
    if (![str isEqualToString:@""]) {
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
    }
    return msgvo;
}
-(ChatVO *)StrtoObjchat :(NSString *)str  {
        ChatVO * chatvo=[[ChatVO alloc]init];
        NSString *seprator=@"%=";
    if (![str isEqualToString:@""]) {
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
    }
        return chatvo;
}

-(void)postStatus
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
            httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sender_id=%@&receiver_id=%@",MsgVO.senderID,[prefs objectForKey:@"user_id"]]];
            urlString = [[NSString alloc]initWithFormat:@"%@wsUpdateChatStatus.php",[prefs objectForKey:@"SWACC"]];
            url=[[NSURL alloc] initWithString:urlString];
            urlRequest=[NSMutableURLRequest requestWithURL:url];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        }else{
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:MsgVO.senderID forKey:@"sender_id"];
            [dict setValue:[prefs objectForKey:@"user_id"] forKey:@"receiver_id"];
            //convert object to data
            NSError *error;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
            
            urlRequest = [[NSMutableURLRequest alloc] init];
            [urlRequest setURL:[NSURL URLWithString:@"https://stg.benefitbridge.com/swacc/api/chatstatus"]];
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
                NSLog(@"content %@",content);
            }
        }];
    }
}
-(void)postStatus1{
    commonURL=@"Status";
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sender_id=%@&receiver_id=%@",MsgVO.senderID,[prefs objectForKey:@"user_id"]]];
    urlString = [[NSString alloc]initWithFormat:@"%@wsUpdateChatStatus.php",[prefs objectForKey:@"SWACC"]];
    url=[[NSURL alloc] initWithString:urlString];
    rest_url=url;
    NSData *postData = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connections = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connections start];

}


-(void)sendAction:(UIButton *)btn{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *urlString=[prefs objectForKey:@"SWACC"];
        if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
            commonURL=@"sendMsg";
            if (![msgText.text isEqualToString:@""]) {
                [msgText resignFirstResponder];
                [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            [self performSelector:@selector(sendMsgAction1:) withObject:msgText.text afterDelay:1.0 ];
            }
        }else{
//            if (_fileextentions==nil || [_fileextentions isEqualToString:@""]) {
                if (![msgText.text isEqualToString:@""]) {
                    [msgText resignFirstResponder];
                    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                [self performSelector:@selector(sendMsgAction:) withObject:msgText.text afterDelay:1.0 ];
                }
//            }
//            else{
//                [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
//                [self performSelector:@selector(sendMsgAction:) withObject:_fileextentions afterDelay:1.0 ];
//            }
        }
    
}

-(void)sendMsgAction:(NSString *)msgStr
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
            NSString *urlString,*str;
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSMutableURLRequest *urlRequest;
        if (appDelegate.fileByteStr==nil) {
            appDelegate.fileByteStr=[[NSString alloc]init];
        }
        
        if (appDelegate.forwardmsgArray==nil || [appDelegate.forwardmsgArray count]==0) {
            str = [msgStr stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
        }else{
            NSString *seprator=@"%=";
            NSArray* commonFields = [msgStr componentsSeparatedByString:seprator];
            str=[NSString stringWithFormat:@"%@",[commonFields objectAtIndex:0]];
            appDelegate.fileByteStr=[[NSString alloc]init];
            appDelegate.fileByteStr=[NSString stringWithFormat:@"%@",[commonFields objectAtIndex:1]];
            NSLog(@"appDelegate.fileByteStr %@",appDelegate.fileByteStr);
        }

//        if (![msgStr isEqualToString:@""]) {
//        }else{
//            str =msgText.text;// [msgText.text stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
//        }
//        NSString *uniText = [NSString stringWithUTF8String:[str UTF8String]];
//        NSData *msgData = [uniText dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//        NSString *goodMsg = [[NSString alloc] initWithData:msgData encoding:NSUTF8StringEncoding] ;

        
        NSString *urlString1=[prefs objectForKey:@"SWACC"];
        if ([urlString1 isEqualToString:@"http://192.168.0.37/swacc/"]) {
            httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sender_id=%@&receiver_id=%@&message=%@&attachment=%@",[prefs objectForKey:@"user_id"],MsgVO.senderID,str,appDelegate.fileByteStr]];
            urlString = [[NSString alloc]initWithFormat:@"%@wsSendChat.php",[prefs objectForKey:@"SWACC"]];
            url=[[NSURL alloc] initWithString:urlString];
            urlRequest=[NSMutableURLRequest requestWithURL:url];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        }else{
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[prefs objectForKey:@"user_id"] forKey:@"sender_id"];
            [dict setValue:MsgVO.senderID forKey:@"receiver_id"];
            [dict setValue:str forKey:@"message"];
            [dict setValue:appDelegate.fileByteStr forKey:@"attachment"];

            //convert object to data
            NSError *error;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
            
            urlRequest = [[NSMutableURLRequest alloc] init];
            [urlRequest setURL:[NSURL URLWithString:@"https://stg.benefitbridge.com/swacc/api/chatstatus"]];
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
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }else {
                        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                        NSString *result = [[NSString alloc]init];
                        result =[userDict objectForKey:@"result"];
                        int boolValue =[result intValue];
                        if (boolValue==1) {

                        NSDictionary *activityData=[userDict objectForKey:@"message"];
                        
                        NSString *chatid,*msg,*attachment;
                            //NSString *date;
                        chatid=[[NSString alloc]init];
                        //date=[[NSString alloc]init];
                        msg=[[NSString alloc]init];
                            attachment=[[NSString alloc]init];

                        if ([activityData objectForKey:@"chat_id"] != [NSNull null])
                            chatid=[activityData objectForKey:@"chat_id"];
                        
//                        if ([activityData objectForKey:@"date"] != [NSNull null])
//                            date=[activityData objectForKey:@"date"];
                        
                        if ([activityData objectForKey:@"msg"] != [NSNull null])
                            msg=[activityData objectForKey:@"msg"];

                            if ([activityData objectForKey:@"attachment"] != [NSNull null])
                                attachment=[activityData objectForKey:@"attachment"];

                            [activityImageView removeFromSuperview];
                        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                        
                        NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
                        [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        fbdateFormat.timeZone = [NSTimeZone systemTimeZone];
                        NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
                        NSString *dateStr= [[NSString alloc]initWithString:[fbdateFormat stringFromDate:today]];

                        if (![msgText.text isEqualToString:@""] || ![msgStr isEqualToString:@""]) {
                            NSString *keyStr=[NSString stringWithFormat:@"%@%@",MsgVO.senderID,[prefs objectForKey:@"user_id"]];
                            ChatVO *chatvo=[[ChatVO alloc]init];
                            chatvo.TrueStr=[[NSString alloc]init];
                            chatvo.chatid=[[NSString alloc]init];
                            chatvo.message=[[NSString alloc]init];
                            chatvo.msg_Date=[[NSString alloc]init];
                            chatvo.status=[[NSString alloc]init];
                            chatvo.attachment=[[NSString alloc]init];
                            chatvo.TrueStr=@"True";
                            chatvo.chatid=chatid;
                            chatvo.msg_Date=dateStr;
                            chatvo.message=[msg stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
                            chatvo.status=@"1";
                            chatvo.attachment=attachment;
                            [msgListArray addObject:chatvo];
                            
                            if (![attachment isEqualToString:@""]) {
                                NSArray* commonFields = [msg componentsSeparatedByString:@": "];
                                if ([commonFields count]>1) {
                                    NSData *pdfData1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:attachment]];
                                    
                                    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                    NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
                                    NSString *filePath1 = [documentsDirectory1 stringByAppendingPathComponent:[commonFields objectAtIndex:1]];
                                    [pdfData1 writeToFile:filePath1 atomically:YES];
                                    
                                    NSString* documentsPath1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                                    
                                    NSString* foofile = [documentsPath1 stringByAppendingPathComponent:[commonFields objectAtIndex:1]];
                                    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
                                    NSLog(@"fileExists%d",fileExists);
                                    
                                }else{
                                    
                                    NSData *pdfData1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:attachment]];
                                    
                                    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                    NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
                                    NSString *filePath1 = [documentsDirectory1 stringByAppendingPathComponent:msg];
                                    [pdfData1 writeToFile:filePath1 atomically:YES];

                                    NSString* documentsPath1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                                    
                                    NSString* foofile = [documentsPath1 stringByAppendingPathComponent:msg];
                                    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
                                    NSLog(@"fileExists%d",fileExists);
                                    
                                }
                            }

                            [prefs setObject:[self ToStringss:msgListArray : true] forKey:keyStr];

                            filteredContentList=[[NSMutableArray alloc]init];
                            //if( [prefs objectForKey:[prefs objectForKey:@"user_id"]]!=nil)
                                if ([MsgVO.senderID rangeOfString:@"U_"].location == NSNotFound) {
                                    //group
                                    NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
                                    filteredContentList=[self ToListss:[prefs objectForKey:keyStr]:false];
                                }else{
                                filteredContentList=[self ToListss:[prefs objectForKey:[prefs objectForKey:@"user_id"]]:false];
                                }
                                MsgVO.unreadMsg=@"0";
                                MsgVO.message=[msg stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
                                MsgVO.chatid=chatid;
                                MsgVO.msg_Date=dateStr;
                            [self updatefunction:filteredContentList:MsgVO];
                            msgText.text=@"";
                        }
                            
                            appDelegate.fileextentions=@"";
                            appDelegate.documentsendStr=@"";
                            appDelegate.forwardmsgArray=[[NSMutableArray alloc]init];
                    }
                    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                                               ascending:YES];
                    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
                    NSArray *reverseOrder = [msgListArray sortedArrayUsingDescriptors:descriptors];
                    msgListArray=[[NSMutableArray alloc]init];
                    msgListArray=[reverseOrder mutableCopy];

                    [activityImageView removeFromSuperview];
                    [chatTableView reloadData];
                    if ([msgListArray count]>0) {
                        int lastRowNumber = [chatTableView numberOfRowsInSection:0] - 1;
                        NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
                        [chatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
                    }
                        [activityImageView removeFromSuperview];
                        appDelegate.fileByteStr=[[NSString alloc]init];
                }
                }
        }];
    }
}
-(void)sendMsgAction1:(NSString *)msgStr{
    forwardmsgStr=[[NSString alloc]init];
    forwardmsgStr=msgStr;
    commonURL=@"sendMsg";
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString,*str;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        str = [msgStr stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
    if (appDelegate.fileByteStr==nil) {
        appDelegate.fileByteStr=[[NSString alloc]init];
    }
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sender_id=%@&receiver_id=%@&message=%@&attachment=%@",[prefs objectForKey:@"user_id"],MsgVO.senderID,str,appDelegate.fileByteStr]];
    urlString = [[NSString alloc]initWithFormat:@"%@wsSendChat.php",[prefs objectForKey:@"SWACC"]];
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
    if ([commonURL isEqualToString:@"Status"]) {
        
    }
    else if([commonURL isEqualToString:@"sendMsg"]){
        [activityImageView removeFromSuperview];
    NSError *error;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"WE Got %@ :)",dic);
    NSString *result = [[NSString alloc]init];
    result =[dic objectForKey:@"result"];
        int boolValue =[result intValue];
        if (boolValue==1) {
        NSDictionary *activityData=[dic objectForKey:@"message"];
        NSString *chatid,*date,*msg,*attachment;
        chatid=[[NSString alloc]init];
        date=[[NSString alloc]init];
        msg=[[NSString alloc]init];
            attachment=[[NSString alloc]init];

        if ([activityData objectForKey:@"chat_id"] != [NSNull null])
            chatid=[activityData objectForKey:@"chat_id"];
        
        if ([activityData objectForKey:@"date"] != [NSNull null])
            date=[activityData objectForKey:@"date"];
        
        if ([activityData objectForKey:@"msg"] != [NSNull null])
            msg=[activityData objectForKey:@"msg"];

            if ([activityData objectForKey:@"attachment"] != [NSNull null])
                attachment=[activityData objectForKey:@"attachment"];

    [activityImageView removeFromSuperview];
        
        NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
        [fbdateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        fbdateFormat.timeZone = [NSTimeZone systemTimeZone];
        NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
        NSString *dateStr= [[NSString alloc]initWithString:[fbdateFormat stringFromDate:today]];
        
        if (![msgText.text isEqualToString:@""] || ![forwardmsgStr isEqualToString:@""]) {
            NSString *keyStr=[NSString stringWithFormat:@"%@%@",MsgVO.senderID,[prefs objectForKey:@"user_id"]];
            ChatVO *chatvo=[[ChatVO alloc]init];
            chatvo.TrueStr=[[NSString alloc]init];
            chatvo.chatid=[[NSString alloc]init];
            chatvo.message=[[NSString alloc]init];
            chatvo.msg_Date=[[NSString alloc]init];
            chatvo.status=[[NSString alloc]init];
            chatvo.attachment=[[NSString alloc]init];
            chatvo.TrueStr=@"True";
            chatvo.message=[msg stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
            chatvo.chatid=chatid;
            chatvo.msg_Date=dateStr;
            chatvo.status=@"1";
            chatvo.attachment=attachment;
            [msgListArray addObject:chatvo];
            if (![attachment isEqualToString:@""]) {
                NSArray* commonFields = [msg componentsSeparatedByString:@": "];
                if ([commonFields count]>1) {
                    NSData *pdfData1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:attachment]];
                    
                    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
                    NSString *filePath1 = [documentsDirectory1 stringByAppendingPathComponent:[commonFields objectAtIndex:1]];
                    [pdfData1 writeToFile:filePath1 atomically:YES];
                    
                    NSString* documentsPath1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                    
                    NSString* foofile = [documentsPath1 stringByAppendingPathComponent:[commonFields objectAtIndex:1]];
                    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
                    NSLog(@"fileExists%d",fileExists);
                    
                }else{
                    
                    NSData *pdfData1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:attachment]];
                    
                    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
                    NSString *filePath1 = [documentsDirectory1 stringByAppendingPathComponent:msg];
                    [pdfData1 writeToFile:filePath1 atomically:YES];
                    
                    NSString* documentsPath1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                    
                    NSString* foofile = [documentsPath1 stringByAppendingPathComponent:msg];
                    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
                    NSLog(@"fileExists%d",fileExists);
                    
                }
            }

            [prefs setObject:[self ToStringss:msgListArray : true] forKey:keyStr];
            
            filteredContentList=[[NSMutableArray alloc]init];
            //if( [prefs objectForKey:[prefs objectForKey:@"user_id"]]!=nil)
            if ([MsgVO.senderID rangeOfString:@"U_"].location == NSNotFound) {
                //group
                NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
                filteredContentList=[self ToListss:[prefs objectForKey:keyStr]:false];
            }else{
                filteredContentList=[self ToListss:[prefs objectForKey:[prefs objectForKey:@"user_id"]]:false];
            }
                MsgVO.unreadMsg=@"0";
                MsgVO.message=[msg stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
                MsgVO.chatid=chatid;
                MsgVO.msg_Date=dateStr;
            [self updatefunction:filteredContentList:MsgVO];
            
            msgText.text=@"";
        }
    
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"msg_Date"
                                                               ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [msgListArray sortedArrayUsingDescriptors:descriptors];
    msgListArray=[[NSMutableArray alloc]init];
    msgListArray=[reverseOrder mutableCopy];
    
    [activityImageView removeFromSuperview];
    [chatTableView reloadData];
    if ([msgListArray count]>0) {
        int lastRowNumber = [chatTableView numberOfRowsInSection:0] - 1;
        NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [chatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            
            appDelegate.fileextentions=@"";
            appDelegate.documentsendStr=@"";
            appDelegate.fileByteStr=[[NSString alloc]init];

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
        // accept the certificate anyway
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    else
    {
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
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
    activityImageView.frame = CGRectMake(self.view.frame.size.width/2-35,self.view.frame.size.height/2-35,70,70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -250; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(IBAction)CancelAction:(id)sender{
    if ([selectMsgArray count]==0) {
    forwardmsgStr=@"";
    appDelegate.forwardmsgArray=[[NSMutableArray alloc]init];
    [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationItem setRightBarButtonItems:@[] animated:NO];
        [navigationView setFrame:CGRectMake(0, 0, 300, 30)];
        [titleLbl setFrame:CGRectMake(40, 0, 300, 30)];
        
        UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [RightBtn setFrame:CGRectMake(0, 0,30,30)];
        [RightBtn addTarget:self action:@selector(attachMentAction) forControlEvents:UIControlEventTouchUpInside];
        [RightBtn setBackgroundImage:[UIImage imageNamed:@"attach_white.png"] forState:UIControlStateNormal];
        UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithCustomView:RightBtn];
        //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
        self.navigationItem.rightBarButtonItem = btn1;
        forwardmsgStr=@"";
        appDelegate.forwardmsgArray=[[NSMutableArray alloc]init];
        selectMsgArray=[[NSMutableArray alloc]init];
        [chatTableView reloadData];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 5; // you can have your own choice, of course
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [msgListArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];

    if ([self.selectMsgArray containsObject:indexPath])
    {
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"d9d9d9"];
    }
    else
    {
        cell.contentView.backgroundColor = [UIColor clearColor];
    }

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont * font2 =[UIFont fontWithName:@"Open Sans" size:14.0f];
    ChatVO *chatvos=[msgListArray objectAtIndex:indexPath.row];

    if (![chatvos.TrueStr isEqualToString:@"True"]) {
        
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:chatvos.message];
        UIFont *font = [UIFont systemFontOfSize:14];
        [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
        NSUInteger strcount = [chatvos.message length];
        int width=0;
        if (strcount<10) {
            width=screenRect.size.width*.30;
        }else if (strcount<20){
            width=screenRect.size.width*.45;
        }else if(strcount<30){
            width=screenRect.size.width*.60;
        }else{
            width=screenRect.size.width*.68;
        }
        UIView* customView;
        UITextView *msgLbl;
        if ([MsgVO.senderID rangeOfString:@"U_"].location == NSNotFound) {

            if (![chatvos.attachment isEqualToString:@""] && chatvos.attachment!=nil) {
                NSArray* commonFields = [chatvos.message componentsSeparatedByString:@": "];
                UILabel *nameoflabel,*imagename;
                customView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*.045,screenRect.size.height*.005,screenRect.size.width*.60,screenRect.size.width*.60)];
                [customView setBackgroundColor:[UIColor colorWithHexString:@"F9F4F0"]];
                customView.layer.cornerRadius=9.0f;

                //msgLbl=[[UITextView alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,customView.bounds.size.height-30, width-30,15)];
                
                if ([commonFields count]<2) {
                    [msgLbl setText:chatvos.message];
                    [msgLbl setTextColor:[UIColor blackColor]];
                }
                else{
                    
                    imagename=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.03,customView.bounds.size.height-20, width-30,15)];
                    imagename.font=[UIFont fontWithName:@"Open Sans" size:11.0f];
                    [imagename setTextColor:[UIColor colorWithHexString:@"4E7FC0"]];
                    imagename.lineBreakMode = NSLineBreakByWordWrapping;
                    imagename.textAlignment = NSTextAlignmentLeft;
                    [customView addSubview:imagename];

                    nameoflabel=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,2, screenRect.size.width*55.0,20)];
                    [nameoflabel setText:[commonFields objectAtIndex:0]];
                    nameoflabel.font=font2;
                    [nameoflabel setTextColor:[UIColor colorWithHexString:@"4E7FC0"]];
                    nameoflabel.lineBreakMode = NSLineBreakByWordWrapping;
                    nameoflabel.textAlignment = NSTextAlignmentLeft;
                    [customView addSubview:nameoflabel];
                    
                    NSString * msgStr=[chatvos.message stringByReplacingOccurrencesOfString:@": "withString:@"\n"];
                    NSMutableAttributedString * stringss = [[NSMutableAttributedString alloc] initWithString:[commonFields objectAtIndex:1]];
                    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,[[commonFields objectAtIndex:1] length])];
                    //                    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange([[commonFields objectAtIndex:0] length],[[commonFields objectAtIndex:1] length])];
                    imagename.attributedText=stringss;
                    
                    
                }
                

                UIImage *image = [UIImage imageNamed:@"leftcornor1.png"];
                UIImageView *myImageView = [[UIImageView alloc] initWithImage:image];
                myImageView.frame = CGRectMake(-20, customView.bounds.size.height-30, 30, 30);
                [customView addSubview:myImageView];
                
//                msgLbl=[[UITextView alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,screenRect.size.height*08.0, width-15,screenRect.size.height*02.0)];

                if ([chatvos.attachment rangeOfString:@".png"].location == NSNotFound) {
                    UIImageView *attachmentimage = [[UIImageView alloc] initWithFrame:CGRectMake(screenRect.size.width*.07,screenRect.size.width*.07, screenRect.size.width*.40,screenRect.size.width*.45)];
                    UIImage *image12 = [UIImage imageNamed:@"file.png"];
                    attachmentimage.image=image12;
                    [customView addSubview:attachmentimage];

                }else{
                    NSArray* commonFields = [chatvos.message componentsSeparatedByString:@": "];
                    if ([commonFields count]>1) {
                NSString* fileName = [NSString stringWithFormat:@"%@", [commonFields objectAtIndex:1]];
                NSArray *arrayPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *path = [arrayPaths objectAtIndex:0];
                NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
                UIImage *image1=[UIImage imageWithContentsOfFile:pdfFileName];
                UIImageView *attachmentimage = [[UIImageView alloc] initWithFrame:CGRectMake(5,screenRect.size.width*.07, screenRect.size.width*.57,screenRect.size.width*.45)];
                //UIImage *image12 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:chatvos.attachment]]];
                attachmentimage.image=image1;
                [customView addSubview:attachmentimage];
                    }
                }
        }
        else
        {
        NSArray* commonFields = [chatvos.message componentsSeparatedByString:@": "];

        customView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*.045,screenRect.size.height*.005, width,[self textViewHeightForAttributedText:title andWidth:screenRect.size.width-80]+30)];
        [customView setBackgroundColor:[UIColor colorWithHexString:@"F9F4F0"]];
        customView.layer.cornerRadius=9.0f;
        
        UIImage *image = [UIImage imageNamed:@"leftcornor1.png"];
        UIImageView *myImageView = [[UIImageView alloc] initWithImage:image];
        myImageView.frame = CGRectMake(-20, customView.bounds.size.height-30, 30, 30);
        [customView addSubview:myImageView];

        msgLbl=[[UITextView alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,0, width-15,[self textViewHeightForAttributedText:title andWidth:screenRect.size.width-80]+25)];
        
            if ([commonFields count]<2) {
                [msgLbl setText:chatvos.message];
                [msgLbl setTextColor:[UIColor blackColor]];
            }
            else{
               NSString * msgStr=[chatvos.message stringByReplacingOccurrencesOfString:@": "withString:@"\n"];
                NSMutableAttributedString * stringss = [[NSMutableAttributedString alloc] initWithString:msgStr];
                [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"4E7FC0"] range:NSMakeRange(0,[[commonFields objectAtIndex:0] length])];
                [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange([[commonFields objectAtIndex:0] length],[[commonFields objectAtIndex:1] length])];
                msgLbl.attributedText=stringss;
            }
        }
        }else{
            if (![chatvos.attachment isEqualToString:@""] && chatvos.attachment!=nil) {
                
                customView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*.045,screenRect.size.height*.005,screenRect.size.width*.60,screenRect.size.width*.60)];
                [customView setBackgroundColor:[UIColor colorWithHexString:@"F9F4F0"]];
                customView.layer.cornerRadius=9.0f;
                
                UIImage *image = [UIImage imageNamed:@"leftcornor1.png"];
                UIImageView *myImageView = [[UIImageView alloc] initWithImage:image];
                myImageView.frame = CGRectMake(-20, customView.bounds.size.height-30, 30, 30);
                [customView addSubview:myImageView];
                
               // msgLbl=[[UITextView alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,screenRect.size.height*08.0, width-15,screenRect.size.height*02.0)];
                if ([chatvos.attachment rangeOfString:@".png"].location == NSNotFound) {
                    UIImageView *attachmentimage = [[UIImageView alloc] initWithFrame:CGRectMake(5,5, screenRect.size.width*.58,screenRect.size.width*.50)];
                    UIImage *image12 = [UIImage imageNamed:@"file.png"];
                    attachmentimage.image=image12;
                    [customView addSubview:attachmentimage];
                    
                }else{

                        NSString* fileName = [NSString stringWithFormat:@"%@",chatvos.message];
                        NSArray *arrayPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                        NSString *path = [arrayPaths objectAtIndex:0];
                        NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
                        UIImage *image1=[UIImage imageWithContentsOfFile:pdfFileName];
                UIImageView *attachmentimage = [[UIImageView alloc] initWithFrame:CGRectMake(5,5, screenRect.size.width*.57,screenRect.size.width*.50)];
                //UIImage *image12 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:chatvos.attachment]]];
                attachmentimage.image=image1;
                [customView addSubview:attachmentimage];
                    
                }
                UILabel *imagename=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.03,customView.bounds.size.height-20, width-30,15)];
                imagename.font=[UIFont fontWithName:@"Open Sans" size:11.0f];
                [imagename setTextColor:[UIColor colorWithHexString:@"4E7FC0"]];
                imagename.lineBreakMode = NSLineBreakByWordWrapping;
                imagename.textAlignment = NSTextAlignmentLeft;
                [imagename setText:chatvos.message];
                [customView addSubview:imagename];

                
            }
            else
            {

            customView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*.045,screenRect.size.height*.005, width,[self textViewHeightForAttributedText:title andWidth:screenRect.size.width-80]+20)];
            [customView setBackgroundColor:[UIColor colorWithHexString:@"F9F4F0"]];
            customView.layer.cornerRadius=9.0f;
            
            UIImage *image = [UIImage imageNamed:@"leftcornor1.png"];
            UIImageView *myImageView = [[UIImageView alloc] initWithImage:image];
            myImageView.frame = CGRectMake(-20, customView.bounds.size.height-30, 30, 30);
            [customView addSubview:myImageView];
            
            msgLbl=[[UITextView alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,0, width-15,[self textViewHeightForAttributedText:title andWidth:screenRect.size.width-80]+15)];

            [msgLbl setText:chatvos.message];
            [msgLbl setTextColor:[UIColor blackColor]];
            }
        }
        msgLbl.font=font2;
        msgLbl.textAlignment = NSTextAlignmentLeft;
//        msgLbl.lineBreakMode = NSLineBreakByWordWrapping;
//        msgLbl.numberOfLines = 0;
        msgLbl.clipsToBounds = YES;
        msgLbl.layer.cornerRadius=9.0f;
        [msgLbl setBackgroundColor:[UIColor colorWithHexString:@"F9F4F0"]];
        msgLbl.editable = NO;
        msgLbl.dataDetectorTypes = UIDataDetectorTypeAll;
        msgLbl.scrollEnabled=NO;
        [customView addSubview:msgLbl];
        
        UILabel *dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(customView.bounds.size.width-55,customView.bounds.size.height-20,50,20)];
        NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
        NSString *fbdate=[NSString stringWithFormat:@"%@",[[chatvos.msg_Date componentsSeparatedByString:@""] objectAtIndex:0]];
        [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *facebookdate = [fbdateFormat dateFromString:fbdate];
        NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
        
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* componentsmsg = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:facebookdate];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
        NSInteger  currentyear = [components year];
        NSInteger  msgyear = [componentsmsg year];

        NSInteger  currentmonth = [components month];
        NSInteger  msgmonth = [componentsmsg month];

        if(currentyear!=msgyear){
            NSString *fbdate1=[NSString stringWithFormat:@"%@",[[chatvos.msg_Date componentsSeparatedByString:@" "] objectAtIndex:0]];
            NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
            [timeFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *timedate = [timeFormat dateFromString:fbdate1];
            NSDateFormatter *timeFormat123 = [[NSDateFormatter alloc] init];
            [timeFormat123 setDateFormat:@"dd MMM yy"];
            NSString *dateString = [timeFormat123 stringFromDate:timedate];
            dateLbl.text=dateString;
        }else if(currentmonth!=msgmonth){
            NSString *fbdate1=[NSString stringWithFormat:@"%@",[[chatvos.msg_Date componentsSeparatedByString:@" "] objectAtIndex:0]];
            NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
            [timeFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *timedate = [timeFormat dateFromString:fbdate1];
            NSDateFormatter *timeFormat123 = [[NSDateFormatter alloc] init];
            [timeFormat123 setDateFormat:@"dd MMM"];
            NSString *dateString = [timeFormat123 stringFromDate:timedate];
            dateLbl.text=dateString;
        }else {
            NSString *fbdate1=[NSString stringWithFormat:@"%@",[[chatvos.msg_Date componentsSeparatedByString:@" "] objectAtIndex:1]];
            if ([[[fbdate1 componentsSeparatedByString:@":"] objectAtIndex:0] isEqualToString:@"00"]) {
                dateLbl.text=[NSString stringWithFormat:@"%@:%@",[[fbdate1 componentsSeparatedByString:@":"] objectAtIndex:0],[[fbdate1 componentsSeparatedByString:@":"] objectAtIndex:1]];
            }else{
            NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
            [timeFormat setDateFormat:@"HH:mm:ss"];
            NSDate *timedate = [timeFormat dateFromString:fbdate1];
            NSDateFormatter *timeFormat123 = [[NSDateFormatter alloc] init];
            [timeFormat123 setDateFormat:@"hh:mm a"];
            NSString *dateString = [timeFormat123 stringFromDate:timedate];
            dateLbl.text=dateString ;
            }
        }
        dateLbl.font=[UIFont fontWithName:@"Open Sans" size:9.0f];
        [dateLbl setTextColor:[UIColor blackColor]];
        dateLbl.textAlignment = NSTextAlignmentLeft;
        [dateLbl setBackgroundColor:[UIColor colorWithHexString:@"F9F4F0"]];
        [customView addSubview:dateLbl];
        [cell.contentView addSubview:customView];
        

    }else{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:chatvos.message];
    [title addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(0, title.length)];
        NSUInteger strcount = [chatvos.message length];
        int width=0;
        if (strcount<10) {
            width=screenRect.size.width*.30;
        }else if (strcount<20){
            width=screenRect.size.width*.52;
        }else if(strcount<30){
            width=screenRect.size.width*.65;
        }else{
            width=screenRect.size.width*.68;
        }
        UIView*customView;
        if (![chatvos.attachment isEqualToString:@""] && chatvos.attachment!=nil) {
    
            customView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*.35,screenRect.size.height*.005, screenRect.size.width*.60,screenRect.size.width*.60)];
            [customView setBackgroundColor:[UIColor colorWithHexString:@"FCD0C5"]];
            customView.layer.cornerRadius=9.0f;
            
            UIImage *image = [UIImage imageNamed:@"right_cornor1.png"];
            UIImageView *myImageView = [[UIImageView alloc] initWithImage:image];
            myImageView.frame = CGRectMake(customView.bounds.size.width-9, customView.bounds.size.height-30, 30, 30);
            [customView addSubview:myImageView];
            
            // msgLbl=[[UITextView alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,screenRect.size.height*08.0, width-15,screenRect.size.height*02.0)];
            if ([chatvos.attachment rangeOfString:@".png"].location == NSNotFound) {
                UIImageView *attachmentimage = [[UIImageView alloc] initWithFrame:CGRectMake(5,5, screenRect.size.width*.57,screenRect.size.width*.50)];
                UIImage *image12 = [UIImage imageNamed:@"file.png"];
                attachmentimage.image=image12;
                [customView addSubview:attachmentimage];
                
            }else{

                    NSString* fileName = [NSString stringWithFormat:@"%@", chatvos.message];
                    NSArray *arrayPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                    NSString *path = [arrayPaths objectAtIndex:0];
                    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
                    UIImage *image1=[UIImage imageWithContentsOfFile:pdfFileName];
            UIImageView *attachmentimage = [[UIImageView alloc] initWithFrame:CGRectMake(5,5, screenRect.size.width*.57,screenRect.size.width*.50)];
            //UIImage *image12 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:chatvos.attachment]]];
            attachmentimage.image=image1;
            [customView addSubview:attachmentimage];
                
            }
            UILabel *imagename=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.03,customView.bounds.size.height-20, width-30,15)];
            imagename.font=[UIFont fontWithName:@"Open Sans" size:11.0f];
            [imagename setTextColor:[UIColor colorWithHexString:@"4E7FC0"]];
            imagename.lineBreakMode = NSLineBreakByWordWrapping;
            imagename.textAlignment = NSTextAlignmentLeft;
            [imagename setText:chatvos.message];
            [customView addSubview:imagename];
            
            
        }else{
     customView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width-(width+15),screenRect.size.height*.005, width,[self textViewHeightForAttributedText:title andWidth:screenRect.size.width-80]+20)];
    [customView setBackgroundColor:[UIColor colorWithHexString:@"FCD0C5"]];
    customView.layer.cornerRadius=9.0f;

        UIImage *image = [UIImage imageNamed:@"right_cornor1.png"];
        UIImageView *myImageView = [[UIImageView alloc] initWithImage:image];
        myImageView.frame = CGRectMake(customView.bounds.size.width-9, customView.bounds.size.height-30, 30, 30);
        [customView addSubview:myImageView];

        
    UITextView *msgLbl=[[UITextView alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,0, width-15,[self textViewHeightForAttributedText:title andWidth:screenRect.size.width-80]+15)];
    [msgLbl setText:chatvos.message];
    msgLbl.font=font2;
    [msgLbl setTextColor:[UIColor blackColor]];
    msgLbl.textAlignment = NSTextAlignmentLeft;
//    msgLbl.lineBreakMode = NSLineBreakByWordWrapping;
//    msgLbl.numberOfLines = 0;
    msgLbl.clipsToBounds = YES;
    msgLbl.layer.cornerRadius=9.0f;
    [msgLbl setBackgroundColor:[UIColor colorWithHexString:@"FCD0C5"]];
    msgLbl.editable = NO;
    msgLbl.dataDetectorTypes = UIDataDetectorTypeAll;
        msgLbl.scrollEnabled=NO;
    [customView addSubview:msgLbl];
        }
        UILabel *dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(customView.bounds.size.width-50,customView.bounds.size.height-15,50,15)];
        NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
        NSString *fbdate=[NSString stringWithFormat:@"%@",[[chatvos.msg_Date componentsSeparatedByString:@""] objectAtIndex:0]];
        [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *facebookdate = [fbdateFormat dateFromString:fbdate];
        //[fbdateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        fbdateFormat.timeZone = [NSTimeZone systemTimeZone];
        NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* componentsmsg = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:facebookdate];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
        NSInteger  currentyear = [components year];
        NSInteger  msgyear = [componentsmsg year];
        NSInteger  currentmonth = [components month];
        NSInteger  msgmonth = [componentsmsg month];
        
        if(currentyear!=msgyear){
            NSString *fbdate1=[NSString stringWithFormat:@"%@",[[chatvos.msg_Date componentsSeparatedByString:@" "] objectAtIndex:0]];
            NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
            [timeFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *timedate = [timeFormat dateFromString:fbdate1];
            NSDateFormatter *timeFormat123 = [[NSDateFormatter alloc] init];
            [timeFormat123 setDateFormat:@"dd MMM yy"];
            NSString *dateString = [timeFormat123 stringFromDate:timedate];
            dateLbl.text=dateString;
        }else if(currentmonth!=msgmonth){
            NSString *fbdate1=[NSString stringWithFormat:@"%@",[[chatvos.msg_Date componentsSeparatedByString:@" "] objectAtIndex:0]];
            NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
            [timeFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *timedate = [timeFormat dateFromString:fbdate1];
            NSDateFormatter *timeFormat123 = [[NSDateFormatter alloc] init];
            [timeFormat123 setDateFormat:@"dd MMM"];
            NSString *dateString = [timeFormat123 stringFromDate:timedate];
            dateLbl.text=dateString;
        }else {
            NSString *fbdate1=[NSString stringWithFormat:@"%@",[[chatvos.msg_Date componentsSeparatedByString:@" "] objectAtIndex:1]];
            if ([[[fbdate1 componentsSeparatedByString:@":"] objectAtIndex:0] isEqualToString:@"00"]) {
                dateLbl.text=[NSString stringWithFormat:@"%@:%@ AM",[[fbdate1 componentsSeparatedByString:@":"] objectAtIndex:0],[[fbdate1 componentsSeparatedByString:@":"] objectAtIndex:1]];
            }else{
            NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
            [timeFormat setDateFormat:@"HH:mm:ss"];
            NSDate *timedate = [timeFormat dateFromString:fbdate1];
            NSDateFormatter *timeFormat123 = [[NSDateFormatter alloc] init];
            [timeFormat123 setDateFormat:@"hh:mm a"];
            NSString *dateString = [timeFormat123 stringFromDate:timedate];
            dateLbl.text=dateString ;
            }
        }
        dateLbl.font=[UIFont fontWithName:@"Open Sans" size:9.0f];
        [dateLbl setTextColor:[UIColor blackColor]];
        dateLbl.textAlignment = NSTextAlignmentLeft;
        [dateLbl setBackgroundColor:[UIColor colorWithHexString:@"FCD0C5"]];
        [customView addSubview:dateLbl];
        [cell.contentView addSubview:customView];

    [cell.contentView addSubview:customView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds
    lpgr.delegate = self;
    [self.chatTableView addGestureRecognizer:lpgr];
    

    return cell;
}
- (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)text andWidth:(CGFloat)width
{
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:text];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}
- (int)timeDifference:(NSDate *)fromDate ToDate:(NSDate *)toDate{
    NSTimeInterval distanceBetweenDates = [fromDate timeIntervalSinceDate:toDate];
    return distanceBetweenDates;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    ChatVO *chatvos=[msgListArray objectAtIndex:indexPath.row];
    if (![chatvos.attachment isEqualToString:@""] && chatvos.attachment!=nil) {
        return screenRect.size.width*.61;
    }else{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:chatvos.message];
    UIFont * font2 =[UIFont fontWithName:@"Open Sans" size:14.0f];
    [title addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(0, title.length)];
        return [self textViewHeightForAttributedText:title andWidth:screenRect.size.width-80]+40;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([selectMsgArray count]==0) {
    ChatVO *chatvos=[msgListArray objectAtIndex:indexPath.row];
    if (![chatvos.attachment isEqualToString:@""] && chatvos.attachment!=nil) {
        NSArray* commonFields = [chatvos.message componentsSeparatedByString:@": "];
        appDelegate.urlStr=[[NSString alloc]init];
        
        if ([commonFields count]>1) {
            NSString* fileName = [NSString stringWithFormat:@"%@",[commonFields objectAtIndex:1]];
            appDelegate.urlStr=fileName;
        }
        else{
            NSString* fileName = [NSString stringWithFormat:@"%@",chatvos.message];
            appDelegate.urlStr=fileName;
        }
    PdfviewerViewController * pdfviewer;
    pdfviewer= [[PdfviewerViewController alloc] initWithNibName:@"PdfviewerViewController" bundle:nil];
    [self.navigationController pushViewController:pdfviewer animated:YES];
    }
    }
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.chatTableView];
    
    NSIndexPath *indexPath = [self.chatTableView indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UITableViewCell *cell = (UITableViewCell *)[chatTableView cellForRowAtIndexPath:indexPath];
        if (cell.contentView.backgroundColor==[UIColor colorWithHexString:@"d9d9d9"]) {
            cell.contentView.backgroundColor = [UIColor clearColor];
            [selectMsgArray removeObject:indexPath];
            ChatVO *chatvos=[msgListArray objectAtIndex:indexPath.row];
            NSString *seprator=@"%=";
            NSArray* commonFields = [chatvos.message componentsSeparatedByString:@": "];
            if ([commonFields count]>1) {
                NSString *aattachmentStr=[NSString stringWithFormat:@"%@%@%@",[commonFields objectAtIndex:1],seprator,chatvos.attachment];
                [appDelegate.forwardmsgArray removeObject:aattachmentStr];
                NSLog(@"appDelegate.forwardmsgArray %@",appDelegate.forwardmsgArray);
            }else{
                NSString *aattachmentStr=[NSString stringWithFormat:@"%@%@%@",chatvos.message,seprator,chatvos.attachment];
                [appDelegate.forwardmsgArray removeObject:aattachmentStr];
                NSLog(@"appDelegate.forwardmsgArray %@",appDelegate.forwardmsgArray);
            }

            NSLog(@"array %ld", [selectMsgArray count]);
            if ([selectMsgArray count]==0) {
                [self.navigationItem setRightBarButtonItems:@[] animated:NO];
                [navigationView setFrame:CGRectMake(0, 0, 300, 30)];
                [titleLbl setFrame:CGRectMake(40, 0, 300, 30)];

                UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                [RightBtn setFrame:CGRectMake(0, 0,30,30)];
                [RightBtn addTarget:self action:@selector(attachMentAction) forControlEvents:UIControlEventTouchUpInside];
                [RightBtn setBackgroundImage:[UIImage imageNamed:@"attach_white.png"] forState:UIControlStateNormal];
                UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithCustomView:RightBtn];
                //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
                self.navigationItem.rightBarButtonItem = btn1;
                appDelegate.forwardmsgArray=[[NSMutableArray alloc]init];
            }else{
                tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
                [self.view addGestureRecognizer:tap];

            }
        }else{
            
            tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
            [self.view addGestureRecognizer:tap];
            [navigationView setFrame:CGRectMake(0, 0, 100, 30)];
            [titleLbl setFrame:CGRectMake(40, 0, 100, 30)];

            lpgr.minimumPressDuration = 0.3; //seconds
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"d9d9d9"];
            [selectMsgArray addObject:indexPath];
            
            ChatVO *chatvos=[msgListArray objectAtIndex:indexPath.row];

            NSArray* commonFields = [chatvos.message componentsSeparatedByString:@": "];
            if ([commonFields count]>1) {
                NSString *seprator=@"%=";
                NSString *aattachmentStr=[NSString stringWithFormat:@"%@%@%@",[commonFields objectAtIndex:1],seprator,chatvos.attachment];
                [appDelegate.forwardmsgArray addObject:aattachmentStr];
            }else{
                NSString *seprator=@"%=";
                NSString *aattachmentStr=[NSString stringWithFormat:@"%@%@%@",chatvos.message,seprator,chatvos.attachment];
                [appDelegate.forwardmsgArray addObject:aattachmentStr];
            }

            NSLog(@"appDelegate.forwardmsgArray %@",appDelegate.forwardmsgArray);

            NSLog(@"array %ld", [selectMsgArray count]);
            
            UIButton *rightBtnDelete = [UIButton buttonWithType:UIButtonTypeSystem];
            [rightBtnDelete removeFromSuperview];
            UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
            [rightBtnDelete setFrame:CGRectMake(30, 0,30,30)];
            //[rightBtn setTitle:@"Edit" forState:UIControlStateNormal];
            [rightBtnDelete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
            [rightBtnDelete setBackgroundImage:[UIImage imageNamed:@"delete_white.png"] forState:UIControlStateNormal];
            rightBtnDelete.titleLabel.font = fontss;
            [rightBtnDelete setTintColor:[UIColor colorWithHexString:@"#03687f"]];
            
            UIButton *rightBtnforword = [UIButton buttonWithType:UIButtonTypeSystem];
            [rightBtnforword removeFromSuperview];
            [rightBtnforword setFrame:CGRectMake(30, 0,30,30)];
            [rightBtnforword addTarget:self action:@selector(forwardAction:) forControlEvents:UIControlEventTouchUpInside];
            [rightBtnforword setBackgroundImage:[UIImage imageNamed:@"fwd_arrow_white.png"] forState:UIControlStateNormal];
            rightBtnforword.titleLabel.font = fontss;
            [rightBtnforword setTintColor:[UIColor colorWithHexString:@"#03687f"]];

            UIButton *rightBtnclearall = [UIButton buttonWithType:UIButtonTypeSystem];
            [rightBtnclearall removeFromSuperview];
            [rightBtnclearall setFrame:CGRectMake(30, 0,30,30)];
            [rightBtnclearall addTarget:self action:@selector(overlayDisplay) forControlEvents:UIControlEventTouchUpInside];
            [rightBtnclearall setBackgroundImage:[UIImage imageNamed:@"more_white.png"] forState:UIControlStateNormal];
            rightBtnclearall.titleLabel.font = fontss;
            [rightBtnclearall setTintColor:[UIColor colorWithHexString:@"#03687f"]];

            UIBarButtonItem *btnsdel = [[UIBarButtonItem alloc]initWithCustomView:rightBtnDelete];
            UIBarButtonItem *btnsfrwd = [[UIBarButtonItem alloc]initWithCustomView:rightBtnforword];
            UIBarButtonItem *btnsclearall = [[UIBarButtonItem alloc]initWithCustomView:rightBtnclearall];
            [self.navigationItem setRightBarButtonItems:@[btnsclearall,btnsfrwd,btnsdel] animated:NO];
                }
            NSLog(@"long press on table view at row %ld", indexPath.row);
            }
            else
        {
        NSLog(@"gestureRecognizer.state = %ld", gestureRecognizer.state);
    }
    
}
-(void)attachMentAction{
//    
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Attachment file" delegate:self cancelButtonTitle:@"Gallery" otherButtonTitles:@"Document", @"Cancel"];
//    [alert show];
//    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select attachment option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Gallery",
                            @"Document",
                            nil];
    popup.tag = 1;
    [popup showInView:self.view];

}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self galleryaction];
                    break;
                case 1:
                    [self dcoumentAction];
                    break;
            }
            break;
        }
        default:
            break;
    }
}

-(void)dcoumentAction{
    appDelegate.documentsendStr=@"False";
    DocumentViewController *document;
    document=[[DocumentViewController alloc] initWithNibName:@"DocumentViewController" bundle:nil];
    [self.navigationController pushViewController:document animated:YES];
}

-(void)galleryaction{
    NSLog(@"galleryaction");
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];

}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        
        picker.delegate = (id)self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
        // [controller release];
    }
    else
    {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        
        picker.delegate = (id)self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage * chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *img = [UIImage imageNamed:@"home.png"];
        //photoImageview.image=img;
        NSData *imageData = UIImageJPEGRepresentation(chosenImage,0.1);
        appDelegate.fileByteStr=[[NSString alloc]init];
        appDelegate.fileextentions=[[NSString alloc]init];
        appDelegate.fileextentions=@"1.png";
        appDelegate.fileByteStr= [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        // profileimgByteStr=[profileimgByteStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        
        if (appDelegate.fileextentions==nil || [appDelegate.fileextentions isEqualToString:@""]) {
            
        }
        else{
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *urlString=[prefs objectForKey:@"SWACC"];
            if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
                commonURL=@"sendMsg";
                [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                [self performSelector:@selector(sendMsgAction1:) withObject:appDelegate.fileextentions afterDelay:1.0 ];
        }
        else{
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            [self performSelector:@selector(sendMsgAction:) withObject:appDelegate.fileextentions afterDelay:1.0 ];
            }
        }
        }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
    //[self performSelector:@selector(pushView) withObject:nil afterDelay:0.2];
}

-(void)forwardAction:(UIButton *)btn{
        ChatUserListViewController *forward=[[ChatUserListViewController alloc] initWithNibName:@"ChatUserListViewController" bundle:nil];
        [self.navigationController pushViewController:forward animated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"YES"]){
        [self deleteAction];
    }
    if([title isEqualToString:@"Yes"]){
        [self clearAction];
    }
    
    if([title isEqualToString:@"Gallery"]){
        [self galleryaction];
    }
    if([title isEqualToString:@"Document"]){
        [self dcoumentAction];
    }
}

-(void)deleteAction:(UIButton *)btn{

    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Delete Selected" message:@"Do you really want to Delete Selected Messages?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert show];

}
-(void)deleteAction{
    clearView.hidden=true;
    isMenuVisible=false;

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *keyStr=[NSString stringWithFormat:@"%@%@",MsgVO.senderID,[prefs objectForKey:@"user_id"]];
    NSArray *sorted_Array = [selectMsgArray sortedArrayUsingDescriptors:
                             @[[NSSortDescriptor sortDescriptorWithKey:nil
                                                             ascending:NO]]];

    for (int count=0; count<[sorted_Array count]; count++) {
        NSIndexPath *indexPath = [sorted_Array objectAtIndex:count];
        NSLog(@"indexPath.row %ld",(long)indexPath.row);
        [msgListArray removeObjectAtIndex:indexPath.row];
    }
    for (int counts=0; counts<[msgListArray count]; counts++) {
        [prefs setObject:[self ToStringss:msgListArray : true] forKey:keyStr];
    }

    if ([msgListArray count]>0) {
    filteredContentList=[[NSMutableArray alloc]init];
    //if( [prefs objectForKey:[prefs objectForKey:@"user_id"]]!=nil){
        if ([MsgVO.senderID rangeOfString:@"U_"].location == NSNotFound) {
            //group
            NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
            filteredContentList=[self ToListss:[prefs objectForKey:keyStr]:false];
        }else{
        filteredContentList=[self ToListss:[prefs objectForKey:[prefs objectForKey:@"user_id"]]:false];
        }
    ChatVO * CV=[msgListArray objectAtIndex:[msgListArray count]-1];
    MsgVO.message=CV.message;
    MsgVO.msg_Date=CV.msg_Date;
    MsgVO.unreadMsg=@"0";
    MsgVO.chatid=CV.chatid;
        MsgVO.attachment=CV.attachment;

    [self updatefunction:filteredContentList:MsgVO];
   // }
    }else{
        [prefs setObject:nil forKey:keyStr];

        filteredContentList=[[NSMutableArray alloc]init];
       // if( [prefs objectForKey:[prefs objectForKey:@"user_id"]]!=nil){
            if ([MsgVO.senderID rangeOfString:@"U_"].location == NSNotFound) {
                //group
                NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
                filteredContentList=[self ToListss:[prefs objectForKey:keyStr]:false];
            }else{
            filteredContentList=[self ToListss:[prefs objectForKey:[prefs objectForKey:@"user_id"]]:false];
            }
            MsgVO.message=@"";
            MsgVO.msg_Date=@"";
            MsgVO.unreadMsg=@"0";
            MsgVO.chatid=@"";
            MsgVO.attachment=@"";
            [self updatefunction:filteredContentList:MsgVO];
        }
   // }
    selectMsgArray=[[NSMutableArray alloc]init];
    [chatTableView reloadData];
    if ([msgListArray count]>0) {
    int lastRowNumber = [chatTableView numberOfRowsInSection:0] - 1;
    NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
    [chatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    [self.navigationItem setRightBarButtonItems:@[] animated:NO];
    [navigationView setFrame:CGRectMake(0, 0, 300, 30)];
    [titleLbl setFrame:CGRectMake(40, 0, 300, 30)];
    
    UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [RightBtn setFrame:CGRectMake(0, 0,30,30)];
    [RightBtn addTarget:self action:@selector(attachMentAction) forControlEvents:UIControlEventTouchUpInside];
    [RightBtn setBackgroundImage:[UIImage imageNamed:@"attach_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithCustomView:RightBtn];
    //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    self.navigationItem.rightBarButtonItem = btn1;
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Messages Deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];

}

-(void)overlayDisplay{
    clearView.hidden=false;
    isMenuVisible=false;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [clearView removeFromSuperview];
    clearView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.11, screenRect.size.width*0.45,52)];
    clearView.backgroundColor = [UIColor whiteColor];
        menuNameButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 2, screenRect.size.width*0.43, 48)];
        [menuNameButton setTitle:@"Clear messages" forState:UIControlStateNormal];
        menuNameButton.titleLabel.font= [UIFont fontWithName:@"OpenSans-Bold" size:15.0f];
        [menuNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [menuNameButton setBackgroundColor:[UIColor whiteColor]];
        [menuNameButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
        menuNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [clearView addSubview:menuNameButton];
    [self.view addSubview:clearView];
}
- (void)tapOnView:(UITapGestureRecognizer *)sender
{
    clearView.hidden=true;
    isMenuVisible=false;
    tap.cancelsTouchesInView=NO;
}

-(void)clearAction:(UIButton *)btn{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Clear All" message:@"Do you really want to Clear All Messages?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];

}
-(void)clearAction{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *keyStr=[NSString stringWithFormat:@"%@%@",MsgVO.senderID,[prefs objectForKey:@"user_id"]];
    [prefs setObject:nil forKey:keyStr];
    
    filteredContentList=[[NSMutableArray alloc]init];
    //if( [prefs objectForKey:[prefs objectForKey:@"user_id"]]!=nil){
        if ([MsgVO.senderID rangeOfString:@"U_"].location == NSNotFound) {
            //group
            NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
            filteredContentList=[self ToListss:[prefs objectForKey:keyStr]:false];
        }else{
        filteredContentList=[self ToListss:[prefs objectForKey:[prefs objectForKey:@"user_id"]]:false];
        }
        MsgVO.message=@"";
        MsgVO.msg_Date=@"";
        MsgVO.unreadMsg=@"0";
        MsgVO.chatid=@"";
        MsgVO.attachment=@"";
        [self updatefunction:filteredContentList:MsgVO];
   // }
    clearView.hidden=true;
    isMenuVisible=false;
    msgListArray=[[NSMutableArray alloc]init];
    selectMsgArray=[[NSMutableArray alloc]init];
    [chatTableView reloadData];
    [self.navigationItem setRightBarButtonItems:@[] animated:NO];
    [navigationView setFrame:CGRectMake(0, 0, 300, 30)];
    [titleLbl setFrame:CGRectMake(40, 0, 300, 30)];
    
    UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [RightBtn setFrame:CGRectMake(0, 0,30,30)];
    [RightBtn addTarget:self action:@selector(attachMentAction) forControlEvents:UIControlEventTouchUpInside];
    [RightBtn setBackgroundImage:[UIImage imageNamed:@"attach_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithCustomView:RightBtn];
    //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    self.navigationItem.rightBarButtonItem = btn1;

    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Messages Clear" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];

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
