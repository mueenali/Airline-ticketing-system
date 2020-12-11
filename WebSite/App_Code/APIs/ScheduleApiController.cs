using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

public class ScheduleApiController : BaseApiController<Database.Schedule, long>
{
    public ScheduleApiController() : base("AirCraft") { }
}
