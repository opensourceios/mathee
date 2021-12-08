//
//  SplashVC.swift
//  Guess
//
//  Created by Dani on 12/7/21.
//  Copyright © 2021 Dani Springer. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var descriptionTextView: UITextView!

    // MARK: Properties
    // TODO: fill each game
    // TODO: split tutorial to each page? If so, remove button from menu, remove text that mentions that button, and remove splash screen altogether, as each game will always show its tutorial.
    let aString = """
    Welcome.

    Heads up – this page is a quite long one. You can always come back to it later by tapping the Info button \
    on the home page of the app, then tapping on "Tutorial".

    Feel free to skip it for now to jump to the mini-games, by tapping on the X on the top right of this page.

    Or, read on...


    WHAT IS THIS APP FOR?

    This app serves two purposes. Firstly, it can entertain you or your friends by guessing numbers you think in \
    various ways. And secondly, it can teach you how to perform those math tricks on your own, so you won't need \
    the app anymore, in order to perform these math tricks on others.


    MINI-GAMES TO EXPERIENCE THEM YOURSELF

    You can try the app's mini-games in order to see if your results match the app's results, so you can sharpen
    your skills. Or just for fun.


    THE MAGIC FORMULA

    The "Magic Formula" is a simple sequence of operations performed on an initial number, which eventually return
    to it. There are many variants of this trick, but most involve asking the thinker (well, that's a title) to do \
    something with the actual number they thought, such as to subtract its value from their current result – which \
    of course comes across as silly.

    This one does not.

    Here is how it works.

    Thinker thinks of a number. Let's call it N.

    The formula you will have them do is: N x 3 / 2 x 3 / 2 / 9

    In other words, here is what the public will see and hear:

    - Think of a number
    OK
    - Multiply it by 3
    OK
    - Divide it by 2
    OK
    - Multiply it by 3
    AGAIN?
    - Yes
    OK
    - Divide by 2
    AGA.. OK OK
    - How many times does 9 fit into the result? Ignoring any remainder
    3
    - You thought 12

    BOOM! Magic, right? Well, no. Just math.

    Let's go through the steps again.
    "Multiply by 3" happens twice. This is equal to multiplying by 9.
    "Divide by 2" happens twice. This is equal to dividing by 4.

    So when asking the Thinker "ignoring any remainder, how many times does 9 fit into the result?", we are \
    dividing by 9, essentially canceling out the two times that they multiplied their number by 3.

    Then, once they say how many times 9 fits into their result, YOU (silently) multiply that number by 4 – \
    thereby canceling the two times that they divided their result by 2, and going right back to the number \
    they originally thought (sometimes people forget what they thought, don't take it personal...).

    Let's now go through the above example again.

    - Think of a number
    OK (12)
    - Multiply it by 3
    OK (36)
    - Divide it by 2
    OK (18)
    - Multiply it by 3
    AGAIN?
    - Yes
    OK (54)
    - Divide by 2
    AGA.. OK OK (27)
    - How many times does 9 fit into the result? Ignoring any remainder
    3 (27/9=3)
    - You thought 12 (3x4=12)

    OK so that was simple enough. But... what about when you ask them to divide their number by 2, but their \
    number is odd?

    So you must ask if their current result is odd or even, before each time you ask to divide it by 2 (no need \
    to ask when dividing by 9, as we ignore the remainder anyway)

    In the case that it is odd, you say "Add 1 first, then divide by 2". If they say even, just say "divide by 2".

    Now, the first time that you ask if it's odd or even, is "worth" 1. The second time is worth "2" (an \
    explanation as to why will be below). You must keep that "worth" in mind.

    So if the first time it's odd, the worth will be 1.
    If the second time it's odd, the worth will be 2.
    If both times it's odd, the worth will be 3 (1+2).
    And if neither time it's odd, the worth will be 0.

    AFTER multiplying their answer to "how many times does 9 fully fit in the result" by 4, you will add \
    whatever worth you have in mind, and obtain their original number.

    Let's look at an example involving this, and using the correct full list of questions that you must always use.

    - Think of a number
    OK (13)
    - Multiply it by 3
    OK (39)
    - Odd or even?
    Odd
    - Add 1 (Worth now is: 1)
    OK (40)
    - Divide it by 2
    OK (20)
    - Multiply it by 3
    AGAIN?
    - Yes
    OK (60)
    - Odd or even
    Even
    - Divide by 2 (No worth needs to be added because Thinker didn't have to add anything)
    AGA.. OK OK (30)
    - How many times does 9 fit into the result? Ignoring any remainder
    3 (30/9=3.33...)
    - You thought 13 (3x4 + worth of 1 = 13)

    A final note: the first time the "worth" is 1 because you ask Thinker to add 1.
    The second it's worth double, because at that point they already divided their number by 2 once, thereby
    causing whatever change you will do to it, to double, once you cancel out their divisions.

    Best of luck!


    BOOK:
    About
    How to do


    THE CHESS PUZZLE: See app page for what the puzzle is. As far as how to do it... I cannot help you. My only
    suggestion is to position the queens in a horse move relation to each other, most of the time.


    HGHER LOWER:
    Higher Lower has the Thinker think of a number from a range of your choice, and then the challenge for you \
    is to guess that number in as few tries as you can. The only thing Thinker needs to say is "Higher", if their \
    number is higher than your guess, "Lower" if their number is lower than your guess, or "Correct" if you got \
    it right.

    How many tries should it take you at most? Well, how many times can you divide the highest number in the \
    range (for example, given a range of 1-1000, how many times can you divide 1000) by 2? That's how many \
    (or 1 more, depending on whether the total amount of numbers is odd or even).

    For example:

    - Think of a number from 1 to 1000
    OK

    (Now the most efficient guess is 500, half of the highest number)

    - Is it 500?
    No, lower

    (Now you know it's from 1 to 500. What's your next guess?)

    - Is it 250?
    No, higher

    (Oh no! Confusing... Not really. Now you know it's higher than 250, and lower than 500)

    - Is it 375? (the "half number between 250 and 500")
    No, lower

    - Is it 312?
    No, higher

    - Is it 343?
    No, lower

    - Is it 327?
    No, higher

    (Uff, getting there)

    - Is it 335?
    No, higher

    - Is it 339?
    No, higher

    - Is it 341?
    No, lower

    - You thought 340

    Whew! So this one took 10 tries. And that is the most amount of tries it should take you to guess any number \
    from 1 to 1000 - in fact, from 1 to 1024 (which is 2 to the power of 10)

    Best of luck!


    MATHEMAGIC:
    Mathemagic revolves around the fact that the number 9 is quite a magical one.
    You can try it a few times in the mini-game itself, and that should suffice to understand how to do it to others.
    The pattern essentially is as follows:

    - Thinker thinks of a number which is equal to 10 or higher
    - Thinker adds all the digits of the number together (for example, if number was 24, you get 2+4=6)
    - Thinker subtracts new result from original number (24-6=18)
    - Fun fact! We now know that Thinker is left with 9 – or a multiple of 9
    - Ask if the new result (after the subtraction) is made up of a single digit or more
    - If it's one digit, it's 9
    - Otherwise, ask to add up all the digits of the new result together (18 would be 1+8=9)
    - And repeat. Is it one digit? Then it's 9. Is it not? Then add all the digits together. And so on... \
    eventually it will be 9.

    BONUS FUN FACT: if, when adding up the digits of the original number, the result is more than one digit, \
    Thinker can choose (and doesn't even have to tell you which option they choose, trick will still work) \
    whether to subtract the initial sum of their original number, from their original number, or whether to add \
    up the digits of the new result, and subtract the second new result, from the original number.

    For example: Thinker thinks 1576.
    1+5+7+6=19
    1576-19=1557 (and 1557 is a multiple of 9, so trick would work from here, but also...)

    1+5+7+6=19
    1+9=10 (second result)
    1576-10=1566 (and 1566 is also a multiple of 9, so trick would work here too, but the magic doesn't end here...)

    1+5+7+6=19
    1+9=10
    1+0=1 (third result)
    1576-1=1575 (and 1575 is ALSO a multiple of 9, so adding up all its digits will. Work. Here Too. Amazing, isn't it?)

    1+5+5+7=18
    1+5+6+6=18
    1+5+7+5=18
    1+8=9

    BOOM!

    Best of luck!


    Dani
    """

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.text = aString

        descriptionTextView.layer.cornerRadius = 8

        let myPadding: CGFloat = 16

        descriptionTextView.contentInset = UIEdgeInsets(top: myPadding, left: myPadding,
                                                        bottom: myPadding, right: myPadding)

        //        let image = UIImage(systemName: "square.and.arrow.up")?.withTintColor(myThemeColor)
        //        let attachment = NSTextAttachment()
        //        attachment.image = image
        //        let attString = NSAttributedString(attachment: attachment)
        //        descriptionTextView.textStorage.insert(attString, at: 416)
        //
        //        let image2 = UIImage(systemName: "plus")?.withTintColor(myThemeColor)
        //        let attachment2 = NSTextAttachment()
        //        attachment2.image = image2
        //        let attString2 = NSAttributedString(attachment: attachment2)
        //        descriptionTextView.textStorage.insert(attString2, at: 382)
        descriptionTextView.setContentOffset(CGPoint(x: 0, y: -myPadding), animated: false)
    }


    // MARK: Actions

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true)
    }

}
