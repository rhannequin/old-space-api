# Space-API

## Prepare database

First, you need to fill your database with some data.

    bundle exec rake db:prepare

## Launch

    bundle exec foreman start

## Test

If you start testing for the first time, remember to fill your database first:

    RACK_ENV=test bundle exec rake db:prepare

Then you can launch the tests:

    RACK_ENV=test bundle exec rake test

## Roadmap

- [x] Split all resources into static/dynamic files (`_now` classes)
- [ ] Use better MongoDB collections (Planets, Stars, ArtificialSatellites, Comets, Asteroids, ...)
- [ ] Create script to init values from scraping and not from hard coded values
- [ ] Use Github wiki for documentation
- [ ] Use modules to share behaviour and not (only) inheritance
- [ ] Write a proper documentation to project's Github wiki
- [ ] Use cache for static values
- [ ] Create simple client app
- [ ] Look for other links to parse for information
- [ ] Implement new resources like stars, artificial satellites, comets, asteroids
- [ ] Make it hypermedia

## Links

* [List of Space Science NASA data](https://data.nasa.gov/browse/embed?category=Space+Science&limit=100&limitTo=&page=1&q=&sortBy=most_accessed&sortPeriod=year&utf8=%E2%9C%93&view_type=rich)
* [NASA API Catalog](https://data.nasa.gov/developer#page1)
* [Table of Near-Earth Comets](http://neo.jpl.nasa.gov/cgi-bin/neo_elem?max_rows=0;fmt=full;action=Display%20Table;type=NEC;show=1)
  * [Interactive table for JSON result request](https://data.nasa.gov/Space-Science/Near-Earth-Comets-Orbital-Elements/b67r-rgxc)
  * [API Endpoint](https://data.nasa.gov/resource/b67r-rgxc.json)
* [Table of Near-Earth Asteroids](http://neo.jpl.nasa.gov/cgi-bin/neo_elem?type=NEA;hmax=all;max_rows=0;fmt=full;action=Display%20Table;show=1)
* [Table of Meteorite Landings](https://data.nasa.gov/Space-Science/Meteorite-Landings/gh4g-9sfh)
  * [API Endoint](https://data.nasa.gov/resource/gh4g-9sfh.json)
* [Heliocentric Trajectories for Selected Spacecraft, Planets, and Comets](http://omniweb.gsfc.nasa.gov/coho/helios/heli.html)
* [Planets and Pluto: Physical Characteristics](http://ssd.jpl.nasa.gov/?planet_phys_par)
* [Planetary Satellite Physical Parameters](http://ssd.jpl.nasa.gov/?sat_phys_par)
* [Astrodynamic Constants](http://ssd.jpl.nasa.gov/?constants)
