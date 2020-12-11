using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Database;

public class RouteApiController : BaseApiController<Database.Route, int>
{
    public override IEnumerable<Route> Get()
    {
        var query = dbContext.Set<Route>().ToList();
        return query.Select(x=> new Route {
            Distance = x.Distance,
            Flights = null,
            FromAirport = x.FromAirport, 
            FromCity = x.FromCity, 
            FromCountry = x.FromCountry, 
            FromLat = x.FromLat,
            FromLong = x.FromLong,
            Id = x.Id, 
            ToAirport = x.ToAirport,
            ToCity = x.ToCity,
            ToCountry = x.ToCountry,
            ToLat = x.ToLat, 
            ToLong = x.ToLong
        }).ToList();
    }
}
