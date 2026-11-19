using ReadCity.Models;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Microsoft.EntityFrameworkCore;

namespace ReadCity
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Login_Click(object sender, RoutedEventArgs e)
        {
            using var db = new DBContext();
            //загрузка пользователя с его ролью
            var user = db.Users
                .Include(u => u.Role)
                .FirstOrDefault(u => u.Login == LoginBox.Text && u.Password == PasswordBox.Password);

            if (user == null)
            {
                MessageBox.Show("Неверный логин или пароль!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            new CatalogWindow(user).Show();
            Close();
        }

        private void Guest_Click(object sender, RoutedEventArgs e)
        {
            new CatalogWindow(null).Show();
            Close();
        }
    }
}