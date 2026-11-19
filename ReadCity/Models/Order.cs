using System;
using System.Collections.Generic;

namespace ReadCity.Models;

public partial class Order
{
    public int Id { get; set; }

    public DateOnly OrderDate { get; set; }

    public DateOnly DeliveryDate { get; set; }

    public int PickupPointId { get; set; }

    public int UserId { get; set; }

    public int Code { get; set; }

    public int OrderStatusId { get; set; }

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    public virtual OrderStatus OrderStatus { get; set; } = null!;

    public virtual Pickup PickupPoint { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
