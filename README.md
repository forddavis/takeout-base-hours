# takeout-base-hours
Simple ruby script to determine hours spent at office using Google Takeout GPS data

## Usage
1) Go to https://takeout.google.com/settings/takeout/downloads
 - "CREATE NEW ARCHIVE" > "SELECT NONE" > Click Switch next to "Location History | JSON Format" > "NEXT" > "CREATE ARCHIVE"
2) Download the archive
3) Open the `Takeout` folder
4) Put this file in the `Location History` folder
5) Open the `Location History` folder in the terminal
6) Customize `HOME_LAT, HOME_LONG, HOME_LAT_1, HOME_LONG_1, WORK_LAT, WORK_LONG` to your own GPS coordinates
 - Home 1 can be an alternate location you want to track, in this basic script the only output is the hours, but you can customize to get time spent at other locations as well
7) Customize `START_DATE` and `END_DATE` to the date range you want to track
8) Run `$ takeout.rb`

The script will output the number of hours spent within a city-block of the coordinates used in `WORK_LAT, WORK_LONG`.
