using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

public class BaseApiController<Entity,Key> : ApiController where Entity: class, new()
{
    protected DbContext dbContext;
    private String[] includes;
    public BaseApiController(params String[] includes)
    {
        this.dbContext = new Database.AirlineDbEntities();
        this.includes = includes;
    }
    // GET api/<controller>
    [HttpGet]
    public virtual IEnumerable<Entity> Get()
    {
        var query = dbContext.Set<Entity>().AsQueryable<Entity>();
        if(includes != null)
        {
            foreach (var i in includes)
            {
                query = query.Include(i);
            }
        }
        return query.ToList();
    }
    [HttpGet]
    // GET api/<controller>/5
    public Entity Get(Key id)
    {
        var query = dbContext.Set<Entity>().Find(id);
        if(query != null)
        {
            return query;
        }
        return null;
    }
    [HttpPost]
    // POST api/<controller>
    public virtual void Post([FromBody]Entity value)
    {
        dbContext.Entry<Entity>(value).State = EntityState.Added;
        dbContext.SaveChanges();
    }
    [HttpPut]
    // PUT api/<controller>/5
    public void Put([FromBody]Entity value)
    {
        dbContext.Entry<Entity>(value).State = EntityState.Modified;
        dbContext.SaveChanges();
    }
    [HttpDelete]
    // DELETE api/<controller>/5
    public void Delete(Key id)
    {
        var query = dbContext.Set<Entity>().Find(id);
        if (query != null)
        {
            dbContext.Entry<Entity>(query).State = EntityState.Deleted;
            dbContext.SaveChanges();
        }
    }
}
