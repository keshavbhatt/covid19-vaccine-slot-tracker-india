# Covid19 Vaccine slot availability tracker for India

This bash script takes Date and Area pin code as Input and shows various information about vaccination centre available at the given location

> NOTE: This script will work only with Indian IPs, as Cowin API server
> do not allow access from outside India.

## Requirements:

 - jq (`sudo apt install jq`)
 - curl (`sudo apt install curl`)

## How to Use:

The script takes two arguments:  `<date> <area-pin-code>`

**Print usage instructions**

    ./app -h

**Simple use case:**

    ./app <date> <area-pin-code>


Where `date` is passed in any format that the `date` command accept see [examples here](https://www.gnu.org/software/coreutils/manual/html_node/Examples-of-date.html) and `area-pin-code` is the PIN code of area/location you want to get information about. You can find area pin code for your location [here](http://pincode.india-server.com/) 

**Example usage:**

To, see information about various covid vaccination centres for pin code 246149 for Today: 

    ./app  $(date +'today') 246149
or

    ./app  today 246149

To, see information about various covid vaccination centres for pin code 246149 for tomorrow: 

    ./app  $(date +'tomorrow') 246149
or

    ./app  tomorrow 246149

To, see information various covid vaccination centres for pin code 246149 of specified date i.e, of 2021-05-16 :

    ./app  2021-05-16 246149

## What else could be done

The script is in early development stage, please contribute to bring more features. 
I quickly assembled and rolled this in few hours, am no BASH expert. so looking forward for contributors.

**Features I am wishing to add:**

 - Ability to run this script or a separate script as CRON job and notify user about the availability of slot after set interval using `notify-send`? etc.
