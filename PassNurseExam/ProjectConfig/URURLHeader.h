//
//  URURLHeader.h
//  PassNurseExam
//
//  Created by qc on 2018/11/8.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#ifndef URURLHeader_h
#define URURLHeader_h

typedef NS_ENUM(NSInteger, RequestReturnCode) {
    RequestReturnSuccess = 200, //成功
    RequestReturnTokenOverdue = 401 , // token失效或未登录
};


#define  HTTPURL  @"http://edu.168wangxiao.cn"//@"http://swoole.mrcc.xyz"//@"http://hukao.dianshiedu.cn"//

#pragma mark -- 首页

// App版本升级
#define VersionUpdate  @"/api/version.api"

// 获取App配置
#define AppConfig @"/api/appConfig.api"

// 首页数据
#define HomePageData @"/api/home.api"

// 精品课堂
#define HomeExcellentClassroom @"/api/getExcellentClassroom.api"

// 新闻资讯搜索
#define HomeArticleSearch @"/api/articleSearch.api"

// 新闻资讯分类
#define HomeArticleClass @"/api/articleClass.api"

// 新闻资讯列表
#define HomeArticleList @"/api/articleList.api"

// 每日真题---列表
#define DailyQuestionlList @"/api/getDailyTopics.api"

// 新闻资讯搜索
#define HomeArticleSearch @"/api/articleSearch.api"


#pragma mark -- 题库
// 考试科目
#define ExamSubject @"/api/getKaoShiKeMu.api"

// 题库分类
#define QuestionClassification @"/api/getTopicTaxonomy.api"

// 试题类目
#define QuestionCategory @"/api/getSubjectType.api"

// 单元练习列表
#define UnitExerciseList  @"/api/getUnitList.api"

// 单元练习---抽题
#define UnitExercise  @"/api/getUnitTopics.api"

// 题目报错
#define TitleError  @"/api/reportErrors.api"

// 错题排行列表
#define WrongRankingList @"/api/wrongRanking.api"

// 收藏题
#define UnitExercisesCollect @"/api/unitExercisesCollect.api"

// 做题提交
#define CommitQuestion @"/api/subPastQuestions.api"

// 免费题库---图片--视频题
#define MediaQuestion @"/api/getMediaQuestion.api"

// 免费题库---模拟题
#define SimulationQuestion @"/api/getSimulationQuestion.api"

// 免费题库---真题
#define OriginalQuestion @"/api/getOriginalQuestion.api"

// 免费题库---考前密题--卷子
#define SecretVolume @"/api/getSecretVolume.api"

// 免费题库---考前密题--题
#define SecretQuestion @"/api/getSecretQuestion.api"

//收藏资讯
#define CollectArticle @"/api/toArticleCollect.api"

//收藏资讯列表
#define CollectList @"/api/myArticleCollect.api"

//是否收藏
#define IsCollect @"/api/isArticleCollect.api"

#pragma mark -- 个人中心
//用户登录
#define UserLogIn @"/api/login.api"

//注册获取验证码
#define RegistrationVerificationCode  @"/api/regCode.api"

//用户注册
#define UserRegister @"/api/reg.api"

// 用户找回密码获取验证码
#define UserFindCode @"/api/findCode.api"

// 用户找回密码
#define UserFindPassword @"/api/findPassword.api"

// 用户信息
#define UserInformation @"/api/myInfo.api"


//个人中心获取客服信息
#define CustomerServiceNew @"/api/getCustomerServiceNew.api"

// 用户微信登录
#define UserWXLogin @"/api/wxLogin.api"

// 用户绑定微信
#define UserBindWX @"/api/bindWx.api"

// 绑定微信获取验证码
#define UserBindWXFindCode @"/api/bindWxFindCode.api"

//  购买会员
#define BuyMemeber @"/api/buyMember.api"

// 上传图片
#define UserUploadImage @"/api/uploadImg.api"

// 意见反馈
#define UserFeedBack   @"/api/feedback.api"

// 修改用户信息
#define UserChangeInformation @"/api/changeMyInfo.api"

// 用户签到
#define UserSignIn @"/api/signIn.api"

// 用户积分
#define UserIntegral @"/api/myPoints.api"

// 用户考题收藏
#define UserExaminationQuestionsCollection @"/api/getMyCollection.api"

// 我的课程
#define MineCourse @"/api/getMyCourse.api"

// 我的消息
#define MineMessages  @"/api/getMyMessages.api"

// 消息标记已读
#define MineMessageMarkRead @"/api/messagesRead.api"

// 获取卡片信息
#define UserGetCardInformation  @"/api/getActivationInfo.api"

// 卡片激活
#define UserActivateCard @"/api/activationCard.api"

//用户考试统计
#define UserTestStatistics @"/api/getTestStatList.api"

//考试统计详情
#define UserTestStatisticsDetail @"/api/getTestStatInfo.api"

// 用户下载
#define UsergetAllCurriculum @"/api/getAllCurriculum.api"

// 我的直播课程
#define UserBuyLiveCourse  @"/api/getMyLiveList.api"



#pragma mark -- 课程

// 课程分类&顶部轮播图
#define CourseClassification @"/api/getCurricularTaxonomy.api"

// 精品课程---课程列表
#define CourseList @"/api/getCourse.api"

// 精品课程---阶段列表
#define CourseStageList @"/api/getStage.api"

// 精品课程---章节和课件
#define CourseChapterCurriculums @"/api/getChapterCurriculums.api"

// 精品课程---套餐---阶段
#define CourseSetmealStage @"/api/getSetmealStage.api"

// 精品课程----购买
#define CoursePayCourseware @"/api/payCourseware.api"

// 精品课程---老师信息
#define CourseTeacherInfo @"/api/showTeacherInfo.api"

// 精品课程---给老师点赞
#define CourseSendPraise @"/api/SendPraise.api"

// 精品课程---送花给老师
#define CourseSendFlowers @"/api/SendFlowers.api"

// 精品课程---课程浏览统计
#define CourseBrowseStatistics @"/api/clickStatistics.api"

// 精品课程---考勤签到
#define ClickStatistics @"/api/clickStatistics.api"

#pragma mark -- 直播

// 直播---首页 轮播图和二级分类
#define LiveHomeClassification @"/api/getLiveHome.api"

// 直播---首页 课程
#define LiveHomeCourseList @"/api/getLiveHomeList.api"

//直播----首页 课程(新加接口)
#define LiveHomeCourseListNew @"/api/getLiveHomeListNew.api"

//直播课程---直播间---老师发起签到
#define LiveLaunchAttendance @"/api/liveLaunchAttendance.api"

//直播课程---直播间---学生主动进行签到
#define StudentLaunchAttendance @"/api/studentLaunchAttendance.api"

//直播课程---直播间---老师下课/延时
#define ChangeLiveTime @"/api/changeLiveTime.api"

// 直播课堂--首页-课程-更多
#define LiveHomeMoreCourseList  @"/api/getLiveHomeMore.api"

// 直播课堂--详情
#define LiveSectionDetail @"/api/getLiveSection.api"

// 直播课堂---详情(新加接口)
#define LiveSectionDetailNew @"/api/getLiveSectionNew.api"


// 直播课程---花
#define LiveFlower  @"/api/liveFlower.api"

//直播课程---直播间---出入直播间
#define LiveInOut @"/api/LiveInOut.api"

// 直播课程---直播间---群聊发送消息
#define LivePushGroupChat  @"/api/pushGroupChat.api"

//直播课程---直播间---送花
#define LivePushFlower @"/api/pushFlower.api"

//直播课程---直播间---禁言/解除禁言/踢出
#define LiveForbiddenWords @"/api/forbiddenWords.api"

//直播课程---直播间---提交答题答案
#define LiveSubmitAnswer  @"/api/liveTiJiaoDaTi.api"

//直播课堂---直播间---管理员切换线路
#define LiveChangeLiveUrl  @"/api/changeLiveUrl.api"

//直播课程---直播间---老师获取所有题
#define LiveGetAllExaminationQuestions  @"/api/liveGetTi.api"

//直播课程---直播间---推送答题
#define LivePushExaminationQuestions  @"/api/liveDaTi.api"

//直播课程---直播间---答题统计
#define LiveAnswerStatistics  @"/api/liveDaTiCensus.api"


#endif /* URURLHeader_h */
