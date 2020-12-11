using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

public class PaymentApiController : BaseApiController<Database.Payment, long>
{
    public PaymentApiController() : base("Reservation") { }
}
