using System;

public class Roda
{
    public int Impulso { get; set; }
    public float RadialSpeed { get; set; } = 0;
    public float RadialAceleration { get; set; } = 0;
    public float Speed => RadialSpeed;

    public void Update(
        float delta,
        float pesoDoCarro,
        float velocidadeMaxima,
        float tempoDeAceleracao
    )
    {
        if (Impulso == 1)
        {
            RadialSpeed +=
                delta * (velocidadeMaxima - RadialSpeed) * (1000f / tempoDeAceleracao) * Impulso;
        }
        else
        {
            RadialSpeed +=
                delta * (velocidadeMaxima + RadialSpeed) * (1000f / tempoDeAceleracao) * Impulso;
        }

        // if (RadialSpeed > velocidadeMaxima)
        // {
        //     RadialSpeed = velocidadeMaxima;
        // }
        // else if (RadialSpeed < -velocidadeMaxima)
        // {
        //     RadialSpeed = -velocidadeMaxima;
        // }
    }
}
