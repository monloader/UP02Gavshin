using ReadCity.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ReadCity
{
    /// <summary>
    /// Логика взаимодействия для OrderAddWindow.xaml
    /// </summary>
    public partial class OrderAddWindow : Window
    {
        private int? _orderId;
        private User? _currentUser;
        public OrderAddWindow(int? orderId, User? currentUser)
        {
            InitializeComponent();
            _orderId = orderId;
            _currentUser = currentUser;
            LoadComboBoxes();

            if (_orderId.HasValue)
            {
                Title = "Редактирование заказа";
                LoadOrderData();
            }
            else
            {
                Title = "Добавление заказа";
            }
        }
        private void LoadComboBoxes()
        {
            using (var db = new DBContext())
            {
                if (_orderId.HasValue)
                {
                    StatusBox.ItemsSource = db.OrderStatuses.ToList();
                }
                else
                {
                    //при создании нового заказа статус Завершен недоступен
                    StatusBox.ItemsSource = db.OrderStatuses.Where(s => s.Name != "Завершен").ToList();
                }

                PickupBox.ItemsSource = db.Pickups.ToList();
                ProductBox.ItemsSource = db.Products.ToList();
            }
        }

        private void LoadOrderData()
        {
            using (var db = new DBContext())
            {
                var order = db.Orders.Find(_orderId.Value);
                if (order == null)
                {
                    return;
                }

                StatusBox.SelectedValue = order.OrderStatusId;
                PickupBox.SelectedValue = order.PickupPointId;
                OrderDatePicker.SelectedDate = order.OrderDate.ToDateTime(TimeOnly.MinValue);
                DeliveryDatePicker.SelectedDate = order.DeliveryDate.ToDateTime(TimeOnly.MinValue);

                var orderItem = db.OrderItems.FirstOrDefault(oi => oi.OrderId == order.Id);

                if (orderItem != null)
                {
                    var product = db.Products.FirstOrDefault(p => p.Article == orderItem.Article);
                    if (product != null)
                    {
                        ProductBox.SelectedValue = product.Id;
                    }

                    QuantityBox.Text = orderItem.Quantity.ToString();
                }
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            if (StatusBox.SelectedValue == null || PickupBox.SelectedValue == null)
            {
                MessageBox.Show("Заполните статус и пункт выдачи");
                return;
            }
            if (OrderDatePicker.SelectedDate == null || DeliveryDatePicker.SelectedDate == null)
            {
                MessageBox.Show("Выберите даты заказа и выдачи");
                return;
            }
            if (ProductBox.SelectedValue == null)
            {
                MessageBox.Show("Выберите товар");
                return;
            }

            if (!int.TryParse(QuantityBox.Text, out int quantity))
            {
                MessageBox.Show("Введите корректное количество");
                return;
            }

            if (quantity <= 0)
            {
                MessageBox.Show("Количество должно быть больше 0");
                return;
            }

            try
            {
                using (var db = new DBContext())
                {
                    Order order;

                    if (_orderId.HasValue)
                    {
                        order = db.Orders.Find(_orderId.Value);
                        if (order == null)
                        {
                            return;
                        }
                        //удаляем старые позиции заказа для замены на новые
                        var oldItems = db.OrderItems.Where(oi => oi.OrderId == _orderId.Value).ToList();
                        db.OrderItems.RemoveRange(oldItems);
                    }
                    else
                    {
                        order = new Order();
                        //генерация следующего код заказа
                        int maxCode = 900;
                        if (db.Orders.Any())
                        {
                            maxCode = db.Orders.Max(o => o.Code);
                        }
                        order.Code = maxCode + 1;

                        if (_currentUser != null)
                        {
                            order.UserId = _currentUser.Id;
                        }

                        db.Orders.Add(order);
                    }

                    order.OrderStatusId = (int)StatusBox.SelectedValue;
                    order.PickupPointId = (int)PickupBox.SelectedValue;
                    order.OrderDate = DateOnly.FromDateTime(OrderDatePicker.SelectedDate.Value);
                    order.DeliveryDate = DateOnly.FromDateTime(DeliveryDatePicker.SelectedDate.Value);

                    db.SaveChanges();

                    var selectedProduct = db.Products.Find((int)ProductBox.SelectedValue);

                    var orderItem = new OrderItem
                    {
                        OrderId = order.Id,
                        Article = selectedProduct.Article,
                        Quantity = quantity
                    };

                    db.OrderItems.Add(orderItem);
                    db.SaveChanges();
                }

                MessageBox.Show(_orderId.HasValue ? "Заказ обновлен!" : "Заказ добавлен!");
                DialogResult = true;
            }
            catch (Exception ex)
            {
                string realError = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
                MessageBox.Show($"Ошибка БД: {realError}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void CancelBtn_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
        }
    }
}
