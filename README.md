# Crest dump

## What ?

This dump contain all crest history data for all regions and all items (when available). 

It is a compilation of https://public-crest.eveonline.com/market/{region_id}/types/{type_id}/history/ for all regions and all types into a csv file.

More information at : https://wiki.eveonline.com/en/wiki/CREST_Getting_Started.

## How to ?

1. Get the last version of the file on : http://evebs.net/public-dump/crest_dump.csv.gz
1. Unzip it and use data.

You can also check the zip by matching it's md5 signature against http://evebs.net/public-dump/crest_dump.csv.gz.md5

## File format

Once unzipped, each line is in the following format : 

```
<region_code>;<type_code>;<history_date>;<order_count;<volume>;<low_price>;<avg_price>;<high_price>
```

With : 

* region_code : The CPP region code ( see https://public-crest.eveonline.com/regions/<region_code>/ or https://public-crest.eveonline.com/regions/ )
* type_code : The CPP type (item) code ( see https://public-crest.eveonline.com/types/<type_code>/ or https://public-crest.eveonline.com/types/ )
* history_date : The CPP date of the day summary. This is an utc unix timestamp ( https://en.wikipedia.org/wiki/Unix_time )
* order_count : The number of orders.
* volume : The volume of items.
* low_price : The lowest price for the item.
* avg_price : The average price.
* high_price : The highest price.

## Data update frequency

All data are not updated at the same frequency.

* Regions updated daily : The Forge, Sinq Laison, Domain, Heimatar, Metropolis
* Regions updated weekly : Black Rise, Curse, Devoid, Essence, Fountain, Genesis, Khanid, Kor-Azor, Lonetrek, Molden Heath, Placid, Providence
* All other regions are updated monthly


