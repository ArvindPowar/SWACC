//
//  MemberpolicyViewController.m
//  SWACC
//
//  Created by Infinitum on 07/12/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import "MemberpolicyViewController.h"
#import "UIColor+Expanded.h"
#import "MainViewController.h"
#import "EPLViewController.h"
#import "ReaderViewController.h"
#import "PdfviewerViewController.h"
@interface MemberpolicyViewController ()

@end

@implementation MemberpolicyViewController
@synthesize appDelegate,menuNameArray,tableViewMain,tempArray;
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
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    if(appDelegate.index==10){
    menuNameArray=[[NSMutableArray alloc]initWithObjects:@"Allan Hancock Joint CCD",@"Contra Costa CCD",@"Ohlone CCD",@"Gavilan Joint CCD",@"Hartnell CCD",@"Monterey Peninsula CCD",@"San Jose/Evergreen CCD",@"San Luis Obispo County CCD",@"West Valley-Mission CCD",@"Cabrillo CCD",@"Cerritos CCD",@"Chabot-Las Positas CCD",@"Citrus CCD",@"Coast CCD",@"Compton CCD",@"Desert CCD",@"El Camino CCD",@"Lake Tahoe CCD",@"Long Beach CCD",@"Mount San Jacinto CCD",@"Butte-Glen CCD",@"College of Marin",@"Feather River CCD",@"Lassen CCD",@"Mendocino-Lake CCD",@"Napa Valley CCD",@"Redwoods CCD",@"Siskiyou Joint CCD",@"Solano CCD",@"Yuba CCD",@"Palomar CCD",@"Pasadena Area CCD",@"San Bernardino CCD",@"San Diego CCD",@"San Joaquin Delta CCD",@"Santa Clarita CCD",@"Santa Monica CCD",@"Shasta-Tehama-Trinity Joint CCD",@"Santa Rosa Junior College",@"South Orange County CCD",@"Southwestern CCD",@"Ventura County CCD",@"Victor Valley CCD",@"West Hills CCD",@"West Kern CCD",nil];
    
    tempArray=[[NSMutableArray alloc]initWithObjects:@"http://www.hancockcollege.edu/",@"http://www.4cd.edu/default.aspx",@"http://www.ohlone.edu/",@" http://www.gavilan.edu/",@"http://www.hartnell.edu/",@"http://www.mpc.edu/",@"http://www.sjeccd.edu/",@"https://www.cuesta.edu/",@"http://wvm.edu/",@"http://www.cabrillo.edu/",@"http://www.cerritos.edu/",@"http://www.clpccd.cc.ca.us/",@"http://citruscollege.edu/Pages/Default.aspx",@"http://www.cccd.edu/Pages/home.aspx",@"http://district.compton.edu/",@"http://www.collegeofthedesert.edu/Pages/default.aspx",@"http://www.elcamino.edu/",@"http://ltcc.edu/",@"http://www.lbcc.edu/",@"http://www.msjc.edu/Pages/default.aspx",@"http://www.butte.edu/",@"http://www1.marin.edu/",@"http://www.frc.edu/",@"http://www.lassencollege.edu/",@"http://www.mendocino.edu/",@"http://www.napavalley.edu/Pages/default.aspx",@"http://www.redwoods.edu/",@"http://www.siskiyous.edu/",@"http://www.solano.edu/",@"http://www.yccd.edu/",@"http://www2.palomar.edu/",@"http://pasadena.edu/",@"http://www.sbccd.org/",@"http://www.sdccd.edu/",@"https://www.deltacollege.edu/",@"http://www.canyons.edu/Pages/Home.aspx",@"http://www.smc.edu/Pages/default.aspx",@"http://www.shastacollege.edu/Pages/default.aspx",@"https://www.santarosa.edu/",@"https://www.socccd.edu/",@"http://www.swccd.edu/",@"http://www.vcccd.edu/",@"http://vvc.edu/",@"http://www.westhillscollege.com/coalinga/",@"https://www.kccd.edu/",nil];

    tableViewMain=[[UITableView alloc]init];
    tableViewMain.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height);
    tableViewMain.dataSource = self;
    tableViewMain.delegate = self;
    [tableViewMain setBackgroundColor:[UIColor clearColor]];
    self.tableViewMain.separatorColor = [UIColor clearColor];
    tableViewMain.separatorInset = UIEdgeInsetsZero;
    tableViewMain.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:tableViewMain];
    }else if(appDelegate.index==13){
        menuNameArray=[[NSMutableArray alloc]initWithObjects:@"Title IX Announcement",@"Title IX NewGuidance",@"Title IX and AB1266 Transgender Students",@"Sept  Insight 2015 KSC Title IX",@"So You Think You are Ready For Title IX",nil];
        tableViewMain=[[UITableView alloc]init];
        tableViewMain.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height);
        tableViewMain.dataSource = self;
        tableViewMain.delegate = self;
        [tableViewMain setBackgroundColor:[UIColor clearColor]];
        self.tableViewMain.separatorColor = [UIColor clearColor];
        tableViewMain.separatorInset = UIEdgeInsetsZero;
        tableViewMain.layoutMargins = UIEdgeInsetsZero;
        [self.view addSubview:tableViewMain];

        }else{
        NSString *str=@"https://keenan.webex.com/ec3100/eventcenter/recording/recordAction.do?theAction=poprecord&AT=pb&internalRecordTicket=4832534b0000000262aba44c8ae80b7c33b107416d84e3e5a5c28dcb17f56eb6ff2cfef166412115&renewticket=0&isurlact=true&recordID=106958512&apiname=lsr.php&format=short&needFilter=false&&SP=EC&rID=106958512&RCID=5a1b91340c8d4546bc6cc3d0f2dbc29d&siteurl=keenan&actappname=ec3100&actname=%2Feventcenter%2Fframe%2Fg.do&rnd=1104488236&entappname=url3100&entactname=%2FnbrRecordingURL.do%3E&AT=pb&internalRecordTicket=4832534b0000000262aba44c8ae80b7c33b107416d84e3e5a5c28dcb17f56eb6ff2cfef166412115&renewticket=0&isurlact=true&recordID=106958512&apiname=lsr.php&format=short&needFilter=false&&SP=EC&rID=106958512&RCID=5a1b91340c8d4546bc6cc3d0f2dbc29d&siteurl=keenan&actappname=ec3100&actname=%2Feventcenter%2Fframe%2Fg.do&rnd=1104488236&entappname=url3100&entactname=%2FnbrRecordingURL.do";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

#pragma marl - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuNameArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.07;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *NameLbl,*lineLbl;
    NSString *url=[menuNameArray objectAtIndex:indexPath.row];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor=[UIColor whiteColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
        NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.005, screenRect.size.width*0.90, screenRect.size.height*0.05)];
        NameLbl.tag=3;
        NameLbl.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:12];
        NameLbl.textColor=[UIColor blackColor];
        NameLbl.text=url;
        [cell.contentView addSubview:NameLbl];
    
    lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.065, screenRect.size.width*0.90,1)];
    [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
    [cell.contentView addSubview:lineLbl];
    
    tableView.backgroundColor=[UIColor clearColor];
    [cell setBackgroundColor:[UIColor clearColor]];
    //Your main thread code goes in here
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tempArray==nil) {
        appDelegate.urlStr=[[NSString alloc]init];
        appDelegate.urlStr=[menuNameArray objectAtIndex:indexPath.row];
        if ([appDelegate.urlStr isEqualToString:@"Title IX Announcement"]) {
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"Title_IX_Announcement_4_9_15" ofType:@"pdf"];
//            [self handleSingleTap:path];
            PdfviewerViewController * pdfviewer;
            pdfviewer= [[PdfviewerViewController alloc] initWithNibName:@"PdfviewerViewController" bundle:nil];
            appDelegate.urlStr=[[NSString alloc]init];
            appDelegate.urlStr=@"https://23.253.109.178/swacc/docs/Title_IX_Announcement_4_9_15.pdf";
            [self.navigationController pushViewController:pdfviewer animated:YES];

        }else if ([appDelegate.urlStr isEqualToString:@"Title IX NewGuidance"]) {
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"BRF_20150622_TitleIXNewGuidance_KA" ofType:@"pdf"];
//            [self handleSingleTap:path];
            PdfviewerViewController * pdfviewer;
            pdfviewer= [[PdfviewerViewController alloc] initWithNibName:@"PdfviewerViewController" bundle:nil];
            appDelegate.urlStr=[[NSString alloc]init];
            appDelegate.urlStr=@"https://23.253.109.178/swacc/docs/BRF_20150622_TitleIXNewGuidance_KA.pdf";
            [self.navigationController pushViewController:pdfviewer animated:YES];

        }else if ([appDelegate.urlStr isEqualToString:@"Title IX and AB1266 Transgender Students"]){
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"BRF_20160524_TitleIXandAB1266TransgenderStudents_KA" ofType:@"pdf"];
//            [self handleSingleTap:path];
            PdfviewerViewController * pdfviewer;
            pdfviewer= [[PdfviewerViewController alloc] initWithNibName:@"PdfviewerViewController" bundle:nil];
            appDelegate.urlStr=[[NSString alloc]init];
            appDelegate.urlStr=@"https://23.253.109.178/swacc/docs/BRF_20160524_TitleIXandAB1266TransgenderStudents_KA.pdf";
            [self.navigationController pushViewController:pdfviewer animated:YES];

        }else if ([appDelegate.urlStr isEqualToString:@"Sept  Insight 2015 KSC Title IX"]){
            NSString *path =@"https://docs.google.com/gview?embedded=true&url=https://23.253.109.178/swacc/docs/Sept%20Insight%202015%20KSC%20Title%20IX.docx";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
        }else{
            NSString *path =@"https://docs.google.com/gview?embedded=true&url=https://23.253.109.178/swacc/docs/031016%20So%20You%20Think%20You%20are%20Ready%20For%20Title%20IX.docx";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
        }
    }
    else{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[tempArray objectAtIndex:indexPath.row]]];
    }
    

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
