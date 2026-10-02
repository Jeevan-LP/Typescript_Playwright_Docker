import {test,Page,Browser,BrowserContext} from "@playwright/test";
/**
beforeAll(): Runs once before all tests. Used for launching the browser, creating test data, etc. -->Once
beforeEach(): Runs before every test. Used for login, opening a page, or common setup. -->Before each test
afterEach(): Runs after every test. Used for logout, taking screenshots on failure, or cleanup. -->After each test
afterAll(): Runs once after all tests. Used for closing the browser, deleting test data, etc. -->Once
 */

let testPage: Page;

test.beforeAll("Launching Browser", async({browser})=>{
    testPage=await browser.newPage();
    await testPage.goto("https://demowebshop.tricentis.com/");
    console.log("Browser Launched Successfully");
});

test.afterAll("Closing Browser", async({browser})=>{
    await testPage.close();
    console.log("Browser Closed Successfully");
});

test.beforeEach("Login to Application", async()=>{
    await testPage.locator(".ico-login").click();
    await testPage.locator("#Email").fill("jeevangowda016@gmail.com");
    await testPage.locator("#Password").fill("Appu@123");
    await testPage.locator("[value='Log in']").click();
})

test.beforeEach("Logout to Application", async()=>{
    await testPage.locator(".ico-logout").click();
})

test("Subscribe", async()=>{
        await testPage.locator("#newsletter-email").fill("jeevangowda016@gmail.com");
        await testPage.locator("#newsletter-subscribe-button").click();
        await testPage.locator("#pollanswers-2").check();
        await testPage.locator("#vote-poll-1").click();
})