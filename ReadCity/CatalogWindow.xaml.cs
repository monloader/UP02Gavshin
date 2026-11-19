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
using System.IO;

namespace ReadCity
{
    /// <summary>
    /// Логика взаимодействия для CatalogWindow.xaml
    /// </summary>
    public partial class CatalogWindow : Window
    {
        private User _currentUser;
        private List<ProductCard> _allProducts = new List<ProductCard>();
        public CatalogWindow(User currentUser)
        {
            InitializeComponent();
            _currentUser = currentUser;
            if (currentUser != null)
            {
                FioText.Text = currentUser.Fio;

                if (currentUser.RoleId == 1 || currentUser.RoleId == 2)
                {
                    FilterPanel.Visibility = Visibility.Visible;
                    OrdersBtn.Visibility = Visibility.Visible;
                }

                if (currentUser.RoleId == 1)
                {
                    AddProductBtn.Visibility = Visibility.Visible;
                }
            }
            else
            {
                FioText.Text = "Гость";
            }
            LoadProducts();

        }
        public static string rootPath = AppDomain.CurrentDomain.BaseDirectory;

        private void LoadProducts()
        {
            using (var db = new DBContext())
            {
                var productsFromDb = db.Products
                    .Include(p => p.Category)
                    .Include(p => p.Manufacturer)
                    .Include(p => p.Supplier)
                    .Include(p => p.Unit)
                    .OrderBy(p => p.Id)
                    .ToList();

                _allProducts.Clear(); 

                foreach (var product in productsFromDb)
                {
                    var card = new ProductCard();
                    card.IsAdmin = (_currentUser?.RoleId == 1);
                    card.Id = product.Id; 
                    card.Name = product.Name;
                    card.Description = product.Description ?? "";
                    card.Quantity = product.Quantity;
                    card.Sale = product.Sale;
                    card.PriceValue = product.Price; 
                    card.CategoryName = product.Category.Name;
                    card.ManufacturerName = product.Manufacturer.Name;
                    card.SupplierName = product.Supplier.Name;
                    card.UnitName = product.Unit.Name;

                    //заглушка если нет фото
                    string defaultImgPath = System.IO.Path.Combine(rootPath, "Images", "picture.png");
                    if (!string.IsNullOrEmpty(product.Photo))
                    {
                        string imgPath = System.IO.Path.Combine(rootPath, "Images", product.Photo);
                        card.PhotoPath = File.Exists(imgPath) ? imgPath : defaultImgPath;
                    }
                    else
                    {
                        card.PhotoPath = defaultImgPath;
                    }

                    if (product.Sale > 0)
                    {
                        decimal discountAmount = product.Price * product.Sale / 100m;
                        decimal finalPrice = product.Price - discountAmount;
                        card.OldPriceText = product.Price.ToString("N2") + " руб.";
                        card.NewPriceText = finalPrice.ToString("N2") + " руб.";
                    }
                    else
                    {
                        card.OldPriceText = "";
                        card.NewPriceText = product.Price.ToString("N2") + " руб.";
                    }
                    //подсветка 
                    if (product.Quantity == 0)
                    {
                        card.CardColor = "#D3D3D3";
                    }
                    else if (product.Sale > 25)
                    {
                        card.CardColor = "#23E1EF";
                    }
                    else
                    {
                        card.CardColor = "#FFFFFF";
                    }
                    _allProducts.Add(card);
                }
            }

            ApplyFilters();
        }

        private void OrdersBtn_Click(object sender, RoutedEventArgs e)
        {
            OrdersWindow ordersWindow = new OrdersWindow(_currentUser); 
            ordersWindow.Owner = this;
            ordersWindow.ShowDialog();
        }

        private void ApplyFilters()
        {
            if (_allProducts == null)
            {
                return;
            }

            IEnumerable<ProductCard> result = _allProducts;
            //поиск по всем полям
            if (SearchBox != null && !string.IsNullOrWhiteSpace(SearchBox.Text))
            {
                string query = SearchBox.Text.Trim().ToLower();
                result = result.Where(p =>
                    (p.Name != null && p.Name.ToLower().Contains(query)) ||
                    (p.Description != null && p.Description.ToLower().Contains(query)) ||
                    (p.CategoryName != null && p.CategoryName.ToLower().Contains(query)) ||
                    (p.ManufacturerName != null && p.ManufacturerName.ToLower().Contains(query)) ||
                    (p.SupplierName != null && p.SupplierName.ToLower().Contains(query)) ||
                    (p.UnitName != null && p.UnitName.ToLower().Contains(query))
                );
            }

            if (DiscountBox != null && DiscountBox.SelectedIndex > 0)
            {
                if (DiscountBox.SelectedIndex == 1)
                {
                    result = result.Where(p => p.Sale >= 0 && p.Sale <= 12.99);
                }
                else if (DiscountBox.SelectedIndex == 2)
                {
                    result = result.Where(p => p.Sale >= 13 && p.Sale <= 16.99);
                }
                else if (DiscountBox.SelectedIndex == 3)
                {
                    result = result.Where(p => p.Sale >= 17);
                }
            }
            if (SortBox != null)
            {
                switch (SortBox.SelectedIndex)
                {
                    case 1:
                        result = result.OrderBy(p => p.PriceValue);
                        break;
                    case 2:
                        result = result.OrderByDescending(p => p.PriceValue);
                        break;
                    case 3:
                        result = result.OrderBy(p => p.Quantity);
                        break;
                    case 4:
                        result = result.OrderByDescending(p => p.Quantity);
                        break;
                }
            }

            if (ProductsList != null)
            {
                ProductsList.ItemsSource = result.ToList();
            }
        }

        private void DeleteProduct_Click(object sender, RoutedEventArgs e)
        {
            if (_currentUser?.RoleId != 1)
            {
                MessageBox.Show("Удалять товары может только администратор.", "Доступ запрещен", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (!(sender is Button btn))
                {
                    return;
                }

            if (btn.Tag == null)
            {
                return;
            }

            int productId = (int)btn.Tag;

            using (var db = new DBContext())
            {
                var product = db.Products.Find(productId);

                if (product == null)
                {
                    return;
                }

                bool isInOrders = db.OrderItems.Any(oi => oi.Article == product.Article);
                //проверка есть ли товар в заказах
                if (isInOrders)
                {
                    MessageBox.Show("Этот товар присутствует в заказах. Удалить его нельзя.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                var confirm = MessageBox.Show("Вы уверены, что хотите удалить этот товар?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);

                if (confirm != MessageBoxResult.Yes)
                {
                    return;
                }

                if (!string.IsNullOrEmpty(product.Photo) && product.Photo != "picture.png")
                {
                    string imgPath = System.IO.Path.Combine(rootPath, "Images", product.Photo);
                    if (File.Exists(imgPath))
                    {
                        try
                        {
                            File.Delete(imgPath);
                        }
                        catch (IOException)
                        {

                        }
                    }
                }

                db.Products.Remove(product);
                db.SaveChanges();
                MessageBox.Show("Товар удален");
            }

            LoadProducts();

        }
    

        private void Logout_Click(object sender, RoutedEventArgs e)
        {
            var loginWindow = new MainWindow();
            loginWindow.Show();
            Close();
        }

        private void AddProductBtn_Click(object sender, RoutedEventArgs e)
        {
            ProductAddWindow window = new ProductAddWindow(null); 
            window.Owner = this;
            if (window.ShowDialog() == true)
            {
                LoadProducts();
            }
        }
        private void ProductsList_MouseDoubleClick(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (_currentUser?.RoleId != 1)
            {
                return;
            }

            if (ProductsList.SelectedItem is ProductCard card)
            {
                ProductAddWindow window = new ProductAddWindow(card.Id);
                window.Owner = this;

                if (window.ShowDialog() == true)
                {
                    LoadProducts();
                }
            }
        }
        public class ProductCard
        {
            public int Id { get; set; } 
            public string Name { get; set; }
            public string Description { get; set; }
            public int Quantity { get; set; }
            public int Sale { get; set; }
            public decimal PriceValue { get; set; } 
            public string CategoryName { get; set; }
            public string ManufacturerName { get; set; }
            public string SupplierName { get; set; }
            public string UnitName { get; set; }
            public string PhotoPath { get; set; }
            public string OldPriceText { get; set; }
            public string NewPriceText { get; set; }
            public string CardColor { get; set; }
            public bool IsAdmin { get; set; }
        }

        private void SearchBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            ApplyFilters();
        }

        private void SortBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ApplyFilters();
        }

        private void DiscountBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ApplyFilters();
        }
    }
}

