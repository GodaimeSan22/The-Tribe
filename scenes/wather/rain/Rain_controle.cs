using Godot;

public partial class Rain_controle : StaticBody2D
{
	public bool currentWeather = false; 

	private Timer timer;

	public override void _Ready()
	{
		var rainParticles = GetNode<Node2D>("RainParticles");
		var rainShading = GetNode<Node2D>("RainShading");

		if (!currentWeather)
		{
			rainParticles.Visible = false;
			rainShading.Visible = false;
		}
		else
		{
			rainParticles.Visible = true;
			rainShading.Visible = true;
		}

		timer = new Timer();
		AddChild(timer);
		timer.Start(); 

		timer.Timeout += () =>
		{
			currentWeather = !currentWeather;

			rainParticles.Visible = currentWeather;
			rainShading.Visible = currentWeather;

			// output status to the console
			GD.Print("Weather Changed: " + (currentWeather ? "Rainy" : "Clear"));

			if (currentWeather)
			{
				// if wather is rainy
				timer.WaitTime = 20.0f;
			}
			else
			{
				// if wather is clear
				timer.WaitTime = 120.0f;
			}
			timer.Start();
		};

		timer.WaitTime = currentWeather ? 20.0f : 120.0f;
	}
}
