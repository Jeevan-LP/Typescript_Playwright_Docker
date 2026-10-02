import { defineConfig, devices } from '@playwright/test';
import { workers } from 'node:cluster';

const isCi = !!((globalThis as any).process?.env?.CI);
export default defineConfig({

  /* waits */
  //timeout:60000,
  //expect:{timeout:30000},
  
  /* tags */
  //grep:/@Sanity/,
  //grep:/(?=.*@Sanity)(?=.*@Regression)/,
  //grep:/(@Sanity)|(@Regression)/,
  //grepInvert:/@Regression/,
  //grepInvert:/@Sanity/,

  /* parallel execution */
  fullyParallel:false,
  workers:5,

  /* Reporter to use. See https://playwright.dev/docs/test-reporters */
  //reporter:[['allure-playwright']],
  //reporter:[['allure-playwright', {resultsDir:'./report/allure-report'}]],
  // reporter:[['html', {open:'always', outputFolder:'HTML-Report'}],//to create custom folder for html report
  //           ['line'],
  //           ['list'],
  //           ['dot'],
  //           ['junit', {outputFile:'JUNIT-Report/JUNIT-Report.xml'}],//to create custom folder for junit report
  //           ['json', {outputFile:'JSON-Report/JSON-Report.json'}],//to create custom folder for json report
  //           ['allure-playwright',{open:'on-failure'}]
  //          ],

  testDir: './tests',
  outputDir:'./test-output',
  /* Run tests in files in parallel */
  //fullyParallel: false,
  /* Fail the build on CI if you accidentally left test.only in the source code. */
  forbidOnly: !!process.env.CI,
  /* Retry on CI only */
  //retries: process.env.CI ? 2 : 0,

  //for playwright global test to handle flaky test
  //retries:3,

  /* Opt out of parallel tests on CI. */
  //workers: process.env.CI ? 1 : undefined,
  /* Shared settings for all the projects below. See https://playwright.dev/docs/api/class-testoptions. */
  use: {
    headless:true,
    screenshot:'off',
    trace: 'off',
    video:'off',
    //storageState:'openSource.json',
    /* Base URL to use in actions like `await page.goto('')`. */
    // baseURL: 'http://localhost:3000',

    /* Collect trace when retrying the failed test. See https://playwright.dev/docs/trace-viewer */
  },

  /* Configure projects for major browsers */
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
        //fullyParallel:true,
        //workers:5,
    },
/*
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
        //fullyParallel:false,
        //workers:1,
    },

    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
*/
    /* Test against mobile viewports. */
    // {
    //   name: 'Mobile Chrome',
    //   use: { ...devices['Pixel 5'] },
    // },
    // {
    //   name: 'Mobile Safari',
    //   use: { ...devices['iPhone 12'] },
    // },

    /* Test against branded browsers. */
    // {
    //   name: 'Microsoft Edge',
    //   use: { ...devices['Desktop Edge'], channel: 'msedge' },
    // },
    // {
    //   name: 'Google Chrome',
    //   use: { ...devices['Desktop Chrome'], channel: 'chrome' },
    // },
  ],

  /* Run your local dev server before starting the tests */
  // webServer: {
  //   command: 'npm run start',
  //   url: 'http://localhost:3000',
  //   reuseExistingServer: !process.env.CI,
  // },

  
});