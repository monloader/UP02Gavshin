using Microsoft.EntityFrameworkCore;
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
    /// Логика взаимодействия для OrdersWindow.xaml
    /// </summary>
    public partial class OrdersWindow : Window
    {
        private User _currentUser;
        public OrdersWindow(User currentUser)
        {
            InitializeComponent();
            _currentUser = currentUser;

            if (_currentUser?.RoleId == 1)
            {
                AddOrderBtn.Visibility = Visibility.Visible; 
            }

            LoadOrders();
        }
        private void LoadOrders()
        {
            using (var db = new DBContext())
            {
                var orders = db.Orders
                    //ззагрузка данных
                    .Include(o => o.OrderStatus)
                    .Include(o => o.PickupPoint)
                    .Include(o => o.OrderItems)
                    //вывод в listview
                    .Select(o => new
                    {
                        o.Id,
                        o.Code,
                        StatusName = o.OrderStatus.Name,
                        PickupPointAddress = $"{o.PickupPoint.City}, {o.PickupPoint.Street}, {o.PickupPoint.House}",
                        o.OrderDate,
                        o.DeliveryDate,
                        ArticlesText = string.Join(", ", o.OrderItems.Select(oi => oi.Article))
                    })
                    .ToList();

                OrdersList.ItemsSource = orders;
            }
        }

        private void AddOrderBtn_Click(object sender, RoutedEventArgs e)
        {
            OrderAddWindow window = new OrderAddWindow(null, _currentUser); 
            window.Owner = this;
            if (window.ShowDialog() == true)
            {
                LoadOrders();
            }

        }

        private void OrdersList_MouseDoubleClick(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (_currentUser?.RoleId != 1)
            {
                return;
            }

            if (OrdersList.SelectedItem != null)
            {
                dynamic selected = OrdersList.SelectedItem;
                int orderId = selected.Id;
                OrderAddWindow window = new OrderAddWindow(orderId, _currentUser);
                window.Owner = this;
                if (window.ShowDialog() == true)
                {
                    LoadOrders();
                }
            }
        }

        private void DeleteOrder_Click(object sender, RoutedEventArgs e)
        {
            if (_currentUser?.RoleId != 1)
            {
                return;
            }

            if (sender is Button btn && btn.Tag is int orderId)
            {
                var confirm = MessageBox.Show("Вы уверены, что хотите удалить этот заказ?",
                                              "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);
                if (confirm != MessageBoxResult.Yes)
                {
                    return;
                }

                using (var db = new DBContext())
                {
                    var order = db.Orders.Find(orderId);
                    if (order != null)
                    {
                        //сначала удаляется товар, потом сам заказ
                        var items = db.OrderItems.Where(oi => oi.OrderId == orderId).ToList();
                        db.OrderItems.RemoveRange(items);

                        db.Orders.Remove(order);
                        db.SaveChanges();
                    }
                }
                LoadOrders();
            }
        }

        private void BackBtn_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

    }
}
