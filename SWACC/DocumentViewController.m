//
//  DocumentViewController.m
//  SWACC
//
//  Created by Infinitum on 02/01/17.
//  Copyright © 2017 com.keenan. All rights reserved.
//

#import "DocumentViewController.h"
#import "UIColor+Expanded.h"
@interface DocumentViewController ()

@end

@implementation DocumentViewController
@synthesize appDelegate,documentArray,tableViewMain,msgLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#851c2b"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"Documents";
    [titleLabel setTextColor:[UIColor whiteColor]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,30,30)];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[UIColor colorWithHexString:@"#03687f"]];
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    tableViewMain=[[UITableView alloc]init];
    tableViewMain.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height);
    tableViewMain.dataSource = self;
    tableViewMain.delegate = self;
    [tableViewMain setBackgroundColor:[UIColor clearColor]];
    self.tableViewMain.separatorColor = [UIColor clearColor];
    tableViewMain.separatorInset = UIEdgeInsetsZero;
    tableViewMain.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:tableViewMain];

    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://mobiwebsoft.com/DELLE/pdf_doc/pdf_demo.pdf"]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"myPDF11.pdf"];
    [pdfData writeToFile:filePath atomically:YES];
    
    NSData *pdfData1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://mobiwebsoft.com/DELLE/pdf_doc/pdf_demo.pdf"]];
    
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
    NSString *filePath1 = [documentsDirectory1 stringByAppendingPathComponent:@"myPDF12.txt"];
    [pdfData1 writeToFile:filePath1 atomically:YES];
    
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory2 = [paths2 objectAtIndex:0];
    
    NSFileManager *manager2 = [NSFileManager defaultManager];
    NSArray *fileList2 = [manager2 contentsOfDirectoryAtPath:documentsDirectory2 error:nil];
    documentArray=[[NSMutableArray alloc]init];

    for (int co=0; co<[fileList2 count]; co++) {
        if ([[fileList2 objectAtIndex:co] rangeOfString:@".png"].location == NSNotFound) {
            [documentArray addObject:[fileList2 objectAtIndex:co]];
        }
    }
    if ([documentArray count]==0) {
        [msgLbl removeFromSuperview];
        msgLbl = [[UILabel alloc] init];
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15, screenRect.size.width*0.90, 60)];
        msgLbl.textAlignment = NSTextAlignmentCenter;
        msgLbl.text=@"No records found";
        [msgLbl setTextColor: [UIColor blackColor]];
        UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
        msgLbl.font=font1s;
        [self.view addSubview:msgLbl];
        
    }else{
        [msgLbl removeFromSuperview];
    [tableViewMain reloadData];
    }
}

-(IBAction)cancelAction{
    appDelegate.documentsendStr=@"False";
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma marl - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [documentArray count];
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
    NSString *url=[documentArray objectAtIndex:indexPath.row];
    
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
    NSArray* commonFields = [[documentArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"."];
    
    appDelegate.fileByteStr=[[NSString alloc]init];
    appDelegate.fileextentions=[[NSString alloc]init];
    appDelegate.fileextentions=[NSString stringWithFormat:@"1.%@",[commonFields objectAtIndex:1]];
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
    NSString *filepath = [documentsDirectory1 stringByAppendingPathComponent:[documentArray objectAtIndex:indexPath.row]];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:filepath];
    appDelegate.fileByteStr= [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    appDelegate.documentsendStr=@"True";
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
