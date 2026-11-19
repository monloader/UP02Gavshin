using Microsoft.Win32;
using ReadCity.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;


namespace ReadCity
{
    /// <summary>
    /// Логика взаимодействия для ProductAddWindow.xaml
    /// </summary>
    public partial class ProductAddWindow : Window
    {
        private int? _productId; 
        private string? _selectedPhotoPath = null;
        public ProductAddWindow(int? productId)
        {
            InitializeComponent();
            _productId = productId;
            LoadComboBoxes();
            if (_productId.HasValue)
            {
                Title = "Редактирование товара";
                LoadProductData();
                ArticleBox.IsReadOnly = true; 
                ArticleBox.Background = System.Windows.Media.Brushes.LightGray;
            }
            else
            {
                Title = "Добавление товара";
            }
        }
        private void LoadComboBoxes()
        {
            using (var db = new DBContext())
            {
                CategoryBox.ItemsSource = db.Categories.ToList();
                ManufacturerBox.ItemsSource = db.Manufacturers.ToList();
                SupplierBox.ItemsSource = db.Suppliers.ToList();
                UnitBox.ItemsSource = db.Units.ToList();
            }
        }

        private void LoadProductData()
        {
           
                using (var db = new DBContext())
                {
                    var product = db.Products.Find(_productId.Value);
                if (product == null)
                {
                    return;
                }

                ArticleBox.Text = product.Article;
                    NameBox.Text = product.Name;
                    DescriptionBox.Text = product.Description;
                    PriceBox.Text = product.Price.ToString();
                    QuantityBox.Text = product.Quantity.ToString();
                    SaleBox.Text = product.Sale.ToString();

                    CategoryBox.SelectedValue = product.CategoryId;
                    ManufacturerBox.SelectedValue = product.ManufacturerId;
                    SupplierBox.SelectedValue = product.SupplierId;
                    UnitBox.SelectedValue = product.UnitId;

                    if (!string.IsNullOrEmpty(product.Photo))
                    {
                        string imgPath = Path.Combine(CatalogWindow.rootPath, "Images", product.Photo);
                        if (File.Exists(imgPath))
                        {
                            PhotoPreview.Source = new BitmapImage(new Uri(imgPath));
                            _selectedPhotoPath = imgPath; 
                        }
                    }
                }
            }
        

        private void SelectPhotoBtn_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Filter = "Image Files|*.jpg;*.jpeg;*.png;*.bmp";
            if (dialog.ShowDialog() == true)
            {
                _selectedPhotoPath = dialog.FileName;
                PhotoPreview.Source = new BitmapImage(new Uri(_selectedPhotoPath));
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            string articleText = ArticleBox.Text?.Trim();
            if (string.IsNullOrEmpty(articleText))
            {
                MessageBox.Show("Вы не ввели артикул! Поле не может быть пустым");
                return;
            }
            //проверка уникальности артикула
            using (var dbCheck = new DBContext())
            {
                var existingProduct = dbCheck.Products.FirstOrDefault(p => p.Article == articleText);

                if (existingProduct != null)
                {
                    if (!_productId.HasValue || existingProduct.Id != _productId.Value)
                    {
                        MessageBox.Show($"Товар с артикулом '{articleText}' уже существует. Введите другой артикул");
                        return;
                    }
                }

                if (string.IsNullOrWhiteSpace(NameBox.Text))
                {
                    MessageBox.Show("Заполните наименование");
                    return;
                }
                if (CategoryBox.SelectedValue == null || ManufacturerBox.SelectedValue == null ||
                    SupplierBox.SelectedValue == null || UnitBox.SelectedValue == null)
                {
                    MessageBox.Show("Выберите значения во всех выпадающих списках");
                    return;
                }
                if (!decimal.TryParse(PriceBox.Text, out decimal price) || price < 0)
                {
                    MessageBox.Show("Цена должна быть положительным числом");
                    return;
                }
                if (!int.TryParse(QuantityBox.Text, out int quantity) || quantity < 0)
                {
                    MessageBox.Show("Количество не может быть отрицательным");
                    return;
                }
                if (!int.TryParse(SaleBox.Text, out int sale) || sale < 0 || sale > 100)
                {
                    MessageBox.Show("Скидка должна быть от 0 до 100");
                    return;
                }

                string finalPhotoName = null;
                if (_selectedPhotoPath != null)
                {
                    string existingPhotoPath = "";
                    if (_productId.HasValue)
                    {
                        using (var db = new DBContext())
                        {
                            var p = db.Products.Find(_productId.Value);
                            if (p != null && !string.IsNullOrEmpty(p.Photo))
                            {
                                existingPhotoPath = Path.Combine(CatalogWindow.rootPath, "Images", p.Photo);
                            }
                        }
                    }

                    if (_selectedPhotoPath != existingPhotoPath)
                    {
                        finalPhotoName = Guid.NewGuid().ToString() + ".jpg";
                        string savePath = Path.Combine(CatalogWindow.rootPath, "Images", finalPhotoName);

                        try
                        {
                            BitmapImage bmp = new BitmapImage(new Uri(_selectedPhotoPath));
                            //уменьшение размера до 300x200
                            var resized = new TransformedBitmap(bmp, new System.Windows.Media.ScaleTransform(300.0 / bmp.PixelWidth, 200.0 / bmp.PixelHeight));
                            JpegBitmapEncoder encoder = new JpegBitmapEncoder();
                            encoder.Frames.Add(BitmapFrame.Create(resized));
                            using (var fs = new FileStream(savePath, FileMode.Create))
                            {
                                encoder.Save(fs);
                            }
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show($"Ошибка фото: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                            return;
                        }
                    }
                    else
                    {

                        if (_productId.HasValue)
                        {
                            using (var db = new DBContext())
                            {
                                var p = db.Products.Find(_productId.Value);
                                if (p != null)
                                {
                                    finalPhotoName = p.Photo;
                                }
                            }
                        }
                    }
                }

                try
                {
                    using (var db = new DBContext())
                    {
                        Product product;

                        if (_productId.HasValue)
                        {
                            product = db.Products.Find(_productId.Value);
                            if (product == null)
                            {
                                return;
                            }
                        }
                        else
                        {
                            product = new Product();
                        }

                        product.Article = articleText;
                        product.Name = NameBox.Text;
                        product.Description = DescriptionBox.Text;
                        product.Price = price;
                        product.Quantity = quantity;
                        product.Sale = sale;
                        product.CategoryId = (int)CategoryBox.SelectedValue;
                        product.ManufacturerId = (int)ManufacturerBox.SelectedValue;
                        product.SupplierId = (int)SupplierBox.SelectedValue;
                        product.UnitId = (int)UnitBox.SelectedValue;
                        product.Photo = finalPhotoName;

                        if (!_productId.HasValue)
                        {
                            db.Products.Add(product);
                        }

                        db.SaveChanges();
                    }

                    MessageBox.Show(_productId.HasValue ? "Товар обновлен!" : "Товар добавлен!");
                    DialogResult = true;
                }
                catch (Exception ex)
                {
                    string realError = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
                    MessageBox.Show($"Ошибка БД: {realError}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }
        

        private void CancelBtn_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
