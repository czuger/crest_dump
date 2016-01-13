# Crest dump

## What ?

This dump contain all crest history data for all regions and all items (when available). 

It is a compilation of https://public-crest.eveonline.com/market/{region_id}/types/{type_id}/history/ for all regions and all types into a csv file.

## How to 

* Get the last version of the file on : http://evebs.net/public-dump/crest_dump.csv.gz
* You can check if the md5 correspond to http://evebs.net/public-dump/crest_dump.csv.gz.md5
* Unzip it and what you want with the data.

## File format

Each line gives you data in the following format : 

```
<region_code>;<type_code>;<history_date>;<order_count;<volume>;<low_price>;<avg_price>;<high_price>
```

Whith : 

* region_code : The CPP region code ( get information about a single region at https://public-crest.eveonline.com/regions/<region_code>/ or get all regions at https://public-crest.eveonline.com/regions/ )
* type_code : The CPP type (item) code ( get information about a single type at https://public-crest.eveonline.com/types/<type_code>/ or get all types at https://public-crest.eveonline.com/types/ )
* history_date : The CPP date of the day summary (not mine). This is an utc unix timestamp ( https://en.wikipedia.org/wiki/Unix_time )
* order_count : The number of orders.
* volume : The volume of items.
* low_price : The lowest price for the item.
* avg_price : The average price.
* high_price : The highest price.

More information at : https://wiki.eveonline.com/en/wiki/CREST_Getting_Started for crest data.

## Data update frequency

All data are not updated at the same frequency. Here is a list :

* Regions updated daily : The Forge, Sinq Laison, Domain, Heimatar, Metropolis
* Regions updated weekly : Black Rise, Curse, Devoid, Essence, Fountain, Genesis, Khanid, Kor-Azor, Lonetrek, Molden Heath, Placid, Providence
* All other regions are updated monthly


