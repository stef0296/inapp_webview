# inapp_browser

An in-app browser using Webviews in Flutter.

## Important:
This project is still a WIP and new features and improved functionality will be added soon.

## Usage
1. Use URIs for all purposes. Make sure to pass a valid URI as the plugin doesn't verify this on it's own. This functionality will be added in the future versions.
2. Create your URI in the following way: ```Uri uri = Uri.parse('https://www.google.com')```
3. Call the ```InappBrowser.showPopUpBrowser()``` method and pass your ```context``` and your ```URI```

## What's working:
- Forward backward navigation
- page refresh.
- URL share functionality

## Known issues:
- Forward backward navigation is a little buggy for AMP pages
- URLs with redirects break backward navigation

If there are any open issues, feel free to open an issue on Github.
For feature requests, open an issue on Github with a feature label.
If you feel like you can help me with this project, open a PR.