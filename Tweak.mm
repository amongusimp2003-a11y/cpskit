#include <substrate.h>
#import <UIKit/UIKit.h>

static UIWindow *modWindow = nil;
static UIView *modMenu = nil;
static BOOL menuVisible = NO;

// Düymə funksiyalarının qabaqcadan elanı
void toggleMenu(UIButton *sender);
void closeMenu(UIButton *sender);
void toggleAimbot(UISwitch *sender);
void toggleESP(UISwitch *sender);
void toggleSkin(UISwitch *sender);

void setupModMenu() {
    if (modWindow) return;

    modWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    modWindow.windowLevel = UIWindowLevelAlert + 999;
    modWindow.backgroundColor = [UIColor clearColor];
    modWindow.hidden = NO;

    UIViewController *vc = [[UIViewController alloc] init];
    modWindow.rootViewController = vc;

    modMenu = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 260, 320)];
    modMenu.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    modMenu.layer.cornerRadius = 12;
    modMenu.layer.borderWidth = 1.5;
    modMenu.layer.borderColor = [UIColor cyanColor].CGColor;
    modMenu.hidden = YES;
    [vc.view addSubview:modMenu];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 240, 30)];
    titleLabel.text = @"CRITICAL OPS MOD MENU";
    titleLabel.textColor = [UIColor cyanColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [modMenu addSubview:titleLabel];

    UISwitch *aimbotSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(180, 60, 0, 0)];
    [aimbotSwitch addTarget:nil action:@selector(toggleAimbot:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *aimbotLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 150, 30)];
    aimbotLabel.text = @"Aimbot";
    aimbotLabel.textColor = [UIColor whiteColor];
    [modMenu addSubview:aimbotLabel];
    [modMenu addSubview:aimbotSwitch];

    UISwitch *espSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(180, 110, 0, 0)];
    [espSwitch addTarget:nil action:@selector(toggleESP:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *espLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 150, 30)];
    espLabel.text = @"ESP Box / Line";
    espLabel.textColor = [UIColor whiteColor];
    [modMenu addSubview:espLabel];
    [modMenu addSubview:espSwitch];

    UISwitch *skinSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(180, 160, 0, 0)];
    [skinSwitch addTarget:nil action:@selector(toggleSkin:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *skinLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 150, 30)];
    skinLabel.text = @"Skin Changer";
    skinLabel.textColor = [UIColor whiteColor];
    [modMenu addSubview:skinLabel];
    [modMenu addSubview:skinSwitch];

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    closeBtn.frame = CGRectMake(70, 260, 120, 35);
    [closeBtn setTitle:@"Bağla" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    closeBtn.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    closeBtn.layer.cornerRadius = 8;
    [closeBtn addTarget:nil action:@selector(closeMenu:) forControlEvents:UIControlEventTouchUpInside];
    [modMenu addSubview:closeBtn];

    UIButton *floatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    floatBtn.frame = CGRectMake(20, 50, 65, 35);
    [floatBtn setTitle:@"MOD" forState:UIControlStateNormal];
    [floatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    floatBtn.backgroundColor = [UIColor cyanColor];
    floatBtn.layer.cornerRadius = 8;
    [floatBtn addTarget:nil action:@selector(toggleMenu:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:floatBtn];
}

// Handle actions via standard Obj-C methods or target selectors
void toggleMenu(UIButton *sender) {
    menuVisible = !menuVisible;
    modMenu.hidden = !menuVisible;
}

void closeMenu(UIButton *sender) {
    menuVisible = NO;
    modMenu.hidden = YES;
}

void toggleAimbot(UISwitch *sender) {
    if (sender.on) {
        NSLog(@">> C-Ops: Aimbot Activated");
    } else {
        NSLog(@">> C-Ops: Aimbot Deactivated");
    }
}

void toggleESP(UISwitch *sender) {
    if (sender.on) {
        NSLog(@">> C-Ops: ESP Activated");
    } else {
        NSLog(@">> C-Ops: ESP Deactivated");
    }
}

void toggleSkin(UISwitch *sender) {
    if (sender.on) {
        NSLog(@">> C-Ops: Skin Changer Activated");
    }
}

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        setupModMenu();
    });
}
