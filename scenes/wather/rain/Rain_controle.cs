using Godot;

public partial class Rain_controle : StaticBody2D
{
	public bool currentWeather = false;

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
	}
}
