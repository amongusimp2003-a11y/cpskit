#import <UIKit/UIKit.h>

// Menyunu və pəncərələri idarə etmək üçün əsas sinif
@interface CopsModMenuManager : NSObject
+ (instancetype)sharedInstance;
- (void)showKeySystem;
- (void)showMainMenuView;
@end

@implementation CopsModMenuManager

+ (instancetype)sharedInstance {
    static CopsModMenuManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)showKeySystem {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Key Verifikasiyası"
                                                                   message:@"Zəhmət olmasa daxil olmaq üçün Key daxil edin:"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Key-i daxil edin";
        textField.secureTextEntry = YES;
    }];
    
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Təsdiq Et" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        if ([textField.text isEqualToString:@"rts___721435"]) {
            [self showMainMenuView];
        } else {
            exit(0); // Yanlış key olduqda oyundan çıxır
        }
    }];
    
    [alertaddAction:submitAction];
    [keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)showMainMenuView {
    // Əsas Menyu Pəncərəsi
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootVC = keyWindow.rootViewController;
    
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 300, 400)];
    menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaCoordinate:0.8];
    menuView.layer.cornerRadius = 10;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 280, 30)];
    titleLabel.text = @"Critical Ops Mod Menu";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [menuView addSubview:titleLabel];
    
    [rootVC.view addSubview:menuView];
}

@end

// Oyun işə düşəndə menyunu və xəbərdarlıq yazısını işə salırıq
%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Anti-Cheat xəbərdarlıq yazısı (Yuxarı hissədə)
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, keyWindow.bounds.size.width, 20)];
        warningLabel.text = @"Rage cheating is not recommended because of getting banned instead use legit cheats.";
        warningLabel.textColor = [UIColor redColor];
        warningLabel.font = [UIFont boldSystemFontOfSize:10];
        warningLabel.textAlignment = NSTextAlignmentCenter;
        [keyWindow addSubview:warningLabel];
        
        // Key sistemini çağırırıq
        [[CopsModMenuManager sharedInstance] showKeySystem];
    });
}
