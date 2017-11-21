using Xamarin.Forms;
using Microsoft.AppCenter;
using Microsoft.AppCenter.Analytics;
using Microsoft.AppCenter.Crashes;


namespace HelloWorldTestApp
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();

            MainPage = new HelloWorldTestAppPage();
            AppCenter.Start("ios=29dcf38a-faf6-4571-a35a-ffcf2cbf3f97;" + "android={Your Android App secret here}",
                   typeof(Analytics), typeof(Crashes));
        }

        protected override void OnStart()
        {
            // Handle when your app starts
        }

        protected override void OnSleep()
        {
            // Handle when your app sleeps
        }

        protected override void OnResume()
        {
            // Handle when your app resumes
        }
    }
}
