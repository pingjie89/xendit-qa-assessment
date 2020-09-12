//const expect = require('chai').expect;
const { fail } = require('assert');

const webdriver=require('selenium-webdriver'),
By = webdriver.By,
until = webdriver.until;

module.exports = function () {

    this.Given(/^Open chrome browser and start application$/, async function () {
        await driver.get('https://www.online-calculator.com/html5/online-calculator/index.php');
    });

    this.When(/^I enter following values and press = button$/, async function (dataTable) {
        
        sendKey(dataTable.raw()[0][1]);
        sendKey(dataTable.raw()[1][1]); 
        if (dataTable.raw()[1][1] != 'ne') {
            sendKey(dataTable.raw()[2][1]);
            sendKey('=');
        }
    });

    this.When(/^I enter single value with operator only button$/, async function (dataTable) {
        
        sendKey(dataTable.raw()[0][1]);
        sendKey(dataTable.raw()[1][1]);
        sendKey('=');

    });

    this.When(/^I enter a chain of input$/, async function (dataTable) {
        
        sendKey(dataTable.raw()[0][1]);
    });

    this.Then(/^I should be able to see$/, async function (table) {
       var expectedValue = table.raw()[0][1];
       await new Promise(r => setTimeout(r, 2000));
       var returnImagePath = takeScreenshot(expectedValue);
       await new Promise(r => setTimeout(r, 2000));
       if(!verifyviaImageCompare(returnImagePath, expectedValue)) { fail('Image return does not match with expectedImage folder images') };
    });

    this.After(async function() {
        //await driver.Close();
    });

    function sendKey(values) {
        driver.findElement(By.xpath('//body')).sendKeys(values);
    }

    function verifyviaImageCompare(ImagePathForVerification, expectedValue) {
        const fs = require('fs');
        const PNG = require('pngjs').PNG;
        const pixelmatch = require('pixelmatch');
        
        const img1 = PNG.sync.read(fs.readFileSync("./expectedImage/" + expectedValue + ".tiff"));
        const img2 = PNG.sync.read(fs.readFileSync(ImagePathForVerification));
        const {width, height} = img1;
        const diff = new PNG({width, height});
        
        var numberDiff = pixelmatch(img1.data, img2.data, diff.data, width, height, {threshold: 0.1});
        
        if (numberDiff > 0) { fs.writeFileSync('./unexpectedResult/expectingValue'+ expectedValue  +'diff.png', PNG.sync.write(diff)); }

        return numberDiff > 0 ? false : true;
    }

    function takeScreenshot(expectedValue) {
    const fs = require("fs");
    var now = new Date().getTime();
    var imagePath="./reports/"+now+"_"+expectedValue+".tiff";
    webElement=driver.findElement(By.id("canvas"));
        var base64Data = "";
        var location = {};
        var bulk = [];
        driver.then(_ => {
            webElement.getLocation().then(e => {
                location.x = e.x;
                location.y = e.y;
            });
            webElement.getSize().then(e => {
                location.height = e.height;
                location.width = e.width;
            });
            driver.manage().window().getSize().then(e => {
                location.browserHeight = e.height;
                location.broserWidth = e.width;
            });
        }).then(_ => {
            driver.takeScreenshot().then(data => {
                base64Data = data.replace(/^data:image\/png;base64,/, "");
            });
        }).then(_ => {
            const sizeLimit = 700000; // around 700kb
            const imgSize = base64Data.length;
            driver.executeScript(() => {
                window.temp = new Array;
            }).then(_ => {
                for (var i = 0; i < imgSize; i += sizeLimit) {
                    bulk.push(base64Data.substring(i, i + sizeLimit));
                }
                bulk.forEach((element, index) => {
                    driver.executeScript(() => {
                        window.temp[arguments[0]] = arguments[1];
                    }, index, element);
                });
            });
        }).then(_ => {
            driver.executeScript(() => {
                var tempBase64 = window.temp.join("");
                var image = new Image();
                var location = arguments[0];
                image.src = "data:image/png;base64," + tempBase64;
                image.onload = function () {
                    var canvas = document.createElement("canvas");
                    canvas.height = location.height;
                    canvas.width = location.width;
                    canvas.style.height = location.height + 'px';
                    canvas.style.width  = location.width + 'px';
                    var ctx = canvas.getContext('2d');
                    ctx.drawImage(image, -location.x, -location.y);
                    window.canvasData = canvas.toDataURL();
                    window.temp = [];
                }
            }, location);
        }).then(_ => {
            return driver.executeScript(() => {
                var data = window.canvasData;
                window.canvasData = "";
                return data;
            }).then(data => {
                var tempData = data.replace(/^data:image\/png;base64,/, "");
                fs.writeFileSync(imagePath, tempData, "base64");
            });
        });

        return imagePath;
    }
};