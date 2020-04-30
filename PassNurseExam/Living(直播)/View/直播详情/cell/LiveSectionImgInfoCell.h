//
//  LiveSectionImgInfoCell.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionImgInfoCell : UITableViewCell<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *detailImg;

//@property (nonatomic,strong) WKWebView *detailsWebView;
//@property (nonatomic,strong) NSArray *imageArr;

@end

NS_ASSUME_NONNULL_END
