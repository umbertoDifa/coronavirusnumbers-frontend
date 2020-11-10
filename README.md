# Corona Virus Numbers

A flutter project to visualize statistics about corona data.

The Provider pattern is used to manage the state.

[Live hosted on github pages!](https://umbertodifa.github.io/coronavirusnumbers-frontend/)

[Backend](https://github.com/Carassale/coronavirusnumbers-express-api) thanks to [@Carassale](https://github.com/Carassale) 

## Features
- World high-level stats & Country specific stats
- Order by _CASES_, _DEATHS_ and _RECOVERED_
- Search by country name
- Add country to favorites to see it at the top of the list

![](./screenshot.jpeg )
## Build
- `docker-compose up`
- connect to `localhost:8080`

## CI/CD
 Github actions :heart:

## Data
Data is fetched from the [JohnHopkins Project](https://coronavirus.jhu.edu/map.html)