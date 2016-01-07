# Crest dump

This dump contain all crest history data for all regions and all items (when available).


## How to 

To get the last version of the file, please go to : http://evebs.net/public-dump/

Download the gz archive and check if the md5 sum correspond.

## File format

```
<region_code>;<type_code>;<history_date>;<order_count;<volume>;<low_price>;<avg_price>;<high_price>
```

Where

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

* Regions updated daily : The Forge, Sinq Laison, Domain, Heimatar, Metropolis
* Regions updated weekly : Black Rise, Curse, Devoid, Essence, Fountain, Genesis, Khanid, Kor-Azor, Lonetrek, Molden Heath, Placid, Providence
* All other regions are updated monthly


