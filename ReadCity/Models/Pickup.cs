using System;
using System.Collections.Generic;

namespace ReadCity.Models;

public partial class Pickup
{
    public int Id { get; set; }

    public string PostalCode { get; set; } = null!;

    public string City { get; set; } = null!;

    public string Street { get; set; } = null!;

    public string? House { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
    public string FullAddress => $"{City}, {Street}, {House}";
}
