# IronRail Transit System

This API exposes one endpoint, but it's a good one

`GET /v1`

Parameters:

* `latitude` of your location - required
* `longitude` of your location - required
* `radius` in meters - optional, defaults to 1 mile in meters

Example return schema:

```
[
  {
    type:            "bikeshare",
    latitude:        "38.9003",
    longitude:       "-77.0429",
    name:            "19th St & Pennsylvania Ave NW",
    num_bikes:       9,
    num_empty_docks: 5,
    last_update:     "2015-06-18T17:49:41.000-04:00"
  },
  {
    type: "metro",
    latitude: "38.9006980092",
    longitude: "-77.050277739",
    name: "Foggy Bottom",
    address: {
      City: "Washington",
      State: "DC",
      Street: "2301 I St. NW",
      Zip: "20037"
    },
    trains: [
      {
        line: "BL",
        time: null,
        cars: 6,
        direction: "Largo Town Center",
        min: "BRD"
      },
      {
        line: "OR",
        time: null,
        cars: 6,
        direction: "Vienna/Fairfax-GMU",
        min: "ARR"
      },
      {
        line: "SV",
        time: "2015-06-18T17:54:31.017-04:00",
        cars: 6,
        direction: "Largo Town Center",
        min: "2"
      },
      {
        line: "SV",
        time: "2015-06-18T17:55:31.017-04:00",
        cars: 6,
        direction: "Wiehle-Reston East",
        min: "3"
      },
      {
        line: "BL",
        time: "2015-06-18T17:56:31.017-04:00",
        cars: 6,
        direction: "Franconia-Springfield",
        min: "4"
      },
      {
        line: "OR",
        time: "2015-06-18T17:59:31.017-04:00",
        cars: 8,
        direction: "New Carrollton",
        min: "7"
      }
    ]
  }
]
```

Each result will have a type of either `bikeshare` or `metro`. All entries of the same type will have the same schema.
