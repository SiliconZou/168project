//
//  OnlineCustomerViewController.m
//  PassNurseExam
//
//  Created by SiliconZou on 2020/4/5.
//  Copyright © 2020 ucmed. All rights reserved.
//

#import "OnlineCustomerViewController.h"

@interface OnlineCustomerViewController ()
@property (nonatomic, strong) NSDictionary *dataDic;
@end

@implementation OnlineCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
    self.cViewNav.hidden = YES;
    [[URCommonApiManager sharedInstance] getCustomerServiceNewWithrequestSuccessBlock:^(id response, NSDictionary *responseDict) {
    
    self.dataDic = responseDict;
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)allBtnAction:(UIButton *)sender {
    NSArray *dataArr = self.dataDic[@"data"];
    if (self.dataDic) {
        
    } else {
        return;
    }
    switch (sender.tag) {
        case 101:
            [self dismissViewControllerAnimated:YES completion:nil];
        break;
        case 102:
            [self openOnlineWithQQ:dataArr[0][@"qq"]];
        break;
        case 103:
            [self openOnlineWithQQ:dataArr[1][@"qq"]];
        break;
        case 104:
            [self openOnlineWithQQ:dataArr[2][@"qq"]];
        break;
        case 105:
            URMakePhoneCall(dataArr[3][@"qq"]);
        break;
        case 106:
            URMakePhoneCall(dataArr[4][@"qq"]);
        break;
        case 107:
            [self dismissViewControllerAnimated:YES completion:^{
                NSString *classUrl = [NSString stringWithFormat:@"http://hukao.dianshiedu.cn/school/#/pages/welcomeclass/welcomeclass?device=ios&id=%@",dataArr[5][@"qq"]?:@""];
                URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:classUrl];
                wkWebViewController.hidesBottomBarWhenPushed = YES ;
                wkWebViewController.isShowNav = YES;
                [[self getCurrentVC].navigationController pushViewController:wkWebViewController animated:YES];
            }];
        break;
    }
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
