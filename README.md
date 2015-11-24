# Space-API

## Prepare database

First, you need to fill your database with some data.

    bundle exec rake parser:all

## Launch

    bundle exec rails server

## Test

If you start testing for the first time, remember to fill your database first:

    RACK_ENV=test bundle exec rake parser:all

Then you can launch the tests:

    bundle exec rspec

## Roadmap

- [x] Create script to init values from scraping and not from hard coded values
- [ ] Create entities (Planets, Stars, ArtificialSatellites, Comets, Asteroids, ...)
- [ ] Split all resources into static/dynamic files (`_now` classes)
- [ ] Write a proper documentation to project's Github wiki
- [ ] Use modules to share behaviour and not (only) inheritance
- [ ] Use cache for static values
- [ ] Create simple client app
- [ ] Look for other links to parse for information
- [ ] Implement new resources like stars, artificial satellites, comets, asteroids
- [ ] Make it hypermedia (using Jbuilder)

## Links

* [List of Space Science NASA data](https://data.nasa.gov/browse/embed?category=Space+Science&limit=100&limitTo=&page=1&q=&sortBy=most_accessed&sortPeriod=year&utf8=%E2%9C%93&view_type=rich)
* [NASA API Catalog](https://data.nasa.gov/developer#page1)
  * [Interactive table for JSON result request](https://data.nasa.gov/Space-Science/Near-Earth-Comets-Orbital-Elements/b67r-rgxc)
  * [API Endpoint](https://data.nasa.gov/resource/b67r-rgxc.json)
* [Heliocentric Trajectories for Selected Spacecraft, Planets, and Comets](http://omniweb.gsfc.nasa.gov/coho/helios/heli.html)
* Constants
  * [Astrodynamic Constants](http://ssd.jpl.nasa.gov/?constants)
  * [Astronomical and phisical Constants](http://www.astronomynotes.com/tables/tablesa.htm)
* Stars
  * [Star Tables](http://www.astronomynotes.com/tables/tablesc.htm)
* Solar System
  * [NASA Space Science Data Coordinated Archive - Planetary Science](http://nssdc.gsfc.nasa.gov/planetary)
  * [Planets and Pluto: Physical Characteristics](http://ssd.jpl.nasa.gov/?planet_phys_par)
  * [Planet Properties](http://www.astronomynotes.com/tables/tablesb.htm)
  * [Planetary Satellite Physical Parameters](http://ssd.jpl.nasa.gov/?sat_phys_par)
  * [Table of Near-Earth Comets](http://neo.jpl.nasa.gov/cgi-bin/neo_elem?max_rows=0;fmt=full;action=Display%20Table;type=NEC;show=1)
  * [Table of Near-Earth Asteroids](http://neo.jpl.nasa.gov/cgi-bin/neo_elem?type=NEA;hmax=all;max_rows=0;fmt=full;action=Display%20Table;show=1)
  * [Table of Meteorite Landings](https://data.nasa.gov/Space-Science/Meteorite-Landings/gh4g-9sfh)
    * [API Endoint](https://data.nasa.gov/resource/gh4g-9sfh.json)
