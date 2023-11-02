using Godot;

public class DiagnosticosInfo
{
    public Vector2 Posicao { get; set; }
    public Vector2 VelocidadeRadial { get; set; }
    public Vector2I Impulso { get; set; }
    public float DiametroDaRoda { get; set; }
    public float DistanciaEntreRodas { get; set; }
    public float VelocidadeMaxima { get; set; }
    public float VelocidadeAtual { get; set; }
    public float VelocidadeAngular { get; set; }
    public float TempoDeAceleracao { get; set; }
    public float PesoDoCarro { get; set; }
    public float DeltaTime { get; set; }
    public Testes Testador { get; set; }
    public string[] TesteAtual { get; set; }
}
