using Godot;
using System;

public partial class Carro : Node2D, ICarroDiagnosticos
{
    public event EventHandler<DiagnosticosInfo> OnCarroUpdateEvent;

    #region Inputs
    public Roda _RodaEsquerda = new Roda();
    public Roda _RodaDireita = new Roda();

    private void OnImpulso(int left, int right)
    {
        if (!AutoPilot)
        {
            _RodaEsquerda.Impulso = left;
            _RodaDireita.Impulso = right;
        }
    }
    #endregion

    public enum TipoDeTeste
    {
        Nenhum,
        VelocidadeCentral,
        MeiaRotacao,
        RotacaoMaxima,
        RotacaoMaximaCiclica,
        RotacaoAntiH,
        RotacaoH,
        VCentralFrente,
        VCentralTras,
        VCentralMeiaRotacaoDP,
        VCentralMeiaRotacaoDN,
        VCentralMeiaRotacaoEP,
        VCentralMeiaRotacaoEN,
        VCentralMeiaRotacaoLivre
    }

    #region Exports
    [Export]
    public TipoDeTeste TesteSelecionado = TipoDeTeste.Nenhum;

    [Export]
    private float _diametroDaRoda = 50f;

    [Export]
    public float _distanciaEntreRodas = 200;

    [Export]
    private float _pesoDoCarro = 200; // Gramas

    [Export]
    public float _velocidadeMaxima = 628.318f; // mm/s

    [Export]
    public float TempoDeAceleracao { get; set; } = 500; // milisegundos

    [Export]
    public float EscalaGraph { get; set; } = 1f;

    [Export]
    public Label[] TextosParaTeste;

    [Export]
    public Control[] Charts;

    #endregion

    public bool AutoPilot { get; set; } = false;
    public float _sumVelocity = 0;
    public float _diffVelocity = 0;
    public double ElapsedTime { get; set; } = 0;
    private double _deltaTime = 0;
    public float _rodaEsquerdaVelocidade = 0;
    public float _rodaDireitaVelocidade = 0;
    Testes _testador;

    //private Testes _testador = new Testes(this);

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        Position = new Vector2(-4000, -1600);
        _testador = new Testes(this);
        _velocidadeMaxima = _velocidadeMaxima * (200f / _pesoDoCarro) * (_diametroDaRoda / 50f);
        GetNode<Sprite2D>("roda_esquerda").Position = new Vector2(0, -_distanciaEntreRodas / 2);
        GetNode<Sprite2D>("roda_direita").Position = new Vector2(0, _distanciaEntreRodas / 2);
    }

    public override void _PhysicsProcess(double delta)
    {
        if (Position.X >= 2350)
        {
            Position = new Vector2(-6700, Position.Y);
        }
        else if (Position.X <= -6700)
        {
            Position = new Vector2(2350, Position.Y);
        }
        else if (Position.Y <= -4000)
        {
            Position = new Vector2(Position.X, 800);
        }
        else if (Position.Y >= 800)
        {
            Position = new Vector2(Position.X, -4000);
        }
        _deltaTime = delta;
        ElapsedTime += delta;
        // _RodaDireita.RadialSpeed = -100f * 2f * (float)Math.PI;
        // _RodaEsquerda.RadialSpeed = 100f * 2f * (float)Math.PI;
        _RodaDireita.Update((float)delta, _pesoDoCarro, _velocidadeMaxima, TempoDeAceleracao);
        _RodaEsquerda.Update((float)delta, _pesoDoCarro, _velocidadeMaxima, TempoDeAceleracao);
        _rodaEsquerdaVelocidade = _RodaEsquerda.RadialSpeed;
        _rodaDireitaVelocidade = _RodaDireita.RadialSpeed;
        // _RodaEsquerda.Speed = 100f * (float)Math.PI * 2f;
        // _RodaDireita.Speed = -100f * (float)Math.PI * 2f;

        _sumVelocity = (_RodaEsquerda.RadialSpeed + _RodaDireita.RadialSpeed) / 2f;
        _diffVelocity =
            (_RodaDireita.RadialSpeed - _RodaEsquerda.RadialSpeed) / (_distanciaEntreRodas);

        Rotation -= _diffVelocity * (float)delta;

        Position +=
            new Vector2(
                _sumVelocity * (float)Math.Cos(Rotation),
                _sumVelocity * (float)Math.Sin(Rotation)
            ) * (float)delta;

        // if (Rotation >= 2f * (float)Math.PI)
        // {
        //     Rotation -= 2f * (float)Math.PI;
        //     GD.Print(ElapsedTime);
        // }

        // GD.Print("Posicao: " + Position);
        // GD.Print(Position);
        OnCarroUpdate(
            this,
            new DiagnosticosInfo
            {
                DiametroDaRoda = _diametroDaRoda,
                DistanciaEntreRodas = _distanciaEntreRodas,
                PesoDoCarro = _pesoDoCarro,
                VelocidadeMaxima = _velocidadeMaxima,
                VelocidadeAtual = _sumVelocity,
                Posicao = Position,
                VelocidadeRadial = new Vector2(_RodaEsquerda.RadialSpeed, _RodaDireita.RadialSpeed),
                VelocidadeAngular = _diffVelocity,
                Testador = _testador,
            }
        );
    }

    public sealed override void _Process(double delta)
    {
        switch (TesteSelecionado)
        {
            case TipoDeTeste.VelocidadeCentral:
                _testador.VelocidadeCentral();
                break;
            case TipoDeTeste.MeiaRotacao:
                _testador.MeiaRotacao();
                break;
            case TipoDeTeste.RotacaoMaxima:
                _testador.RotacaoMaxima();
                break;
            case TipoDeTeste.RotacaoMaximaCiclica:
                _testador.RotacaoMaximaCiclica();
                break;
            case TipoDeTeste.RotacaoAntiH:
                _testador.RotacaoAntiH();
                break;
            default:
                //GD.Print(Position);
                break;
            case TipoDeTeste.RotacaoH:
                _testador.RotacaoH();
                break;
            case TipoDeTeste.VCentralFrente:
                _testador.VCentralFrente();
                break;
            case TipoDeTeste.VCentralTras:
                _testador.VCentralTras();
                break;
            case TipoDeTeste.VCentralMeiaRotacaoDP:
                _testador.VCentralMeiaRotacaoDP();
                break;
            case TipoDeTeste.VCentralMeiaRotacaoDN:
                _testador.VCentralMeiaRotacaoDN();
                break;
            case TipoDeTeste.VCentralMeiaRotacaoEP:
                _testador.VCentralMeiaRotacaoEP();
                break;
            case TipoDeTeste.VCentralMeiaRotacaoEN:
                _testador.VCentralMeiaRotacaoEN();
                break;
            case TipoDeTeste.VCentralMeiaRotacaoLivre:
                _testador.VCentralMeiaRotacaoLivre();
                break;
        }
    }

    public void OnCarroUpdate(object sender, DiagnosticosInfo e)
    {
        OnCarroUpdateEvent?.Invoke(this, e);
    }
}
