using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Kmc_Login
{
    public class Event
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public DateTime EventDate { get; set; }
        public string Location { get; set; }
        public string Description { get; set; }
        public string CreatedBy { get; set; }

    }
}