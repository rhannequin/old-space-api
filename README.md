# Space-API

## Test

    RACK_ENV=test bundle exec rake db:prepare && bundle exec rake test

## Roadmap

- [ ] Split all resources into static/dynamic files (`_now` classes)
- [ ] Create script to init values from scrap and not from hard coded values
- [ ] Write a proper documentation
- [ ] Use cache for static values
- [ ] Create simple client app
- [ ] Look for other links to parse for information
- [ ] Implement new resources like constellations, artificial satellites, comets, asteroids
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
