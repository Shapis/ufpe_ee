using System.Collections.Generic;
using Godot;
using System.Linq;
using System;

public class Testes
{
    private Carro _carro;
    private List<Vector3I> _signalBuilder = new List<Vector3I>();
    private float _Ts;
    private float _n = 0;
    private List<float> valores = new List<float>();
    private float? _valor1Ts = null;
    private float? _valor5Ts = null;
    private Vector2? _posicaoInicial = null;

    public Testes(Carro carro)
    {
        _carro = carro;
    }

    public Vector2I SignalBuilder = new Vector2I();
    private float _timeSinceTestStarted;

    // Teste de velocidade, este teste inicia ambas rodas com degrau ligado, e analisa sua velocidade apos 1 Ts, e 5 Ts, esta deve ser respectivamente 63.2% da velocidade maxima, e 99.3% da velocidade maxima
    public void VelocidadeCentral()
    {
        GD.Print(_carro.Position);
        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de velocidade";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"1 Ts: {_valor1Ts} mm/s";
        _carro.TextosParaTeste[4].Text = $"% V Max: {_valor1Ts / _carro._velocidadeMaxima}";
        _carro.TextosParaTeste[5].Text = $"5 Ts: {_valor5Ts} mm/s";
        _carro.TextosParaTeste[6].Text = $"% V Max: {_valor5Ts / _carro._velocidadeMaxima}";

        _Ts = _carro.TempoDeAceleracao / 1000f;
        _carro.AutoPilot = true;

        if (_carro.ElapsedTime >= 3 + _Ts * 10)
        {
            _carro.ElapsedTime = 3;
        }
        else if (_carro.ElapsedTime >= 3 + _Ts * 5)
        {
            if (_valor5Ts == null)
            {
                _valor5Ts = _carro._sumVelocity;
            }

            _carro._RodaDireita.Impulso = -1;
            _carro._RodaEsquerda.Impulso = -1;
        }
        else if (_carro.ElapsedTime >= 3 + _Ts)
        {
            if (_valor1Ts == null)
            {
                _valor1Ts = _carro._sumVelocity;
            }
        }
        else if (_carro.ElapsedTime >= 3)
        {
            _carro._RodaDireita.Impulso = 1;
            _carro._RodaEsquerda.Impulso = 1;
        }
    }

    public void MeiaRotacao()
    {
        if (_posicaoInicial == null)
        {
            _posicaoInicial = _carro.Position;
        }
        GD.Print(_posicaoInicial - _carro.Position);
        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de rotacao maxima";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"1 Ts: {_valor1Ts} rad/s";
        _carro.TextosParaTeste[4].Text =
            $"% θ Max: {_valor1Ts / (_carro._velocidadeMaxima / (0.5 * _carro._distanciaEntreRodas))}";
        _carro.TextosParaTeste[5].Text = $"5 Ts: {_valor5Ts} rad/s";
        _carro.TextosParaTeste[6].Text =
            $"% θ Max: {_valor5Ts / (_carro._velocidadeMaxima / (0.5 * _carro._distanciaEntreRodas))}";

        _Ts = _carro.TempoDeAceleracao / 1000f;
        _carro.AutoPilot = true;

        if (_carro.ElapsedTime >= 3 + _Ts * 10)
        {
            _carro.ElapsedTime = 3;
        }
        else if (_carro.ElapsedTime >= 3 + _Ts * 5)
        {
            if (_valor5Ts == null)
            {
                _carro.Charts[0].SetProcess(false);
                _carro.Charts[1].SetProcess(false);
                _valor5Ts = _carro._diffVelocity;
            }
        }
        else if (_carro.ElapsedTime >= 3 + _Ts)
        {
            if (_valor1Ts == null)
            {
                _valor1Ts = _carro._diffVelocity;
            }
        }
        else if (_carro.ElapsedTime >= 3)
        {
            _carro._RodaDireita.Impulso = 1;
            //_carro._RodaEsquerda.Impulso = -1;
        }
    }

    public void RotacaoMaxima()
    {
        if (_posicaoInicial == null)
        {
            _posicaoInicial = _carro.Position;
        }
        GD.Print(_posicaoInicial - _carro.Position);
        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de rotacao maxima";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"1 Ts: {_valor1Ts} rad/s";
        _carro.TextosParaTeste[4].Text =
            $"% θ Max: {_valor1Ts / (_carro._velocidadeMaxima / (0.5 * _carro._distanciaEntreRodas))}";
        _carro.TextosParaTeste[5].Text = $"5 Ts: {_valor5Ts} rad/s";
        _carro.TextosParaTeste[6].Text =
            $"% θ Max: {_valor5Ts / (_carro._velocidadeMaxima / (0.5 * _carro._distanciaEntreRodas))}";

        _Ts = _carro.TempoDeAceleracao / 1000f;
        _carro.AutoPilot = true;

        if (_carro.ElapsedTime >= 3 + _Ts * 10)
        {
            _carro.ElapsedTime = 3;
        }
        else if (_carro.ElapsedTime >= 3 + _Ts * 5)
        {
            if (_valor5Ts == null)
            {
                _carro.Charts[0].SetProcess(false);
                _carro.Charts[1].SetProcess(false);
                _valor5Ts = _carro._diffVelocity;
            }
        }
        else if (_carro.ElapsedTime >= 3 + _Ts)
        {
            if (_valor1Ts == null)
            {
                _valor1Ts = _carro._diffVelocity;
            }
        }
        else if (_carro.ElapsedTime >= 3)
        {
            _carro._RodaDireita.Impulso = 1;
            _carro._RodaEsquerda.Impulso = -1;
        }
    }

    public void RotacaoMaximaCiclica()
    {
        if (_posicaoInicial == null)
        {
            _posicaoInicial = _carro.Position;
        }
        GD.Print(_posicaoInicial - _carro.Position);
        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de rotacao maxima";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"1 Ts: {_valor1Ts} rad/s";
        _carro.TextosParaTeste[4].Text =
            $"% θ Max: {_valor1Ts / (_carro._velocidadeMaxima / (0.5 * _carro._distanciaEntreRodas))}";
        _carro.TextosParaTeste[5].Text = $"5 Ts: {_valor5Ts} rad/s";
        _carro.TextosParaTeste[6].Text =
            $"% θ Max: {_valor5Ts / (_carro._velocidadeMaxima / (0.5 * _carro._distanciaEntreRodas))}";

        _Ts = _carro.TempoDeAceleracao / 1000f;
        _carro.AutoPilot = true;

        if (_carro.ElapsedTime >= 3 + _Ts * 10)
        {
            _carro.ElapsedTime = 3;
        }
        else if (_carro.ElapsedTime >= 3 + _Ts * 5)
        {
            _carro._RodaDireita.Impulso = -1;
            _carro._RodaEsquerda.Impulso = 1;
            if (_valor5Ts == null)
            {
                _valor5Ts = _carro._diffVelocity;
            }
        }
        else if (_carro.ElapsedTime >= 3 + _Ts)
        {
            if (_valor1Ts == null)
            {
                _valor1Ts = _carro._diffVelocity;
            }
        }
        else if (_carro.ElapsedTime >= 3)
        {
            _carro._RodaDireita.Impulso = 1;
            _carro._RodaEsquerda.Impulso = -1;
        }
    }

    float ultimaRotacaoTempo = 0;
    float ultimaRotMax = 0;

    public void RotacaoAntiH()
    {
        _carro.AutoPilot = true; // Usado para desabilitar o controle pelo teclado

        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de rotacao maxima";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"Pos: {(_carro.Position - _posicaoInicial)}";
        _carro.TextosParaTeste[4].Text = "";
        _carro.TextosParaTeste[5].Text =
            $"T: {Math.Round(_carro.ElapsedTime - ultimaRotacaoTempo, 2)}s";
        _carro.TextosParaTeste[6].Text = $"T: {Math.Round(ultimaRotMax, 2)}s";

        if (_carro.ElapsedTime >= 3)
        {
            if (Math.Abs(_carro.Rotation) >= 2f * (float)Math.PI)
            {
                _carro.Rotation = 0;
                ultimaRotMax = (float)_carro.ElapsedTime - ultimaRotacaoTempo;
                ultimaRotacaoTempo = (float)_carro.ElapsedTime;
            }
            if (_posicaoInicial == null)
            {
                _posicaoInicial = _carro.Position;
            }
            _carro._RodaDireita.Impulso = 1;
            _carro._RodaEsquerda.Impulso = -1;
        }
    }

    public void RotacaoH()
    {
        _carro.AutoPilot = true; // Usado para desabilitar o controle pelo teclado

        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de rotacao maxima";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"Pos: {(_carro.Position - _posicaoInicial)}";
        _carro.TextosParaTeste[4].Text = "";
        _carro.TextosParaTeste[5].Text =
            $"T: {Math.Round(_carro.ElapsedTime - ultimaRotacaoTempo, 2)}s";
        _carro.TextosParaTeste[6].Text = $"T: {Math.Round(ultimaRotMax, 2)}s";

        if (_carro.ElapsedTime >= 3)
        {
            if (Math.Abs(_carro.Rotation) >= 2f * (float)Math.PI)
            {
                _carro.Rotation = 0;
                ultimaRotMax = (float)_carro.ElapsedTime - ultimaRotacaoTempo;
                ultimaRotacaoTempo = (float)_carro.ElapsedTime;
            }
            if (_posicaoInicial == null)
            {
                _posicaoInicial = _carro.Position;
            }
            _carro._RodaDireita.Impulso = -1;
            _carro._RodaEsquerda.Impulso = 1;
        }
    }

    int tempoInt = 0;
    Vector2? ultimaPosicao = new Vector2();
    Vector2? posicaoAtual = new Vector2();
    float distanciaPercorrida = 0;

    public void VCentralFrente()
    {
        if (_posicaoInicial == null)
        {
            _posicaoInicial = _carro.Position;
        }
        posicaoAtual = _carro.Position - _posicaoInicial;
        _carro.AutoPilot = true; // Usado para desabilitar o controle pelo teclado

        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de velocidade";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"Pos X: {(Math.Round(posicaoAtual.Value.X, 0))}";
        _carro.TextosParaTeste[4].Text = $"Pos Y: {(Math.Round(posicaoAtual.Value.Y, 0))}";
        _carro.TextosParaTeste[5].Text = $"T: {tempoInt}s";
        _carro.TextosParaTeste[6].Text = $"Dist: {distanciaPercorrida}mm";

        posicaoAtual = _carro.Position - _posicaoInicial;

        if (_carro.ElapsedTime >= tempoInt)
        {
            distanciaPercorrida = (float)
                Math.Sqrt(
                    (float)Math.Pow(posicaoAtual.Value.X - ultimaPosicao.Value.X, 2)
                        + (float)Math.Pow(posicaoAtual.Value.Y - ultimaPosicao.Value.Y, 2)
                );
            distanciaPercorrida = (float)Math.Round(distanciaPercorrida, 2);
            ultimaPosicao = posicaoAtual;
        }

        if (_carro.ElapsedTime >= 3)
        {
            _carro._RodaDireita.Impulso = 1;
            _carro._RodaEsquerda.Impulso = 1;
        }
        tempoInt = (int)Math.Ceiling(_carro.ElapsedTime);
    }

    public void VCentralTras()
    {
        if (_posicaoInicial == null)
        {
            _posicaoInicial = _carro.Position;
        }
        posicaoAtual = _carro.Position - _posicaoInicial;
        _carro.AutoPilot = true; // Usado para desabilitar o controle pelo teclado

        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de velocidade";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"Pos X: {(Math.Round(posicaoAtual.Value.X, 0))}";
        _carro.TextosParaTeste[4].Text = $"Pos Y: {(Math.Round(posicaoAtual.Value.Y, 0))}";
        _carro.TextosParaTeste[5].Text = $"T: {tempoInt}s";
        _carro.TextosParaTeste[6].Text = $"Dist: {distanciaPercorrida}mm";

        posicaoAtual = _carro.Position - _posicaoInicial;

        if (_carro.ElapsedTime >= tempoInt)
        {
            distanciaPercorrida = (float)
                Math.Sqrt(
                    (float)Math.Pow(posicaoAtual.Value.X - ultimaPosicao.Value.X, 2)
                        + (float)Math.Pow(posicaoAtual.Value.Y - ultimaPosicao.Value.Y, 2)
                );
            distanciaPercorrida = (float)Math.Round(distanciaPercorrida, 2);
            ultimaPosicao = posicaoAtual;
        }

        if (_carro.ElapsedTime >= 3)
        {
            _carro._RodaDireita.Impulso = -1;
            _carro._RodaEsquerda.Impulso = -1;
        }
        tempoInt = (int)Math.Ceiling(_carro.ElapsedTime);
    }

    public void VCentralMeiaRotacaoDP()
    {
        if (_posicaoInicial == null)
        {
            _posicaoInicial = _carro.Position;
        }
        posicaoAtual = _carro.Position - _posicaoInicial;
        _carro.AutoPilot = true; // Usado para desabilitar o controle pelo teclado

        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de meia rotacao";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"Pos X: {(Math.Round(posicaoAtual.Value.X, 0))}";
        _carro.TextosParaTeste[4].Text = $"Pos Y: {(Math.Round(posicaoAtual.Value.Y, 0))}";
        _carro.TextosParaTeste[5].Text =
            $"T: {Math.Round(_carro.ElapsedTime - ultimaRotacaoTempo, 2)}s";
        _carro.TextosParaTeste[6].Text = $"T: {Math.Round(ultimaRotMax, 2)}s";

        if (_carro.ElapsedTime >= tempoInt)
        {
            distanciaPercorrida = (float)
                Math.Sqrt(
                    (float)Math.Pow(posicaoAtual.Value.X - ultimaPosicao.Value.X, 2)
                        + (float)Math.Pow(posicaoAtual.Value.Y - ultimaPosicao.Value.Y, 2)
                );
            distanciaPercorrida = (float)Math.Round(distanciaPercorrida, 2);
            ultimaPosicao = posicaoAtual;
        }

        if (_carro.ElapsedTime >= 3)
        {
            if (Math.Abs(_carro.Rotation) >= 2f * (float)Math.PI)
            {
                _carro.Rotation = 0;
                ultimaRotMax = (float)_carro.ElapsedTime - ultimaRotacaoTempo;
                ultimaRotacaoTempo = (float)_carro.ElapsedTime;
            }

            _carro._RodaDireita.Impulso = 1;
            _carro._RodaEsquerda.Impulso = 0;
        }
        tempoInt = (int)Math.Ceiling(_carro.ElapsedTime);
    }

    public void VCentralMeiaRotacaoEP()
    {
        if (_posicaoInicial == null)
        {
            _posicaoInicial = _carro.Position;
        }
        posicaoAtual = _carro.Position - _posicaoInicial;
        _carro.AutoPilot = true; // Usado para desabilitar o controle pelo teclado

        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de meia rotacao";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"Pos X: {(Math.Round(posicaoAtual.Value.X, 0))}";
        _carro.TextosParaTeste[4].Text = $"Pos Y: {(Math.Round(posicaoAtual.Value.Y, 0))}";
        _carro.TextosParaTeste[5].Text =
            $"T: {Math.Round(_carro.ElapsedTime - ultimaRotacaoTempo, 2)}s";
        _carro.TextosParaTeste[6].Text = $"T: {Math.Round(ultimaRotMax, 2)}s";

        if (_carro.ElapsedTime >= tempoInt)
        {
            distanciaPercorrida = (float)
                Math.Sqrt(
                    (float)Math.Pow(posicaoAtual.Value.X - ultimaPosicao.Value.X, 2)
                        + (float)Math.Pow(posicaoAtual.Value.Y - ultimaPosicao.Value.Y, 2)
                );
            distanciaPercorrida = (float)Math.Round(distanciaPercorrida, 2);
            ultimaPosicao = posicaoAtual;
        }

        if (_carro.ElapsedTime >= 3)
        {
            if (Math.Abs(_carro.Rotation) >= 2f * (float)Math.PI)
            {
                _carro.Rotation = 0;
                ultimaRotMax = (float)_carro.ElapsedTime - ultimaRotacaoTempo;
                ultimaRotacaoTempo = (float)_carro.ElapsedTime;
            }

            _carro._RodaDireita.Impulso = 0;
            _carro._RodaEsquerda.Impulso = 1;
        }
        tempoInt = (int)Math.Ceiling(_carro.ElapsedTime);
    }

    public void VCentralMeiaRotacaoEN()
    {
        if (_posicaoInicial == null)
        {
            _posicaoInicial = _carro.Position;
        }
        posicaoAtual = _carro.Position - _posicaoInicial;
        _carro.AutoPilot = true; // Usado para desabilitar o controle pelo teclado

        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de meia rotacao";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"Pos X: {(Math.Round(posicaoAtual.Value.X, 0))}";
        _carro.TextosParaTeste[4].Text = $"Pos Y: {(Math.Round(posicaoAtual.Value.Y, 0))}";
        _carro.TextosParaTeste[5].Text =
            $"T: {Math.Round(_carro.ElapsedTime - ultimaRotacaoTempo, 2)}s";
        _carro.TextosParaTeste[6].Text = $"T: {Math.Round(ultimaRotMax, 2)}s";

        if (_carro.ElapsedTime >= tempoInt)
        {
            distanciaPercorrida = (float)
                Math.Sqrt(
                    (float)Math.Pow(posicaoAtual.Value.X - ultimaPosicao.Value.X, 2)
                        + (float)Math.Pow(posicaoAtual.Value.Y - ultimaPosicao.Value.Y, 2)
                );
            distanciaPercorrida = (float)Math.Round(distanciaPercorrida, 2);
            ultimaPosicao = posicaoAtual;
        }

        if (_carro.ElapsedTime >= 3)
        {
            if (Math.Abs(_carro.Rotation) >= 2f * (float)Math.PI)
            {
                _carro.Rotation = 0;
                ultimaRotMax = (float)_carro.ElapsedTime - ultimaRotacaoTempo;
                ultimaRotacaoTempo = (float)_carro.ElapsedTime;
            }

            _carro._RodaDireita.Impulso = 0;
            _carro._RodaEsquerda.Impulso = -1;
        }
        tempoInt = (int)Math.Ceiling(_carro.ElapsedTime);
    }

    public void VCentralMeiaRotacaoDN()
    {
        if (_posicaoInicial == null)
        {
            _posicaoInicial = _carro.Position;
        }
        posicaoAtual = _carro.Position - _posicaoInicial;
        _carro.AutoPilot = true; // Usado para desabilitar o controle pelo teclado

        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de meia rotacao";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"Pos X: {(Math.Round(posicaoAtual.Value.X, 0))}";
        _carro.TextosParaTeste[4].Text = $"Pos Y: {(Math.Round(posicaoAtual.Value.Y, 0))}";
        _carro.TextosParaTeste[5].Text =
            $"T: {Math.Round(_carro.ElapsedTime - ultimaRotacaoTempo, 2)}s";
        _carro.TextosParaTeste[6].Text = $"T: {Math.Round(ultimaRotMax, 2)}s";

        if (_carro.ElapsedTime >= tempoInt)
        {
            distanciaPercorrida = (float)
                Math.Sqrt(
                    (float)Math.Pow(posicaoAtual.Value.X - ultimaPosicao.Value.X, 2)
                        + (float)Math.Pow(posicaoAtual.Value.Y - ultimaPosicao.Value.Y, 2)
                );
            distanciaPercorrida = (float)Math.Round(distanciaPercorrida, 2);
            ultimaPosicao = posicaoAtual;
        }

        if (_carro.ElapsedTime >= 3)
        {
            if (Math.Abs(_carro.Rotation) >= 2f * (float)Math.PI)
            {
                _carro.Rotation = 0;
                ultimaRotMax = (float)_carro.ElapsedTime - ultimaRotacaoTempo;
                ultimaRotacaoTempo = (float)_carro.ElapsedTime;
            }

            _carro._RodaDireita.Impulso = -1;
            _carro._RodaEsquerda.Impulso = 0;
        }
        tempoInt = (int)Math.Ceiling(_carro.ElapsedTime);
    }

    public void VCentralMeiaRotacaoLivre()
    {
        if (_posicaoInicial == null)
        {
            _posicaoInicial = _carro.Position;
        }
        posicaoAtual = _carro.Position - _posicaoInicial;
        // _carro.AutoPilot = true; // Usado para desabilitar o controle pelo teclado

        _carro.TextosParaTeste[0].Text = "";
        _carro.TextosParaTeste[1].Text = "Teste de meia rotacao";
        _carro.TextosParaTeste[2].Text = "";
        _carro.TextosParaTeste[3].Text = $"Pos X: {(Math.Round(posicaoAtual.Value.X, 0))}";
        _carro.TextosParaTeste[4].Text = $"Pos Y: {(Math.Round(posicaoAtual.Value.Y, 0))}";
        _carro.TextosParaTeste[5].Text =
            $"T: {Math.Round(_carro.ElapsedTime - ultimaRotacaoTempo, 2)}s";
        _carro.TextosParaTeste[6].Text = $"T: {Math.Round(ultimaRotMax, 2)}s";

        if (_carro.ElapsedTime >= tempoInt)
        {
            distanciaPercorrida = (float)
                Math.Sqrt(
                    (float)Math.Pow(posicaoAtual.Value.X - ultimaPosicao.Value.X, 2)
                        + (float)Math.Pow(posicaoAtual.Value.Y - ultimaPosicao.Value.Y, 2)
                );
            distanciaPercorrida = (float)Math.Round(distanciaPercorrida, 2);
            ultimaPosicao = posicaoAtual;
        }

        if (_carro.ElapsedTime >= 3)
        {
            if (Math.Abs(_carro.Rotation) >= 2f * (float)Math.PI)
            {
                _carro.Rotation = 0;
                ultimaRotMax = (float)_carro.ElapsedTime - ultimaRotacaoTempo;
                ultimaRotacaoTempo = (float)_carro.ElapsedTime;
            }

            // _carro._RodaDireita.Impulso = -1;
            // _carro._RodaEsquerda.Impulso = 0;
        }
        tempoInt = (int)Math.Ceiling(_carro.ElapsedTime);
    }
}
