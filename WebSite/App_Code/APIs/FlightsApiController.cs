using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Database;

public class FlightsApiController : BaseApiController<Database.Flight, String>
{
    public FlightsApiController() : base("Route") { }
    public override IEnumerable<Flight> Get()
    {
        var query = dbContext.Set<Flight>().ToList();
        return query.Select(x => new Flight
        {
            Id = x.Id,
            RoutId = x.RoutId,
            Route = new Route {
                FromAirport = x.Route.FromAirport,
                ToAirport = x.Route.ToAirport
            },
            Schedules = null
        }).ToList();
    }
    public override void Post([FromBody] Flight value)
    {
        value.Route = null;
        value.Schedules = null;
        base.Post(value);
    }
}
