import { test } from '@playwright/test';

test('headed sample screenshot', async ({ page }) => {
  await page.goto('https://example.com');
  await page.screenshot({ path: 'test-output/example.png', fullPage: true });
});
