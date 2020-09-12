
# Xendit QA Assessment

* Reuse cucumberjs still already available as template even though I never use before.

* Calculator was rendered as image instead of text field and buttons, so I decided to use image pixel comparison to verify the test result. 

* Decided to directly access/test the iframe address which is https://www.online-calculator.com/html5/online-calculator/index.php.

* Used two additional npm module - pngjs and pixelmatch to speed up the image comparison part.

* There will be more combination can be tested for calculator, but I will stop at this size as preparing the expected value images is still tedious manual work.

* Failed test cases will have diff image stored at .\unexpectedResult folder
