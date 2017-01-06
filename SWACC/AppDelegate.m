//
//  AppDelegate.m
//  SWACC
//
//  Created by Infinitum on 09/11/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "HomeViewController.h"
#import "TopNewsViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "ChatUserListViewController.h"
#import "MessageVO.h"
#import "ChatVO.h"
#import <UserNotifications/UserNotifications.h>
#import "MessageChatViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize deviceToken,StrMain,msgListArray,chatStrMain,userlistBool,msgchatBool,getuserList,msgTotalCount,index,pushStr,MSGVO,appBackground,fileByteStr,fileextentions;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    StrMain=[[NSString alloc]init];
    chatStrMain=[[NSString alloc]init];
    filteredContentList=[[NSMutableArray alloc]init];
    appBackground=false;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"No internet connection available" forKey:@"NOINTERNET"];
    [prefs setObject:@"http://192.168.0.37/swacc/" forKey:@"SWACC"];//Local server
    [prefs setObject:@"http://192.168.0.37/swacc/" forKey:@"LinkHRlift"];//Local server
//       [prefs setObject:@"https://23.253.109.178/swacc/" forKey:@"SWACC"];//23 server
//        [prefs setObject:@"https://23.253.109.178/swacc/" forKey:@"LinkHRlift"];//23 server
//        [prefs setObject:@"https://stg.benefitbridge.com/swacc/" forKey:@"SWACC"];//ashok server
//        [prefs setObject:@"https://stg.benefitbridge.com/swacc/" forKey:@"LinkHRlift"];//ashok server

    [prefs synchronize];

    if (launchOptions != nil) {
        // Launched from push notification
            NSDictionary *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
            MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            index=1;
            pushStr=[[NSString alloc]init];
            pushStr=@"yes";
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
            navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
            [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
            [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
        }
    
    LoginViewController *mainvc=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.index=0;
    self.navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
    //navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.window.rootViewController=_navController;
    [self.window makeKeyAndVisible];
    }
    return YES;
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    NSString *deviceTokenString=[[[[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.deviceToken=deviceTokenString;
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"userInfo %@", userInfo);
    
    //[UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo valueForKey:@"aps"] valueForKey:@"badge"] integerValue];

    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (getuserList) {
        getuserList=true;
        NSDictionary *userArray;
        userArray = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        msgTotalCount=0;
        MessageVO *msgvo=[[MessageVO alloc]init];
        MSGVO=[[MessageVO alloc]init];
        msgvo.senderID=[[NSString alloc]init];
        msgvo.username=[[NSString alloc]init];
        msgvo.profile=[[NSString alloc]init];
        msgvo.chatid=[[NSString alloc]init];
        msgvo.message=[[NSString alloc]init];
        msgvo.msg_Date=[[NSString alloc]init];
        msgvo.unreadMsg=[[NSString alloc]init];
        msgvo.attachment=[[NSString alloc]init];

        if ([userArray objectForKey:@"user_id"] != [NSNull null])
            msgvo.senderID=[userArray objectForKey:@"user_id"];

        NSLog(@"msgvo.senderID %@",msgvo.senderID);
        if ([msgvo.senderID rangeOfString:@"U_"].location == NSNotFound) {
            //group
        NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
            array=[self ToListss:[prefs objectForKey:keyStr] : false];
        }else{
       //normal msg
            array=[self ToListss:[prefs objectForKey:[prefs objectForKey:@"user_id"]] : false];
            NSLog(@"true");
        }
        if ([userArray objectForKey:@"title"] != [NSNull null])
            msgvo.username=[userArray objectForKey:@"title"];

        if ([userArray objectForKey:@"chat_id"] != [NSNull null])
            msgvo.chatid=[userArray objectForKey:@"chat_id"];

        if ([userArray objectForKey:@"body"] != [NSNull null])
            msgvo.message=[userArray objectForKey:@"body"];

//        if ([userArray objectForKey:@"date"] != [NSNull null])
//            msgvo.msg_Date=[userArray objectForKey:@"date"];

        if ([userArray objectForKey:@"total_count"] != [NSNull null])
            msgTotalCount=[[userArray objectForKey:@"total_count"] intValue];
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = msgTotalCount;

            NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
            [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
            NSString *dateString = [fbdateFormat stringFromDate:today];
            NSLog(@"dateString%@",dateString);
            msgvo.msg_Date=dateString;
        
        if ([userArray objectForKey:@"count"] != [NSNull null])
            msgvo.unreadMsg=[userArray objectForKey:@"count"];

        if ([userArray objectForKey:@"profile_picture"] != [NSNull null])
            msgvo.profile=[userArray objectForKey:@"profile_picture"];

        if ([userArray objectForKey:@"attachment"] != [NSNull null])
            msgvo.attachment=[userArray objectForKey:@"attachment"];

            MSGVO=msgvo;
       // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[msgvo.unreadMsg intValue]]; // this one

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
     
    [self updatefunction:array:msgvo];

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
        chatvo.attachment=[[NSString alloc]init];

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
        
        
//        [msgListArray addObject:chatvo];
//        [prefs setObject:[self ToStringss:msgListArray : true] forKey:keyStr];

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

            if (userlistBool==true && msgchatBool==false) {
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:[prefs objectForKey:@"user_id"]
                 object:nil]; //You can set object as nil or send the object you want to get from the ViewController
            }
            else if(userlistBool==false && msgchatBool==true){
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"msgChat"
                     object:nil]; //You can set object as nil or send the object you want to get from the ViewController
            }
        
        if (appBackground==true &&msgchatBool==false) {

            MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            index=1;
            pushStr=[[NSString alloc]init];
            pushStr=@"yes";
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
            navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
            [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
            [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
        }
    }else{
        getuserList=false;
    }
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (getuserList && [prefs objectForKey:[prefs objectForKey:@"user_id"]]!=nil) {
        array=[self ToListss:[prefs objectForKey:[prefs objectForKey:@"user_id"]] : false];
        getuserList=true;
        msgTotalCount=0;
        NSDictionary *userArray;
        userArray = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        
        MessageVO *msgvo=[[MessageVO alloc]init];
        msgvo.senderID=[[NSString alloc]init];
        msgvo.username=[[NSString alloc]init];
        msgvo.profile=[[NSString alloc]init];
        msgvo.chatid=[[NSString alloc]init];
        msgvo.message=[[NSString alloc]init];
        msgvo.msg_Date=[[NSString alloc]init];
        msgvo.unreadMsg=[[NSString alloc]init];
        
        if ([userArray objectForKey:@"user_id"] != [NSNull null])
            msgvo.senderID=[userArray objectForKey:@"user_id"];
        
        NSLog(@"msgvo.senderID %@",msgvo.senderID);
        
        if ([userArray objectForKey:@"title"] != [NSNull null])
            msgvo.username=[userArray objectForKey:@"title"];
        
        if ([userArray objectForKey:@"chat_id"] != [NSNull null])
            msgvo.chatid=[userArray objectForKey:@"chat_id"];
        
        if ([userArray objectForKey:@"body"] != [NSNull null])
            msgvo.message=[userArray objectForKey:@"body"];
        
//        if ([userArray objectForKey:@"date"] != [NSNull null])
//            msgvo.msg_Date=[userArray objectForKey:@"date"];
        
                if ([userArray objectForKey:@"total_count"] != [NSNull null])
                    msgTotalCount=[[userArray objectForKey:@"total_count"] intValue];

        [UIApplication sharedApplication].applicationIconBadgeNumber = msgTotalCount;

        NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
        [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
        NSString *dateString = [fbdateFormat stringFromDate:today];
        NSLog(@"dateString%@",dateString);
        msgvo.msg_Date=dateString;
        
        if ([userArray objectForKey:@"count"] != [NSNull null])
            msgvo.unreadMsg=[userArray objectForKey:@"count"];
        
        if ([userArray objectForKey:@"profile_picture"] != [NSNull null])
            msgvo.profile=[userArray objectForKey:@"profile_picture"];
        
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

        [self updatefunction:array:msgvo];
        
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
        chatvo.attachment=[[NSString alloc]init];

        chatvo.TrueStr=@"False";
        chatvo.chatid=msgvo.chatid;
        chatvo.message=msgvo.message;
        //chatvo.msg_Date=msgvo.msg_Date;
        chatvo.msg_Date=dateString;

        NSLog(@"dateString%@",dateString);

        chatvo.status=@"0";
        [msgListArray addObject:chatvo];
        [prefs setObject:[self ToStringss:msgListArray : true] forKey:keyStr];
        
        if (userlistBool==true && msgchatBool==false) {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:[prefs objectForKey:@"user_id"]
             object:nil]; //You can set object as nil or send the object you want to get from the ViewController
        }
        else if(userlistBool==false && msgchatBool==true){
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"msgChat"
             object:nil]; //You can set object as nil or send the object you want to get from the ViewController
        }
    }
}

-(void)updatefunction:(NSMutableArray *)userListArray : (MessageVO *)msgvo{
    //msgTotalCount=0;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    for (int count=0; count<[userListArray  count]; count++){
        MessageVO *msgvos=[userListArray objectAtIndex:count];
        NSLog(@"msgvos sender print %@",msgvos.senderID);
        if ([msgvo.senderID isEqualToString:msgvos.senderID]) {
            [userListArray removeObjectAtIndex:count];
        }
    }
    
    [userListArray addObject:msgvo];
    
    if ([msgvo.senderID rangeOfString:@"U_"].location == NSNotFound) {
        //group
        NSString* keyStr=[NSString stringWithFormat:@"%@%@",[prefs objectForKey:@"user_id"],@"Group"];
        [prefs setObject:[self ToStringss:userListArray :false] forKey:keyStr];
    }else{
    [prefs setObject:[self ToStringss:userListArray :false] forKey:[prefs objectForKey:@"user_id"]];
    }
//    for (int count=0; count<[userListArray  count]; count++){
//        MessageVO *msgvos1=[userListArray objectAtIndex:count];
//        msgTotalCount=msgTotalCount+[msgvos1.unreadMsg intValue];
//    }
//    NSLog(@"msgTotalCount %d ",msgTotalCount);
//    [UIApplication sharedApplication].applicationIconBadgeNumber = msgTotalCount;
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSLog( @"Handle push from foreground" );
    // custom code to handle push while app is in the foreground
    NSLog(@"%@", notification.request.content.userInfo);
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
    if (![Strs isEqualToString:@""]) {
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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    appBackground=true;
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    appBackground=false;
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
