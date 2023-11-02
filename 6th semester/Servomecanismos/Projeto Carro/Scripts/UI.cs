using Godot;
using System;

public partial class UI : CanvasLayer, ICarroDiagnosticos
{
    private DiagnosticosInfo _diagnosticosInfo = new();

    [Export]
    private Label[] _textos;

    [Export]
    private Carro _carro;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        _carro.OnCarroUpdateEvent += OnCarroUpdate;
        for (int i = 0; i < _textos.Length; i++)
        {
            // GD.Print(_textos.Length);
            _textos[i].Position = new Vector2(1750, 50f * i);
        }
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
    {
        _textos[0].Text = "Diagnosticos:";
        _textos[2].Text = $"Peso: {_diagnosticosInfo.PesoDoCarro.ToString("0.0")} g";
        _textos[3].Text = $"V_Max: {_diagnosticosInfo.VelocidadeMaxima.ToString("0.00")} mm/s";
        _textos[4].Text = $"Diametro roda: {_diagnosticosInfo.DiametroDaRoda.ToString("0.00")} mm";
        _textos[5].Text =
            $"Distancia eixos: {_diagnosticosInfo.DistanciaEntreRodas.ToString("0.00")} mm";

        _textos[7].Text = "Variaveis de estado";
        _textos[9].Text = $"V_Linear: {_diagnosticosInfo.VelocidadeAtual.ToString("0.00")} mm/s";
        _textos[10].Text = $"V_Ang: {_diagnosticosInfo.VelocidadeAngular.ToString("0.00")} rad/s";
    }

    public void OnCarroUpdate(object sender, DiagnosticosInfo e)
    {
        _diagnosticosInfo = e;
    }
}
