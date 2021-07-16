//
//  ViewController.m
//  ObjcTextfield
//
//  Created by Jamie Chen on 2021-07-15.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_textField addTarget:self action:@selector(textFielddidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFielddidChanged: (UITextField *)textField {
    // This works but only at first red word
    // https://stackoverflow.com/a/25248433/14939990
//    NSString *redColorString = @"red";
//    NSRange range = [textField.text rangeOfString:redColorString];
//    NSMutableAttributedString *mutableAttributeString = [[NSMutableAttributedString alloc] initWithString:textField.text];
//
//    [mutableAttributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
//
//
//    [textField setAttributedText:mutableAttributeString];
    // This still has flaw of auto add space after red.
    NSString *inputString = textField.text;
    NSArray *elementsByWord = [inputString componentsSeparatedByString:@" "];
    NSMutableAttributedString *replaceAttributeString = [[NSMutableAttributedString alloc] init];
    NSMutableArray *newString = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[elementsByWord count]; i++) {
        if (![elementsByWord[i] isEqual:@"red"]) {
            [newString addObject:elementsByWord[i]];
        } else {
            NSString *blackString = [newString componentsJoinedByString:@" "];
            NSAttributedString *blackAttributeString = [[NSAttributedString alloc]initWithString:blackString attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
            NSString *redString = [NSString stringWithFormat:@" %@ ", elementsByWord[i]];
            NSAttributedString *redAttributeString = [[NSAttributedString alloc]initWithString:redString attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
            newString = [NSMutableArray new];
            [replaceAttributeString appendAttributedString:blackAttributeString];
            [replaceAttributeString appendAttributedString:redAttributeString];
        }
    }
    
    if ([newString count] > 0) {
        NSString *blackString = [newString componentsJoinedByString:@" "];
        NSAttributedString *blackAttributeString = [[NSAttributedString alloc]initWithString:blackString attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        newString = [NSMutableArray new];
        [replaceAttributeString appendAttributedString:blackAttributeString];
    }
    
    [textField setAttributedText:replaceAttributeString];
}

@end
