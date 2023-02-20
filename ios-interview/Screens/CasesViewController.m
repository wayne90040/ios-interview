//
//  CasesViewController.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/17.
//

#import "CasesViewController.h"
#import "ViewController.h"

@interface CasesViewController ()

- (void) setup;

- (void) onCaseTapped:(UIButton*)sender;

- (Case) transferWithInteger:(NSInteger)tag;

@end


@implementation CasesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor systemBackgroundColor]];
    [self setup];
}

- (void) setup {
    
    UIStackView *stack = [[UIStackView alloc] initWithFrame:CGRectZero];
    [stack setAxis:UILayoutConstraintAxisVertical];
    [stack setDistribution:UIStackViewDistributionFillEqually];
    [stack setAlignment:UIStackViewAlignmentFill];
    [stack setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIButton *case1Button = [[UIButton alloc] initWithFrame:CGRectZero];
    [case1Button addTarget:self action:@selector(onCaseTapped:) forControlEvents:UIControlEventTouchUpInside];
    [case1Button setTitle:@"Case 1" forState:UIControlStateNormal];
    [case1Button setBackgroundColor:[UIColor redColor]];
    [case1Button setTag:0];
    [stack addArrangedSubview:case1Button];
    
    UIButton *case2Button = [[UIButton alloc] initWithFrame:CGRectZero];
    [case2Button addTarget:self action:@selector(onCaseTapped:) forControlEvents:UIControlEventTouchUpInside];
    [case2Button setTitle:@"Case 2" forState:UIControlStateNormal];
    [case2Button setBackgroundColor:[UIColor blueColor]];
    [case2Button setTag:1];
    [stack addArrangedSubview:case2Button];
    
    UIButton *case3Button = [[UIButton alloc] initWithFrame:CGRectZero];
    [case3Button addTarget:self action:@selector(onCaseTapped:) forControlEvents:UIControlEventTouchUpInside];
    [case3Button setTitle:@"Case 3" forState:UIControlStateNormal];
    [case3Button setBackgroundColor:[UIColor greenColor]];
    [case3Button setTag:2];
    [stack addArrangedSubview:case3Button];

    [self.view addSubview:stack];
    
    [NSLayoutConstraint activateConstraints:@[
        [stack.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [stack.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [stack.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [stack.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [stack.heightAnchor constraintEqualToConstant:250]
    ]];
    
}

- (void)onCaseTapped:(UIButton *)sender {
    ViewController *vc = [[ViewController alloc] initWithFriendCase:[self transferWithInteger:sender.tag]];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:vc animated:YES completion:nil];
}

- (Case)transferWithInteger:(NSInteger)tag {
    
    if (tag == 0) {
        return CaseOne;
    }
    
    if (tag == 1) {
        return CaseTwo;
    }
    
    return CaseThree;
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
